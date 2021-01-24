class AddProductRefToPrice < ActiveRecord::Migration[6.1]
  def change
    add_reference :prices, :product, foreign_key: true
  end
end
