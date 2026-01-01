require "application_system_test_case"

class StaticLabelsTest < ApplicationSystemTestCase
  setup do
    @static_label = static_labels(:one)
  end

  test "visiting the index" do
    visit static_labels_url
    assert_selector "h1", text: "Static labels"
  end

  test "should create static label" do
    visit static_labels_url
    click_on "New static label"

    click_on "Create Static label"

    assert_text "Static label was successfully created"
    click_on "Back"
  end

  test "should update Static label" do
    visit static_label_url(@static_label)
    click_on "Edit this static label", match: :first

    click_on "Update Static label"

    assert_text "Static label was successfully updated"
    click_on "Back"
  end

  test "should destroy Static label" do
    visit static_label_url(@static_label)
    click_on "Destroy this static label", match: :first

    assert_text "Static label was successfully destroyed"
  end
end
