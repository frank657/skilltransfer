class AddColumnToLecture < ActiveRecord::Migration[5.2]
  def change
    add_column :lectures, :message, :string
  end
end
