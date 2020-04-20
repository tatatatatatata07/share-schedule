# ユーザー
User.create!(name:  "加川 拓也",
             email: "kagawa@example.com",
             password:              "pass-word",
             password_confirmation: "pass-word",
             admin: true,
             activated: true,
             activated_at: Time.zone.now)

User.create!(name:  "山田 一郎",
             email: "yamada@example.com",
             password:              "pass-word2",
             password_confirmation: "pass-word2",
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

# ミーティング
users = User.all
50.times do
  users.each { |user| user.meeting.create!(
      content: Faker::Lorem.sentence(word_count: 3), 
      title: Faker::Lorem.word, 
      start_time: Faker::Time.between(from: DateTime.now - 90, to: DateTime.now + 90).to_s[0,10] + " " + rand(0..23).to_s + ":" + (rand(0..5) * 10).to_s )}
end

# リレーションシップ
users = User.all
users.each{ |user| 
    user_sample = User.where.not(id: user.id)
    following = user_sample.sample(rand(100))
    following.each { |followed| user.follow(followed) }
}
