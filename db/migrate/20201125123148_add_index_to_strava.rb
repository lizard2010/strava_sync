class AddIndexToStrava < ActiveRecord::Migration[6.0]
  def change
    add_index :stravas, :strava_athlete_id, unique: true
  end
end
