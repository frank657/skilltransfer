class CreateLectures < ActiveRecord::Migration[5.2]
  def change
    create_table :lectures do |t|
      t.string :name
      t.references :teacher, foreign_key: true
      t.references :professional, foreign_key: true
      t.datetime :start_time
      t.datetime :end_time
      t.string :video_link
      t.boolean :confirmed

      t.timestamps
    end
  end
end
