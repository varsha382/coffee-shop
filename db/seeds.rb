# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

item_types = ["Hot Coffees", "Cold Coffee", "Sandwich"]

puts "create item_types: #{item_types}"
item_types.each do |item_type|
  ItemType.find_or_create_by(name: item_type)
end

puts "created item_types: #{item_types}"
