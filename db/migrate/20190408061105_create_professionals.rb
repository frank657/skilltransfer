class CreateProfessionals < ActiveRecord::Migration[5.2]
  def change
    create_table :professionals do |t|

      t.timestamps
    end
  end
end
