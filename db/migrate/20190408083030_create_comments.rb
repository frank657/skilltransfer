class CreateComments < ActiveRecord::Migration[5.2]
  def change
    create_table :comments do |t|
      t.string :name_student
      t.string :content
      t.references :lecture, foreign_key: true

      t.timestamps
    end
  end
end
