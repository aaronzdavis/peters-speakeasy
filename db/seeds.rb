# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Membership.destroy_all


200.times do

  Membership.create(
    name: Faker::Name.name,
    email: Faker::Internet.email,
    created_at: Faker::Date.between(4.years.ago, Date.today)
  )

end