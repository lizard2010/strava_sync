# == Schema Information
#
# Table name: stravas
#
#  id                :bigint           not null, primary key
#  access_token      :string
#  code              :string
#  expires_at        :integer
#  expires_in        :integer
#  refresh_token     :string
#  scope             :string
#  state             :string
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  strava_athlete_id :integer
#
# Indexes
#
#  index_stravas_on_strava_athlete_id  (strava_athlete_id) UNIQUE
#
class Strava < ApplicationRecord
  require 'rest-client'

  belongs_to :strava_athlete

  attr_accessor :response

  STRAVA_URL = 'https://www.strava.com'
  STRAVA_SCOPES = 'read_all,read,activity:read_all,activity:write'
  STRAVA_CALL_CODE = ['state', 'code', 'scope']
  STRAVA_TOKENS = %i[expires_at expires_in refresh_token access_token]

  class << self
    def grant_request_url
      @strava_grant_request_url = generate_url("#{STRAVA_URL}/oauth/authorize", {
        client_id: ENV['STRAVA_CLIENT_ID'],
        redirect_uri: 'http://127.0.0.1:3000/strava/code',
        response_type: 'code',
        approval_prompt: 'auto',
        scope: STRAVA_SCOPES
      })
    end

    def generate_url(url, params = {})
      uri = URI(url)
      uri.query = params.to_query
      uri.to_s
    end

    def authorize
      api_call(:get, set_api_url)
    end

    def api_call(method, url, data = {}, token = nil, headers = {})
      headers[:Authorization] = "Bearer #{token.presence || ENV['STRAVA_ACCESS_TOKEN']}"
      begin
        RestClient::Request.execute(method: method, url: url, payload: data, headers: headers, max_redirects: 0)
      rescue RestClient::ExceptionWithResponse => e
        ap e.response.body
        e.response
      end
    end
  end

  def get_authorization_token
    self.class.api_call(:post, "#{STRAVA_URL}/api/v3/oauth/token", {
      client_id: ENV['STRAVA_CLIENT_ID'],
      client_secret: ENV['STRAVA_CLIENT_SECRET'],
      code: code,
      grant_type: 'authorization_code'
      }).body
  end

  def refresh_token_call(force=false)
    return unless force || DateTime.now + 1.second >= Time.at(expires_at)

    body = self.class.api_call(:post, "#{STRAVA_URL}/api/v3/oauth/token", {
      client_id: ENV['STRAVA_CLIENT_ID'],
      client_secret: ENV['STRAVA_CLIENT_SECRET'],
      refresh_token: read_attribute(:refresh_token),
      grant_type: 'refresh_token'
      })

    return unless body

    response = JSON.parse body.body, symbolize_names: true
    update(response.slice(*Strava::STRAVA_TOKENS))
  end

  def error_catch(response)
    return nil unless response[:errors].present?

    response[:errors].map { |x| x.values.flatten.delete_if(&:empty?).join(' ') }.join(', ')
  end

  def save_athlete(athlete_params)
    self.strava_athlete = StravaAthlete.create_from_json athlete_params
    if strava_athlete.new_record?
      save!
      self
    else
      Strava.find_by(strava_athlete: strava_athlete)
    end
  end

  def get_activities_call
    code = self.class.api_call(:get, self.class.generate_url("#{STRAVA_URL}/api/v3/athlete/activities", {
       before: DateTime.new(2020,11, 26).to_i,
       after: DateTime.new(2020,11, 01).to_i,
       page: 1,
       per_page: 5
    }), {}, access_token)
    ap JSON.parse(code.body, symbolize_names: true)
    # error_catch(code.body)
  end
end
