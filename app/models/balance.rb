class Balance < ApplicationRecord
  belongs_to :store

  composed_of :amount,
              class_name: 'Money',
              mapping: %w[amount cents],
              converter: Proc.new { |value| Money.new(value) }
end
