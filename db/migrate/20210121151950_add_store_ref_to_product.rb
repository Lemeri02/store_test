class AddStoreRefToProduct < ActiveRecord::Migration[6.1]
  def change
    add_reference :products, :store, foreign_key: true
  end
end
