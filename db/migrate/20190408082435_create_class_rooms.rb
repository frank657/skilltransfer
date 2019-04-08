class CreateClassRooms < ActiveRecord::Migration[5.2]
  def change
    create_table :class_rooms do |t|
      t.string :name
      t.string :description
      t.string :picture
      t.references :teacher, foreign_key: true

      t.timestamps
    end
  end
end
