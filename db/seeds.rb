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
titles = ["社内会議","外出","打合せ","ミーティング","荷物搬入予定","報告日","説明会","資料作成","ゴミ捨て","OJT","教育","休暇","有給休暇","早退予定","遅刻予定","帰社","歓迎会","月次作業","資料締切日","新入社員歓迎会"]
contents = ["1Fミーティングルームにて","2社の営業予定","今月の実績と来月の目標を共有","2Fミーティングルームにて予定","消耗品到着の予定","先日の打ち合わせの結果を報告予定","新入社員説明会予定日","説明会資料の作成を予定","燃えるゴミと不燃ゴミの日","第二営業所へOJT予定","新入社員教育の予定""休暇","有給休暇","早退予定","遅刻予定","帰社","歓迎会","月次作業","資料締切日","新入社員歓迎会","休暇","有給休暇","早退予定","遅刻予定","帰社","歓迎会","月次作業","資料締切日","新入社員歓迎会"]

n = 0
schedules = []
while n <= titles.length  do
  schedules.push([titles[n],contents[n]])
  n = n + 1
end

50.times do
  random = rand titles.length
  users.each { |user| user.meeting.create!(
      content: schedules[random][1], 
      title: schedules[random][0],
      start_time: Faker::Time.between(from: DateTime.now - 90, to: DateTime.now + 90).to_s[0,10] + " " + rand(9..17).to_s + ":" + (rand(0..5) * 10).to_s )}
end

# リレーションシップ
users = User.all
users.each{ |user| 
    user_sample = User.where.not(id: user.id)
    following = user_sample.sample(rand(100))
    following.each { |followed| user.follow(followed) }
}
