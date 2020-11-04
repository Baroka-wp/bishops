FactoryBot.define do
  factory :user do
    name { "user1" }
    email { "user@gmail.com" }
    password{ "000000" }
    password_confirmation{ "000000" }
    confirmed_at { Time.now }
  end
  factory :second_user , class: User do
    name { "user2" }
    email { "user1@gmail.com" }
    password{ "000000" }
    password_confirmation{ "000000" }
    confirmed_at { Time.now }
  end
end
