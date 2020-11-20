require "application_system_test_case"

class StravasTest < ApplicationSystemTestCase
  setup do
    @strava = stravas(:one)
  end

  test "visiting the index" do
    visit stravas_url
    assert_selector "h1", text: "Stravas"
  end

  test "creating a Strava" do
    visit stravas_url
    click_on "New Strava"

    click_on "Create Strava"

    assert_text "Strava was successfully created"
    click_on "Back"
  end

  test "updating a Strava" do
    visit stravas_url
    click_on "Edit", match: :first

    click_on "Update Strava"

    assert_text "Strava was successfully updated"
    click_on "Back"
  end

  test "destroying a Strava" do
    visit stravas_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Strava was successfully destroyed"
  end
end
