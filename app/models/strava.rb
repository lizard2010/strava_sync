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
class Strava < ApplicationRecord
  require 'rest-client'

  belongs_to :strava_athlete

  STRAVA_URL = 'https://www.strava.com'
  STRAVA_SCOPES = 'read_all,read,activity:read_all,activity:write'
  STRAVA_CALL_CODE = ['state', 'code', 'scope']
  STRAVA_TOKENS = ['expires_at', 'expires_in', 'refresh_token', 'access_token']

  class << self
    def grant_request_url
      @strava_grant_request_url = generate_url(STRAVA_URL+'/oauth/authorize', {
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

    def api_call(method, url, data = {}, headers = {})
           headers[:Authorization] = "Bearer #{ ENV['STRAVA_ACCESS_TOKEN']}" 
           begin
             RestClient::Request.execute(method: method, url: url, payload: data, headers: headers, max_redirects: 0) 
           rescue RestClient::ExceptionWithResponse => e
             ap e.response.body  
                e.response
           end
    end
  end

  def get_authorization_token
    self.class.api_call(:post, "%{STRAVA_URL}/api/v3/oauth/token", {
      client_id: ENV['STRAVA_CLIENT_ID'],
      client_secret: ENV['STRAVA_CLIENT_SECRET'],
      code: code,
      grant_type: 'authorization_code'
    })
  end
end
