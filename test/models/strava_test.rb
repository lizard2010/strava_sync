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
require 'test_helper'

class StravaTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
