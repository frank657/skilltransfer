class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :teachers, dependent: :destroy
  has_many :professionals, dependent: :destroy
  has_many :class_rooms, through: :teachers
  has_many :lectures, through: :class_rooms
  has_many :lectures, through: :professionals
end
