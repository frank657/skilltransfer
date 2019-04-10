class AddClassRoomToLecture < ActiveRecord::Migration[5.2]
  def change
    add_reference :lectures, :class_room, foreign_key: true
  end
end
