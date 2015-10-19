# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


Achievement.create(title: "Welcome to Commited",
                   description: "Sign up and begin your coding journey.",
                   points: 10)

10.times do |achievement|
  Achievement.create(title: Faker::Book.title,
                     description: Faker::Lorem.sentence(5),
                     points: 5 * Random.rand(2..20))
end
