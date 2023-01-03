# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

item_types = ["Hot Coffee", "Cold Coffee", "Sandwich", "Chutney"]

puts "Item types are creating"
item_type1 = ItemType.find_or_create_by(name: item_types[0])
item_type2 = ItemType.find_or_create_by(name: item_types[1])
item_type3 = ItemType.find_or_create_by(name: item_types[2])
item_type4 = ItemType.find_or_create_by(name: item_types[3])

puts "Item types are created"

#note rate in percent
rates = [{rate: 5, item_type: item_type1}, {rate: 5, item_type: item_type2}, {rate: 10, item_type: item_type3}, {rate: 1, item_type: item_type3}]
puts "Tax rates are creating"

rate1 = TaxRate.find_or_create_by(rates[0])
rate2 = TaxRate.find_or_create_by(rates[1])
rate3 = TaxRate.find_or_create_by(rates[2])
rate4 = TaxRate.find_or_create_by(rates[3])

puts "Tax rates created"

items = { 
  "Hot Coffee" => [
    {name: "Latte", amount: 100, image: Rails.root.join("public", "images", "latte.jpeg"), filename: "latte.jpeg"},
    {name: "Hot Hazelnut", amount: 120, image: Rails.root.join("public", "images", "hot_hazelnut.jpg"), filename: "hot_hazelnut.jpg"},
    {name: "Hot Creamy", amount: 160, image: Rails.root.join("public", "images", "hot_creamy.jpg"), filename: "hot_creamy.jpg" }
  ],
  "Sandwich" => [
    {name: "Vegetable Sandwich", amount: 50, image: Rails.root.join("public", "images", "vegetable_sandwich.jpeg"), filename: "vegetable_sandwich.jpeg" },
    {name: "Bombay Kachha", amount: 70, image: Rails.root.join("public", "images", "bombay_kachha.jpg"), filename: "bombay_kachha.jpg" },
    {name: "Cheese Chutney", amount: 100, image: Rails.root.join("public", "images", "cheese_chutney.jpeg"), filename: "cheese_chutney.jpeg" }
  ],
  "Cold Coffee" => [
    {name: "Cold Cofee", amount: 80, image: Rails.root.join("public", "images", "cold_coffee.jpeg"), filename: "cold_coffee.jpeg"},
    {name: "Kitkat Cold Coffee", amount: 80, image: Rails.root.join("public", "images", "kit_kat_cold_coffe.jpg"), filename: "kit_kat_cold_coffe.jpg"}
  ],
  "Chutney" => [
    {name: "Mint Chutney", amount: 10, image: Rails.root.join("public", "images", "mint_chutney.jpg"), filename: "mint_chutney.jpg"},
    {name: "Imli Chutney", amount: 10, image: Rails.root.join("public", "images", "imli_chutney.jpg"), filename: "imli_chutney.jpg"}
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

item1 = Item.find_by(name: "Vegetable Sandwich")
item2 = Item.find_by(name: "Cold Cofee")
item3 = Item.find_by(name: "Mint Chutney")
item4 = Item.find_by(name: "Latte")
item5 = Item.find_by(name: "Bombay Kachha")
item6 = Item.find_by(name: "Kitkat Cold Coffee")

offers = [
  {
    base_item_id: item1.id, child_item_id: item2.id, base_item_quantity: 2, child_item_quantity: 1, is_discount_available: true, discount_percent: 20, offer_applied_on_item_type_id: item_type2.id, free_item_id: item3.id, free_item_quantity: 1, code: "OFFER20"
  },
  {
    base_item_id: item5.id, child_item_id: item6.id, base_item_quantity: 2, child_item_quantity: 2, is_discount_available: false, free_item_id: item4.id, free_item_quantity: 1, code: "LATTEFREE"
  }
]

puts "offers are creating"
offers.each do |offer|
  Offer.find_or_create_by(offer)
end
puts "offers created"