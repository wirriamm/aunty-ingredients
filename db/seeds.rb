# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'open-uri'

puts "Cleaning DB"
# Payment.destroy_all
# Order.destroy_all
# Listing.destroy_all
User.destroy_all

puts "Seeding 4 users"
john = User.new(email: 'john@gmail.com',
                password: 'topsecret',
                password_confirmation: 'topsecret',
                address: '30 Bedok North Rd, Singapore 469676')
john.save!
puts "john seeded"

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

jill = User.new(email: 'jill@gmail.com',
                password: 'topsecret',
                password_confirmation: 'topsecret',
                address: '360 Orchard Rd, International Building, Singapore 238869')
jill.save!
puts "jill seeded"

################################################################################

puts
puts "Seeding 10 listings"

flour = Listing.create!(
    name: 'Flour',
    description: 'A bag of self-raising flour',
    quantity_available: 3,
    listing_price_pq: 3.5,
    user: john
  )
flour.photo.attach(io: File.open('db/seed-images/flour.jpg'), filename: 'flour.jpg', content_type: 'image/jpg')
flour.save!

rice = Listing.create!(
    name: 'Rice',
    description: 'A bag of self-raising flour',
    quantity_available: 5,
    listing_price_pq: 5.9,
    user: jack
  )
rice.photo.attach(io: File.open('db/seed-images/rice.jpg'), filename: 'rice.jpg', content_type: 'image/jpg')
rice.save!

apples = Listing.create!(
    name: 'Apples',
    description: 'An apple a day keeps the doctor away!',
    quantity_available: 20,
    listing_price_pq: 0.8,
    user: jill
  )
apples.photo.attach(io: File.open('db/seed-images/apples.jpg'), filename: 'apples.jpg', content_type: 'image/jpg')
apples.save!

nutella = Listing.create!(
    name: 'nutella',
    description: "500g bottle, it's so good you'll go nuts without it",
    quantity_available: 1,
    listing_price_pq: 6.2,
    user: jane
  )
nutella.photo.attach(io: File.open('db/seed-images/nutella.jpg'), filename: 'nutella.jpg', content_type: 'image/jpg')
nutella.save!

garlic = Listing.create!(
    name: 'Garlic',
    description: 'Packs of 200g, fresh from my backyard',
    quantity_available: 10,
    listing_price_pq: 1.35,
    user: jack
  )
garlic.photo.attach(io: File.open('db/seed-images/garlic.jpg'), filename: 'garlic.jpg', content_type: 'image/jpg')
garlic.save!

instant_noodles = Listing.create!(
    name: 'Instant Noodles',
    description: "Packs of 5",
    quantity_available: 6,
    listing_price_pq: 5,
    user: jane
  )
instant_noodles.photo.attach(io: File.open('db/seed-images/instant_noodles.jpg'), filename: 'instant_noodles.jpg', content_type: 'image/jpg')
instant_noodles.save!

chilli = Listing.create!(
    name: 'Chilli',
    description: "100g",
    quantity_available: 4,
    listing_price_pq: 0.9,
    user: jack
  )
chilli.photo.attach(io: File.open('db/seed-images/chilli.jpg'), filename: 'chilli.jpg', content_type: 'image/jpg')
chilli.save!

bell_pepper = Listing.create!(
    name: 'Bell Pepper',
    description: "200g",
    quantity_available: 2,
    listing_price_pq: 3.7,
    user: jill
  )
bell_pepper.photo.attach(io: File.open('db/seed-images/bell_pepper.jpg'), filename: 'bell_pepper.jpg', content_type: 'image/jpg')
bell_pepper.save!

curry_paste = Listing.create!(
    name: 'Curry Paste',
    description: "Homemade curry paste, per 100g",
    quantity_available: 8,
    listing_price_pq: 7.1,
    user: jane
  )
curry_paste.photo.attach(io: File.open('db/seed-images/curry_paste.jpg'), filename: 'curry_paste.jpg', content_type: 'image/jpg')
curry_paste.save!

cooking_oil = Listing.create!(
    name: 'cooking_oil',
    description: "800mL bottle",
    quantity_available: 4,
    listing_price_pq: 0.9,
    user: jack
  )
cooking_oil.photo.attach(io: File.open('db/seed-images/cooking_oil.jpg'), filename: 'cooking_oil.jpg', content_type: 'image/jpg')
cooking_oil.save!
puts "Listings seeded"

################################################################################

puts "Seeding orders"
order1 = Order.create!(
        listing: rice,
        user: john,
        quantity_ordered: 1,
        order_price_pq: rice.listing_price_pq
    )

order2 = Order.create!(
        listing: bell_pepper,
        user: john,
        quantity_ordered: 1,
        order_price_pq: bell_pepper.listing_price_pq
    )

order3 = Order.create!(
        listing: nutella,
        user: john,
        quantity_ordered: 1,
        order_price_pq: nutella.listing_price_pq
    )
puts "Orders seeded"
