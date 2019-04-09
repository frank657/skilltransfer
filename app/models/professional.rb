class Professional < ApplicationRecord
  has_many :lectures
  belongs_to :user
  validates :company, presence: true
  validates :title, presence: true
  validates :user_id, presence: true
  acts_as_taggable_on :expertises
end
