# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
puts "Cleaning DB"
User.destroy_all
Order.destroy_all
Listing.destroy_all
User.destroy_all

puts "Seeding 3 users"
john = User.new(email: 'john@gmail.com',
                password: 'topsecret',
                password_confirmation: 'topsecret',
                address: '30 Bedok North Rd, Singapore 469676')
john.save!
puts "jane seeded"

jane = User.new(email: 'jane@gmail.com',
                password: 'topsecret',
                password_confirmation: 'topsecret',
                address: '539 Bedok North Street 3, #01-643, Singapore 460539')
jane.save!
puts "jane seeded"

jack = User.new(email: 'jack@gmail.com',
                password: 'topsecret',
                password_confirmation: 'topsecret',
                address: 'Bedok North Ave 2, #01-25 Block 416, Singapore 460416')
jack.save!
puts "jack seeded"

puts "Seeding listings"
flour = Listing.create


flour = Listing.create! :name => 'flour', :description => 'a bag of self-raising flour', :quantity_available => 5, :listing_price_pq => 2.5, :user => john
listing2 = Listing.create! :name => 'rice', :description => 'a bag of rice', :quantity_available => 10, :listing_price_pq => 5.0, :user => john
listing3 = Listing.create! :name => 'apples', :description => '1kg of apples', :quantity_available => 1, :listing_price_pq => 0.8, :user => jane
listing4 = Listing.create! :name => 'nutella', :description => 'a bottle', :quantity_available => 99, :listing_price_pq => 5.97, :user => jane
puts "listings seeded"

puts "Seeding orders"
order1 = Order.create! :listing => listing1, :user => user2, :quantity_ordered => 1
order2 = Order.create! :listing => listing3, :user => user1, :quantity_ordered => 1
puts "orders seeded"
