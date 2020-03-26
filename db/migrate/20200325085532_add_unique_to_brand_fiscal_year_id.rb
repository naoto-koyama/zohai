class AddUniqueToBrandFiscalYearId < ActiveRecord::Migration[5.2]
  def change
    add_index :dividends, :brand_fiscal_year_id, unique: true, name: "index_dividends_on_brand_fiscal_year_id_unique"
  end
end
