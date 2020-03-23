class FiscalYear < ApplicationRecord
  has_many :companies, through: :company_fiscal_years
end
