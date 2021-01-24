class AddStoreRefToBalance < ActiveRecord::Migration[6.1]
  def change
    add_reference :balances, :store, null: false, foreign_key: true
  end
end
