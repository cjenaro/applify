require "application_system_test_case"

class ApplicationsTest < ApplicationSystemTestCase
  setup do
    @application = applications(:one)
  end

  test "visiting the index" do
    visit applications_url
    assert_selector "h1", text: "Applications"
  end

  test "should create application" do
    visit applications_url
    click_on "New application"

    fill_in "Company", with: @application.company
    fill_in "Description", with: @application.description
    fill_in "Position", with: @application.position
    fill_in "Position url", with: @application.position_url
    fill_in "Status", with: @application.status
    click_on "Create Application"

    assert_text "Application was successfully created"
    click_on "Back"
  end

  test "should update Application" do
    visit application_url(@application)
    click_on "Edit this application", match: :first

    fill_in "Company", with: @application.company
    fill_in "Description", with: @application.description
    fill_in "Position", with: @application.position
    fill_in "Position url", with: @application.position_url
    fill_in "Status", with: @application.status
    click_on "Update Application"

    assert_text "Application was successfully updated"
    click_on "Back"
  end

  test "should destroy Application" do
    visit application_url(@application)
    click_on "Destroy this application", match: :first

    assert_text "Application was successfully destroyed"
  end
end
