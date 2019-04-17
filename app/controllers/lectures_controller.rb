class LecturesController < ApplicationController
  before_action :set_lecture, only: [:show, :update]

  def index
    @lectures = current_user.lectures
  end

  def show
    @comment = Comment.new
  end

  def new
    @lecture = Lecture.new
    @professional = Professional.find(params[:professional_id])
    @class_rooms = current_user.class_rooms
  end

  def create
    @lecture = Lecture.new(lecture_params)
    @lecture.professional = Professional.find(params[:professional_id])
    # @lecture.class_room =
    if @lecture.save
      redirect_to user_path(current_user)
    else
      render :new
    end
  end

  def update
    if @lecture.update(confirmed: true)
      redirect_to p_dashboard_path(current_user)
    else

    end
  end

  private

  def set_lecture
    @lecture = Lecture.find(params[:id])
  end

  def lecture_params
    params.require(:lecture).permit(:name, :message, :start_time, :end_time, :video_link, :confirmed, :class_room_id)
  end

end
