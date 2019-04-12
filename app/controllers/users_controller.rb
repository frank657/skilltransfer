class UsersController < ApplicationController
  def show
    @user = current_user
    @teacher = current_user.teachers.first
    @professional = current_user.professionals.first
    @class_room = ClassRoom.new(teacher: @teacher)
    @lectures = current_user.teachers.first.lectures.order(:start_time)
  end

  def professional_dashboard
    @user = current_user
    @professional = current_user.professionals.first
  end
end
