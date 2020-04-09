class CreateStocks < ActiveRecord::Migration[5.2]
  def change
    create_table :stocks do |t|
      t.references :brand, foreign_key: true
      t.date :date, null: false
      t.numeric :close_stock_price, precision: 10, scale: 4

      t.timestamps
    end
  end
end
