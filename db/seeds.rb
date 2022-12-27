# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

item_types = ["Hot Coffee", "Cold Coffee", "Sandwich"]

puts "Item types are creating"
item_types.each do |item_type|
  ItemType.find_or_create_by(name: item_type)
end

puts "Item types are created"

#note rate in percent
rates = [1, 2, 3]
puts "Tax rates are creating"

rate1 = TaxRate.find_or_create_by(rate: rates[0])
rate2 = TaxRate.find_or_create_by(rate: rates[1])
rate3 = TaxRate.find_or_create_by(rate: rates[2])

puts "Tax rates created"

items = { 
  "Hot Coffee" => [
    {name: "Latte", tax_rate: rate1, amount: 80, image: Rails.root.join("public", "images", "latte.jpeg"), filename: "latte.jpeg"},
    {name: "Hot Hazelnut", tax_rate: rate2, amount: 80, image: Rails.root.join("public", "images", "hot_hazelnut.jpg"), filename: "hot_hazelnut.jpg"},
    {name: "Hot Creamy", tax_rate: rate3, amount: 80, image: Rails.root.join("public", "images", "hot_creamy.jpg"), filename: "hot_creamy.jpg" }
  ],
  "Sandwich" => [
    {name: "Vegetable Sandwich", tax_rate: rate1, amount: 80, image: Rails.root.join("public", "images", "vegetable_sandwich.jpeg"), filename: "vegetable_sandwich.jpeg" },
    {name: "Bombay Kachha", tax_rate: rate2, amount: 80, image: Rails.root.join("public", "images", "bombay_kachha.jpg"), filename: "bombay_kachha.jpg" },
    {name: "Cheese Chutney", tax_rate: rate3, amount: 80, image: Rails.root.join("public", "images", "cheese_chutney.jpeg"), filename: "cheese_chutney.jpeg" }
  ],
  "Cold Coffee" => [
    {name: "Cold Cofee", tax_rate: rate1, amount: 80, image: Rails.root.join("public", "images", "cold_coffee.jpeg"), filename: "cold_coffee.jpeg"},
    {name: "Kitkat Cold Coffee", tax_rate: rate2, amount: 80, image: Rails.root.join("public", "images", "kit_kat_cold_coffe.jpg"), filename: "kit_kat_cold_coffe.jpg"}
  ]
}

puts "Items are creating"

ItemType.all.each do |item_type|
  items[item_type.name].each do |item|
    i = Item.find_or_create_by(item.except(:image, :filename))
    image = File.open(item[:image])
    i.image.attach(io: image, filename: item[:filename])
    i.update(item_type: item_type)
  end
end

puts "Items created"
