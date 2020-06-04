# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
puts "cleaning db"
# User.destroy_all
Listing.destroy_all
User.destroy_all

puts "seeding users"
# user1 = {
#   email: "user1#@test.com",
#   encrypted_password: "password1"
# }
# user2 = {
#   email: "user2@test.com",
#   encrypted_password: "password2"
# }

# [ user2, user2 ].each do |user|
#   User.create!(user)
# end

# user = User.new
# user.email = 'test@example.com'
# user.encrypted_password = '#$taawktljasktlw4aaglj'
# user.save!

user1 = User.create! :email => 'john@gmail.com', :password => 'topsecret', :password_confirmation => 'topsecret'
user2 = User.create! :email => 'jane@gmail.com', :password => 'topsecret', :password_confirmation => 'topsecret'

puts "users seeded"

puts "creating listings"

listing1 = Listing.create! :name => 'flour', :description => 'a bag of self-raising flour', :quantity_available => 5, :listing_price_pq => 2.5, :user => user1
listing2 = Listing.create! :name => 'rice', :description => 'a bag of rice', :quantity_available => 10, :listing_price_pq => 5.0, :user => user1
listing3 = Listing.create! :name => 'apples', :description => '1kg of apples', :quantity_available => 1, :listing_price_pq => 0.8, :user => user2
listing4 = Listing.create! :name => 'nutella', :description => 'a bottle', :quantity_available => 99, :listing_price_pq => 5.97, :user => user2

puts "listings seeded"
