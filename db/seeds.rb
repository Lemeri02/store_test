# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

5.times do
  store = Store.create(name: Faker::Company.name, address: Faker::Address.full_address)
  Balance.create(store: store, amount: rand(100..100_000), currency: 'RUB')
end

15.times do
  product = Product.create(name: Faker::Food.fruits, quantity: rand(3..49), store_id: rand(1..5), sku: "SKU#{Faker::Number.unique.number(digits: 2)}")
  Price.create(product: product, amount: rand(100..100_000), currency: 'RUB')
end
