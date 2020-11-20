require 'test_helper'

class StravasControllerTest < ActionDispatch::IntegrationTest
  setup do
    @strava = stravas(:one)
  end

  test "should get index" do
    get stravas_url
    assert_response :success
  end

  test "should get new" do
    get new_strava_url
    assert_response :success
  end

  test "should create strava" do
    assert_difference('Strava.count') do
      post stravas_url, params: { strava: {  } }
    end

    assert_redirected_to strava_url(Strava.last)
  end

  test "should show strava" do
    get strava_url(@strava)
    assert_response :success
  end

  test "should get edit" do
    get edit_strava_url(@strava)
    assert_response :success
  end

  test "should update strava" do
    patch strava_url(@strava), params: { strava: {  } }
    assert_redirected_to strava_url(@strava)
  end

  test "should destroy strava" do
    assert_difference('Strava.count', -1) do
      delete strava_url(@strava)
    end

    assert_redirected_to stravas_url
  end
end
