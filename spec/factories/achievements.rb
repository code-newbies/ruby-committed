FactoryGirl.define do
  factory :achievement do
    title       { Faker::Name.title }
    description { Faker::Lorem.sentence(5) }
  end
end
