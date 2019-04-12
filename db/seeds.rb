Comment.delete_all if Rails.env.development?
Lecture.delete_all if Rails.env.development?
Professional.delete_all if Rails.env.development?
ClassRoom.delete_all if Rails.env.development?
Teacher.delete_all if Rails.env.development?
User.delete_all if Rails.env.development?

def sample_question
  [ "Are you more of a hunter or a gatherer?",
    "You’re a new addition to the crayon box. What color would you be and why?",
    "We finish the interview and you step outside the office and find a lottery ticket that ends up winning $10 million. What would you do?",
    "What do you think about when you’re alone in your car?",
    "What’s your favorite ’90s jam?",
    "If you could be any animal in the world, what animal would you be and why?",
    "What was the last gift you gave someone?",
    "What were you like in high school?",
    "What’s the last thing you watched on TV and why did you choose to watch it?",
    "Any advice for your previous boss?",
    "Tell me something about your last job, other than money, that would have inspired you to keep working there.",
    "What is the funniest thing that has happened to you recently?",
    "What do you want to be when you grow up?",
    "Which two organizations outside your own do you know the most people at and why?",
    "Pretend you’re our CEO. What three concerns about the firm’s future keep you up at night?",
    "If I were to hire you for this job and I granted you three promises with regard to working here, what would they be?",
    "If you don’t get this job, what’s your backup plan?",
    "What inspires you?",
    "Teach me something I don’t know in the next five minutes.",
    "What are you known for?",
    "What do you work toward in your free time?",
    "What’s the most interesting thing about you that we wouldn’t learn from your resume alone?",
    "How would you rate your memory?",
    "Code something from scratch in three hours. Then explain your design and solution.",
    "If you woke up and had 2,000 unread emails and could only answer 300 of them, how would you choose which ones to answer?",
    "How many pennies would fit into this room?",
    "Can you name three consecutive days without using the words Wednesday, Friday, or Saturday?",
    "Estimate how many windows are in New York.",
    "How would you value the store on the corner?",
    "How many square feet of pizza is eaten in the U.S. each year?",
    "Describe the color yellow to somebody who is blind.",
    "If you were to get rid of one state in the U.S., which would it be and why?",
    "You’ve been given an elephant. You can’t give it away or sell it. What would you do with the elephant?",
    "Who would win a fight between Spiderman and Batman?",
    "How would you convince someone to do something they didn’t want to do?",
    "A penguin walks through that door right now wearing a sombrero. What does he say and why is he here?"].sample
end

def create_male_user
  f_name = Faker::Name.male_first_name
  l_name = Faker::Name.last_name
  User.create!(
    first_name: f_name,
    last_name: l_name,
    profile_picture_url: UiFaces.man,
    background_picture_url: "https://source.unsplash.com/1600x900/?#{['city','building','nature','people','office','professional','business'].sample}",
    email: "#{f_name}.#{l_name}@#{Faker::Internet.domain_name}",
    password: 'password'
  )
end

def create_female_user
  f_name = Faker::Name.female_first_name
  l_name = Faker::Name.last_name
  User.create!(
    first_name: f_name,
    last_name: l_name,
    profile_picture_url: UiFaces.woman,
    background_picture_url: "https://source.unsplash.com/1200x675/?#{['city','building','nature','people','office','professional','business'].sample}",
    email: "#{f_name}.#{l_name}@#{Faker::Internet.domain_name}",
    password: 'password'
  )
end

def create_teacher
  Teacher.create!(
    user_id: User.last.id,
    school: ["Cambridge international center", "Harrow International School Shanghai", "High School Affiliated to Fudan University", "High School Affiliated to Shanghai Jiao Tong University", "High School Affiliated to Shanghai University", "Jianping High School", "Minhang High School", "Nanyang Model High School", "No.1 High School Affiliated to East China Normal University", "No. 2 High School Attached to East China Normal University", "Shanghai Datong High School", "Shanghai Foreign Language School", "Shanghai Gezhi High School", "Shanghai High School", "Shanghai High School International Division", "Shanghai Nanhui Senior High School", "Shanghai No. 2 High School", "Shanghai No. 3 Girls' High School", "Shanghai Shixi High School", "Shanghai Xingzhi High School", "Shanghai Yan'an High School", "Shanghai Yucai High School", "Xuhui High School"].sample,
    title: ["Math Teacher", "Principal", "Vice Principal", "Academic Director", "Social Studies Teacher", "Science Teacher", "Life Skills Teacher"].sample
  )
end

def create_prof
  Professional.create!(
    user_id: User.last.id,
    company: Faker::Company.name,
    title: Faker::Job.title,
    city: Faker::Address.city,
    linkedin_url: Faker::Internet.url('linkedin.com')
  )
end

p "creating data"

# CREATE TEACHERS
5.times do
  # create_male_user
  rand(0..1) == 0 ? create_male_user : create_female_user
  create_teacher
end

# CREATE PROFESSIONALS
50.times do
  # create_female_user
  rand(0..1) == 0 ? create_male_user : create_female_user
  create_prof
  p = Professional.last
  rand(1..5).times do
    p.expertise_list.add(Faker::Job.field)
  end
  p.save
end

20.times do
  c = ClassRoom.create!(
    name: "#{['Math', 'Science','Foreign Languages', 'Social Studies', 'Business', 'Information Technology', 'English'].sample} Class - #{Faker::Types.character.upcase} #{rand(1..5)}",
    description: Faker::Quote.matz,
    picture_url: "https://source.unsplash.com/1200x675/?#{['school','study','students','classroom','education'].sample}",
    teacher: Teacher.all.sample
  )
  rand(1..5).times do
    c.interest_list.add(Faker::Job.field)
  end
  c.save
end

20.times do
  time = Time.new(2019, rand(5..7), rand(1..30), rand(9..17))
  Lecture.create!(
    name: Faker::Company.catch_phrase,
    # teacher: Teacher.all.sample,
    class_room: ClassRoom.all.sample,
    professional: Professional.all.sample,
    confirmed: [true, false].sample,
    start_time: time,
    end_time: time + 3600,
    message: Faker::Quote.matz,
  )
end

50.times do
  Comment.create!(
    name_student: Faker::Name.first_name,
    content: sample_question,
    lecture: Lecture.all.sample
  )
end

p "created #{User.count} users"
p "created #{Teacher.count} teachers"
p "created #{Professional.count} professionals"
p "created #{ClassRoom.count} class rooms"
p "created #{Lecture.count} lectures"
p "created #{Comment.count} comments"
