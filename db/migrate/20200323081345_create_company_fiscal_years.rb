class CreateCompanyFiscalYears < ActiveRecord::Migration[5.2]
  def change
    create_table :company_fiscal_years do |t|
      t.references :company, foreign_key: true
      t.references :fiscal_year, foreign_key: true

      t.timestamps
    end
  end
end
