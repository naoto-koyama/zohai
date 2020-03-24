class MoveContinuousDividendIncreaseYears < ActiveRecord::Migration[5.2]
  def change
    remove_column :company_fiscal_years, :continuous_dividend_increase_years
    add_column :dividends, :continuous_dividend_increase_years, :integer, null:false, default: 0
  end
end
