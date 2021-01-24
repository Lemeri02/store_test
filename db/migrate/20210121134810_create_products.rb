class CreateProducts < ActiveRecord::Migration[6.1]
  def change
    create_table :products do |t|
      t.string :name
      t.decimal :quantity, precision: 10, scale: 2
      t.integer :available

      t.timestamps
    end
  end
end
