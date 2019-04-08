class AddFieldsToTeacher < ActiveRecord::Migration[5.2]
  def change
    add_column :teachers, :school, :string
    add_column :teachers, :title, :string
  end
end
