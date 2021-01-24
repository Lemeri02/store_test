class Product < ApplicationRecord
  belongs_to :store

  has_one :price

  enum available: { unavailable: 0, available: 1 }
end
