FactoryGirl.define do
  factory :user do
    email { Faker::Internet.email }
    password { Faker::Internet.password }
    username { Faker::Internet.name }
    biography { Faker::Lorem.paragraph(3) }
  end
end
