class AddIndexToStravaAthletes < ActiveRecord::Migration[6.0]
  def change
    add_index :strava_athletes, :strava_id, unique: true
  end
end
