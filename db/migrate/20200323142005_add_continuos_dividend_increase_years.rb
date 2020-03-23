class AddContinuosDividendIncreaseYears < ActiveRecord::Migration[5.2]
  def change
    add_column :company_fiscal_years, :continuous_dividend_increase_years, :integer, null:false, default: 0
  end
end
