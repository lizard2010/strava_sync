# == Schema Information
#
# Table name: strava_athletes
#
#  id             :bigint           not null, primary key
#  city           :string
#  country        :string
#  firstname      :string
#  follower       :string
#  friend         :string
#  lastname       :string
#  premium        :boolean
#  profile        :string
#  profile_medium :string
#  resource_state :integer
#  sex            :string
#  state          :string
#  summit         :boolean
#  username       :string
#  created_at     :datetime
#  updated_at     :datetime
#  badge_type_id  :integer
#  strava_id      :integer
#
# Indexes
#
#  index_strava_athletes_on_strava_id  (strava_id) UNIQUE
#
class StravaAthlete < ApplicationRecord
  has_one :strava

  def self.create_from_json(data)
    data[:strava_id] = data.delete(:id)
    find_or_initialize_by(data)
  end
end
