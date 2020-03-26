class ChangeTypeIndicatedDividendsToDividend < ActiveRecord::Migration[5.2]
  def change
    change_column :dividends, :indicated_dividend, :numeric
  end
end
