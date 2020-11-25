class CreateStravaAthletes < ActiveRecord::Migration[6.0]
  def change
    create_table :strava_athletes do |t|
      t.integer :strava_id, unique: true
      t.string :username
      t.integer :resource_state
      t.string :firstname
      t.string :lastname
      t.string :city
      t.string :state
      t.string :country
      t.string :sex
      t.boolean :premium
      t.boolean :summit
      t.datetime :created_at
      t.datetime :updated_at
      t.integer :badge_type_id
      t.string :profile_medium
      t.string :profile
      t.string :friend
      t.string :follower

      # t.timestamps
    end
  end
end
