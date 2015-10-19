require "faker"

FactoryGirl.define do
  factory :identity do
    provider { %w(github twitter).sample }
    uid { Faker::Number.number(6) }
  end
end
