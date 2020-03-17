# frozen_string_literal: true

FactoryBot.define do
  factory :random_user, class: User do
    email { Faker::Internet.email }
    password { 'password' }
  end
  factory :user, class: User do
    email { email.to_s }
    password { pasowrd.to_s }
  end
end
