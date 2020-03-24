class ChangeCompaniesToBrands < ActiveRecord::Migration[5.2]
  def change
    rename_table :companies, :brands
    rename_column :company_fiscal_years, :company_id, :brand_id
    rename_column :dividends, :company_fiscal_year_id, :brand_fiscal_year_id
    rename_table :company_fiscal_years, :brand_fiscal_years
  end
end
