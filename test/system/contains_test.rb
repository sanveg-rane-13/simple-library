require "application_system_test_case"

class ContainsTest < ApplicationSystemTestCase
  setup do
    @contain = contains(:one)
  end

  test "visiting the index" do
    visit contains_url
    assert_selector "h1", text: "Contains"
  end

  test "creating a Contain" do
    visit contains_url
    click_on "New Contain"

    click_on "Create Contain"

    assert_text "Contain was successfully created"
    click_on "Back"
  end

  test "updating a Contain" do
    visit contains_url
    click_on "Edit", match: :first

    click_on "Update Contain"

    assert_text "Contain was successfully updated"
    click_on "Back"
  end

  test "destroying a Contain" do
    visit contains_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Contain was successfully destroyed"
  end
end
