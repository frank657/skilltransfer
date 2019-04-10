class LecturesController < ApplicationController
  before_action :set_lecture, only: [:show]

  def index
    @lectures = current_user.lectures
  end

  def show
  end

  def new
    @lecture = Lecture.new
  end

  def create
    @lecture = Lecture.new(lecture_params)
    @lecture.teacher = current_user.teachers.first
    @lecture.professional = Professional.find(params[:professional_id])
    if @lecture.save
      redirect_to user_path(current_user)
    else
      render :new
    end
  end

  private

  def set_lecture
    @lecture = Lecture.find(params[:id])
  end

  def lecture_params
    params.require(:lecture).permit(:name, :message, :start_time, :end_time, :video_link, :confirmed)
  end
end
