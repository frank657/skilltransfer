class SignupFormController < ApplicationController
  def signup_form
    @teacher = Teacher.new
    @professional = Professional.new
  end
end
