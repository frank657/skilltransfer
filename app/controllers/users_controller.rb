class UsersController < ApplicationController
  def show
    @user = current_user
    @teacher = current_user.teachers.first
    @professional = current_user.professionals.first
  end
end
