FactoryBot.define do
  factory :random_user, class: User do
    email { Faker::Internet.email }
    password { "password" }
  end 
  factory :user, class: User do
    email { "#{email}" }
    password { "#{pasowrd}" }
  end 
end