FactoryGirl.define do
  factory :user do
    sequence(:email) { |n| "user#{n}@website.com" }
    password "password"
    password_confirmation "password"
  end
end
