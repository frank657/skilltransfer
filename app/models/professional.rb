class Professional < User
  has_many :lectures
  validates :company, presence: true
  validates :title, presence: true
  acts_as_taggable_on :expertises
end
