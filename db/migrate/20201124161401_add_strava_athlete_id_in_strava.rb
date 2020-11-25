class AddStravaAthleteIdInStrava < ActiveRecord::Migration[6.0]
  def change
    add_column :stravas, :strava_athlete_id, :integer
  end
end
