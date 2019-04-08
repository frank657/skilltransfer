class CreateRequests < ActiveRecord::Migration[5.2]
  def change
    create_table :requests do |t|
      t.string :message
      t.references :teacher, foreign_key: true
      t.references :professional, foreign_key: true
      t.datetime :start_time
      t.datetime :end_time
      t.boolean :confirmed

      t.timestamps
    end
  end
end
