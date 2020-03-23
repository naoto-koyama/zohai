class CreateFiscalYears < ActiveRecord::Migration[5.2]
  def change
    create_table :fiscal_years do |t|
      t.date :fiscal_year

      t.timestamps
    end
  end
end
