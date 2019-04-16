require 'test_helper'

class SignupFormControllerTest < ActionDispatch::IntegrationTest
  test "should get professional" do
    get signup_form_professional_url
    assert_response :success
  end

  test "should get teacher" do
    get signup_form_teacher_url
    assert_response :success
  end

end
