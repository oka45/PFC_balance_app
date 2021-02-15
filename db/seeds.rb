User.create!(name: "岡崎　真悟",
             email: "example@sample.jp",
             password: "foobar",
             password_confirmation: "foobar",
             admin: true)

50.times do |n|
  name = Gimei.name
  email = "example-#{n+1}@sample.jp"
  password = "password"
  User.create!(name: name,
              email: email,
              password: password,
              password_confirmation: password)
  end
