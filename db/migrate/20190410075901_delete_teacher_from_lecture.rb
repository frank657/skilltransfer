class DeleteTeacherFromLecture < ActiveRecord::Migration[5.2]
  def change
    remove_column :lectures, :teacher_id
  end
end
