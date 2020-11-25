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
require 'test_helper'

class StravaAthleteTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
