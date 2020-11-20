json.extract! strava, :id, :created_at, :updated_at
json.url strava_url(strava, format: :json)
