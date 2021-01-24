class CreatePrices < ActiveRecord::Migration[6.1]
  def change
    create_table :prices do |t|
      t.decimal :amount, precision: 10, scale: 2
      t.string :currency

      t.timestamps
    end
  end
end
