User.create!(name:  "加川　拓也",
             email: "kagawa@example.com",
             password:              "pass-word",
             password_confirmation: "pass-word",
             admin: true,
             activated: true,
             activated_at: Time.zone.now)

User.create!(name:  "山田　一郎",
             email: "yamada@example.com",
             password:              "pass-word",
             password_confirmation: "pass-word",
             activated: true,
             activated_at: Time.zone.now)

99.times do |n|
  name  = Faker::Name.name
  email = "example-#{n+1}@example.com"
  password = "password"
  User.create!(name:  name,
               email: email,
               password:              password,
               password_confirmation: password,
               activated: true,
               activated_at: Time.zone.now)
end

users = User.order(:created_at).take(6)
50.times do
  users.each { |user| user.meeting.create!(
      content: Faker::Lorem.sentence(word_count: 3), 
      title: Faker::Lorem.word, 
      start_time: Faker::Time.between(from: DateTime.now - 30, to: DateTime.now + 30)) }
end