FactoryGirl.define do
  factory :achievement do
    title       { Faker::Name.title }
    description { Faker::Lorem.sentence(5) }
    points      { Faker::Number.between(1, 100) }
  end
end
