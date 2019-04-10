require 'test_helper'

class ClassRoomsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get class_rooms_index_url
    assert_response :success
  end

  test "should get show" do
    get class_rooms_show_url
    assert_response :success
  end

  test "should get new" do
    get class_rooms_new_url
    assert_response :success
  end

  test "should get create" do
    get class_rooms_create_url
    assert_response :success
  end

  test "should get edit" do
    get class_rooms_edit_url
    assert_response :success
  end

  test "should get update" do
    get class_rooms_update_url
    assert_response :success
  end

end
