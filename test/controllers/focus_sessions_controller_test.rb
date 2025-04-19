require "test_helper"

class FocusSessionsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get focus_sessions_index_url
    assert_response :success
  end

  test "should get show" do
    get focus_sessions_show_url
    assert_response :success
  end

  test "should get new" do
    get focus_sessions_new_url
    assert_response :success
  end

  test "should get create" do
    get focus_sessions_create_url
    assert_response :success
  end

  test "should get destroy" do
    get focus_sessions_destroy_url
    assert_response :success
  end
end
