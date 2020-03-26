User.create!(name:  "加川　拓也",
             email: "kagawa@example.com",
             password:              "pass-word",
             password_confirmation: "pass-word",
             admin: true)

99.times do |n|
  name  = Faker::Name.name
  email = "example-#{n+1}@example.com"
  password = "password"
  User.create!(name:  name,
               email: email,
               password:              password,
               password_confirmation: password)
end