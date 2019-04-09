class TeachersController < ApplicationController
  def show
    @teacher = Teacher.find(current_user.teacher_ids.first)
  end

  def new
  end

  def edit
  end
end
