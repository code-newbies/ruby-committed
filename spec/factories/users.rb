FactoryGirl.define do
  factory :user do
    username { Faker::Internet.name }
    email { Faker::Internet.email }
    password { Faker::Internet.password }
  end
end
