class CreateDividends < ActiveRecord::Migration[5.2]
  def change
    create_table :dividends do |t|
      t.references :company_fiscal_year, foreign_key: true
      t.numeric :indicated_dividend, precision: 6, scale: 4, null: false
      t.bigint :surplus_dividend, null: false
      t.bigint :buyback, null: false

      t.timestamps
    end
  end
end
