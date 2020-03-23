class Company < ApplicationRecord
  has_many :fiscal_years, through: :company_fiscal_years
end
