class TeachersController < ApplicationController
  before_action :set_teacher, only: [:edit, :update]

  def new
    @teacher = Teacher.new
  end

  def create
    @teacher = Teacher.new(teacher_params)
    @teacher.user = current_user
    if @teacher.save
      redirect_to user_path(current_user)
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @teacher.update(teacher_params)
      redirect_to user_path(current_user)
    else
      render :edit
    end
  end

  private

  def teacher_params
    params.require(:teacher).permit(:school, :title)
  end

  def set_teacher
    @teacher = current_user.teachers.first
  end
end
