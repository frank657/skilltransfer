class Lecture < ApplicationRecord
  # belongs_to :teacher
  belongs_to :professional
  belongs_to :class_room
  has_many :comments
  # validates :name, presence: true
  # validates :teacher_id, presence: true
  validates :class_room_id, presence: true
  validates :professional_id, presence: true
  validates :start_time, presence: true
  validates :end_time, presence: true
  validates :message, presence: true
end
