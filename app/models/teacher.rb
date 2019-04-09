class Teacher < ApplicationRecord
  validates :school, presence: true
  validates :user_id, presence: true
  # validates :school, inclusion: { in: ["Cambridge international center", "Harrow International School Shanghai", "High School Affiliated to Fudan University", "High School Affiliated to Shanghai Jiao Tong University", "High School Affiliated to Shanghai University", "Jianping High School", "Minhang High School", "Nanyang Model High School", "No.1 High School Affiliated to East China Normal University", "No. 2 High School Attached to East China Normal University", "Shanghai Datong High School", "Shanghai Foreign Language School", "Shanghai Gezhi High School", "Shanghai High School", "Shanghai High School International Division", "Shanghai Nanhui Senior High School", "Shanghai No. 2 High School", "Shanghai No. 3 Girls' High School", "Shanghai Shixi High School", "Shanghai Xingzhi High School", "Shanghai Yan'an High School", "Shanghai Yucai High School", "Xuhui High School"] }
  has_many :class_rooms
  has_many :lectures
  belongs_to :user
end
