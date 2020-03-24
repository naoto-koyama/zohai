class AddUnique < ActiveRecord::Migration[5.2]
  def change
    add_index :companies, :code, unique: true
    add_index :fiscal_years, :fiscal_year, unique: true
  end
end
