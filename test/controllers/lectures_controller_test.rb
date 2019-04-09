require 'test_helper'

class LecturesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get lectures_index_url
    assert_response :success
  end

  test "should get show" do
    get lectures_show_url
    assert_response :success
  end

  test "should get new" do
    get lectures_new_url
    assert_response :success
  end

  test "should get create" do
    get lectures_create_url
    assert_response :success
  end

end
