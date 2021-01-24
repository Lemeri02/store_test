class Store < ApplicationRecord
  has_one :balance
  has_many :products
end
