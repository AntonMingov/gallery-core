require "test_helper"

class StaticLabelsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @static_label = static_labels(:one)
  end

  test "should get index" do
    get static_labels_url
    assert_response :success
  end

  test "should get new" do
    get new_static_label_url
    assert_response :success
  end

  test "should create static_label" do
    assert_difference("StaticLabel.count") do
      post static_labels_url, params: { static_label: {  } }
    end

    assert_redirected_to static_label_url(StaticLabel.last)
  end

  test "should show static_label" do
    get static_label_url(@static_label)
    assert_response :success
  end

  test "should get edit" do
    get edit_static_label_url(@static_label)
    assert_response :success
  end

  test "should update static_label" do
    patch static_label_url(@static_label), params: { static_label: {  } }
    assert_redirected_to static_label_url(@static_label)
  end

  test "should destroy static_label" do
    assert_difference("StaticLabel.count", -1) do
      delete static_label_url(@static_label)
    end

    assert_redirected_to static_labels_url
  end
end
