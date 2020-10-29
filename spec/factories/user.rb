FactoryBot.define do
  factory :user do
    name { "user" }
    email { "user@gmail.com" }
    password{ "000000" }
    password_confirmation{ "000000" }
  end
  
end
