FactoryBot.define do
  factory :balance do
    amount { 0 }
    currency { 'RUB' }

    association :store
  end

  factory :store do
    name { Faker::Company.name }
    address { Faker::Address.full_address }

    factory :store_with_balance do
      balance { association(:balance) }
    end
  end
end
