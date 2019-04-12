class ClassRoomsController < ApplicationController
  before_action :set_class_room, only: [:show, :edit, :update]

  def index
    @class_rooms = current_user.class_rooms
  end

  def show
  end

  def new
    @class_room = ClassRoom.new
  end

  def create
    @class_room = ClassRoom.new(class_room_params)
    @class_room.teacher = current_user.teachers.first
    if @class_room.save
      redirect_to user_path(current_user)
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @class_room.update(class_room_params)
      redirect_to user_path(current_user)
    else
      render :edit
    end
  end

  private

  def class_room_params
    params.require(:class_room).permit(:name, :picture_url, :interest_list)
  end

  def set_class_room
    @class_room = ClassRoom.find(params[:id])
  end
end
