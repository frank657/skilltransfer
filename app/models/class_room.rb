class ClassRoom < ApplicationRecord
  belongs_to :teacher
  validates :name, presence: true
  validates :teacher_id, presence: true
  acts_as_taggable_on :interests
end
