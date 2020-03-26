class CreateBrandLatestDividends < ActiveRecord::Migration[5.2]
  def change
    create_table :brand_latest_dividends do |t|
      t.references :brand, foreign_key: true
      t.references :dividend, foreign_key: true
      t.date :fiscal_year

      t.timestamps
    end
  end
end
