# == Schema Information
#
# Table name: stravas
#
#  id            :bigint           not null, primary key
#  access_token  :string
#  code          :string
#  expires_at    :integer
#  expires_in   :integer
#  refresh_token :string
#  scope         :string
#  state         :string
#  created_at    :datetime         not null
#  updated_at    :datetime         not null   
#
#
# {:token_type=>"Bearer",
#   :expires_at=>1605735829,
#   :expires_in=>20652,
#   :refresh_token=>"db8b49ad425812476252ab133c0ad7b69b21df29",
#   :access_token=>"eb402d583f0ca2b033c4e8774d1e00ff5546d6d3",
#   :athlete=>{"id"=>16146780,
#     "username"=>"sserogin",
#     "resource_state"=>2,
#     "firstname"=>"Sergii",
#     "lastname"=>"Serogin",
#     "city"=>"", "state"=>"",
#     "country"=>"",
#     "sex"=>"M",
#     "premium"=>false,
#     "summit"=>false,
#     "created_at"=>"2016-07-04T20:54:48Z",
#     "updated_at"=>"2020-08-07T11:49:26Z",
#     "badge_type_id"=>0,
#     "profile_medium"=>"https://graph.facebook.com/1216790418382255/picture?height=256&width=256",
#     "profile"=>"https://graph.facebook.com/1216790418382255/picture?height=256&width=256",
#     "friend"=>nil,
#     "follower"=>nil}}
class Strava < ApplicationRecord
  require 'rest-client'
  
  STRAVA_URL = 'https://www.strava.com'
  STRAVA_SCOPES = 'read_all,read,activity:read_all,activity:write'
  STRAVA_CALL_CODE = ['state', 'code', 'scope']
  STRAVA_TOKENS = ['expires_at', 'expires_in', 'refresh_token', 'access_token'  ]
  
  
  class << self
  
    def grant_request_url
      @strava_grant_request_url = generate_url(STRAVA_URL+'/oauth/authorize', {
        client_id: ENV['STRAVA_CLIENT_ID'], 
        redirect_uri: 'http://127.0.0.1:3000/',
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
    self.class.api_call(:post, STRAVA_URL+'/api/v3/oauth/token', {
      client_id: ENV['STRAVA_CLIENT_ID'],
      client_secret: ENV['STRAVA_CLIENT_SECRET'],
      code: code,
      grant_type: 'authorization_code'
    })
  end
end
