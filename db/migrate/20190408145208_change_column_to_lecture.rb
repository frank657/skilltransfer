class ChangeColumnToLecture < ActiveRecord::Migration[5.2]
  def change
    change_column :lectures, :confirmed, :boolean, default: false
  end
end
