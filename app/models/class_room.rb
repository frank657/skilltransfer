class ClassRoom < ApplicationRecord
  belongs_to :teacher
  has_many :lectures
  validates :name, presence: true
  validates :teacher_id, presence: true
  acts_as_taggable_on :interests
end
