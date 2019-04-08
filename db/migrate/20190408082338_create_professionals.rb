class CreateProfessionals < ActiveRecord::Migration[5.2]
  def change
    create_table :professionals do |t|
      t.string :company
      t.string :title
      t.string :bio
      t.string :location
      t.string :linkedin
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
