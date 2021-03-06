# frozen_string_literal: true

FactoryBot.define do
  factory :user, aliases: %i[student mentor author] do
    sequence(:nickname) { |n| "#{Faker::Internet.username}#{n}" }
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    email { Faker::Internet.email }
    github_url { Faker::Internet.url("github.com") }
    phone { Faker::PhoneNumber.phone_number }
    password { Faker::Internet.password(8) }
    team

    trait(:admin) { role { :admin } }
    trait(:leader) { role { :leader } }
    trait(:moder) { role { :moder } }
    trait(:staff) { role { :staff } }
    trait(:student) { role { :student } }
    trait(:inactive) { status { :inactive } }
  end
end
