# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


user = User.create(username: 'example',
                   email: 'user@example.com',
                   password: '12345678',
                   password_confirmation: '12345678')

achievement = Achievement.create(title: "Welcome to Commited",
                                 description: "Sign up and begin your coding journey.",
                                 points: 10)
user.achievements << achievement

10.times do |achievement|
  achievement = Achievement.create(title: Faker::Name.title,
                                   description: Faker::Lorem.sentence(5),
                                   points: 5 * Random.rand(2..20))
  user.achievements << achievement
end
