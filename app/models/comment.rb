class Comment < ApplicationRecord
  belongs_to :lecture
  validates :name_student, presence: true
  validates :content, presence: true
  validates :lecture_id, presence: true
end
