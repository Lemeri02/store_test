FactoryBot.define do
  factory :price do
    amount { 10_000 }
    currency { 'RUB' }
    association :product
  end

  factory :product do
    name { Faker::Food.fruits }
    quantity { 20 }
    sequence(:sku) { |n| "SKU#{n}" }
    association :store

    factory :product_with_price do
      price { association(:price) }
    end
  end
end
