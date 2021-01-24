class CreateBalances < ActiveRecord::Migration[6.1]
  def change
    create_table :balances do |t|
      t.decimal :amount, precision: 10, scale: 2
      t.string :currency

      t.timestamps
    end
  end
end
