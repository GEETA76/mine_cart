# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
User.create!(
  email: "admin@example.com",
  password: "password",
  password_confirmation: "password"
)

puts "Seeded 1 user."

Vendor.create(name: 'Vendor A')
Vendor.create(name: 'Vendor B')

ProductType.create([
  { name: "Electronics" },
  { name: "Clothing" },
  { name: "Books" },
  { name: "Toys" },
])

puts "Seeded #{ProductType.count} product types."

Vendor.create([
  { name: "Tech Giants" },
  { name: "Fashion Store" },
  { name: "Bookworms Paradise" },
])
puts "Seeded #{Vendor.count} vendors."


Product.create([
  { name: "Laptop", price: 1000, vendor: Vendor.first, product_type: ProductType.first, user: User.first },
  { name: "Shirt", price: 30, vendor: Vendor.second, product_type: ProductType.second, user: User.first },
  { name: "Novel", price: 20, vendor: Vendor.third, product_type: ProductType.third, user: User.first },
  { name: "Action Figure", price: 50, vendor: Vendor.first, product_type: ProductType.last, user: User.first },
])

puts "Seeded #{Product.count} products."
