class CreateProfessionals < ActiveRecord::Migration[5.2]
  def change
    create_table :professionals do |t|
      t.string :company
      t.string :title
      t.string :description
      t.string :city
      t.string :linkedin_url
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
