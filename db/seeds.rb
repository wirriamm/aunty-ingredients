# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
puts "cleaning db"
User.destroy_all
Listing.destroy_all

puts "seeding users"
user1 = {
  email: "user1#@test.com",
  encrypted_password: "password1"
}
user2 = {
  email: "user2@test.com",
  encrypted_password: "password2"
}

[ user2, user2 ].each do |user|
  User.create!(user)
end
puts "users seeded"

# puts "creating listings"
