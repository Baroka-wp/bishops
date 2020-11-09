20.times do |n|
  avatar = Faker::Avatar.image
  name = Faker::Games::Pokemon.name
  email = Faker::Internet.email
  password = "000000"
  User.create!(avatar: avatar,
               name: name,
               email: email,
               password: password,
               password_confirmation: password,
               confirmed_at: Time.now
               )
end
