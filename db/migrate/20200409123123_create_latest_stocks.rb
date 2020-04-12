class CreateLatestStocks < ActiveRecord::Migration[5.2]
  def change
    create_table :latest_stocks do |t|
      t.references :brand, foreign_key: true
      t.date :trading_date, null: false
      t.numeric :open_price, precision: 10, scale: 4
      t.numeric :close_price, precision: 10, scale: 4
      t.numeric :high_price, precision: 10, scale: 4
      t.numeric :low_price, precision: 10, scale: 4
      t.bigint :trading_volume

      t.timestamps
    end
  end
end
