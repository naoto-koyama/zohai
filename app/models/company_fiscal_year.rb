class CompanyFiscalYear < ApplicationRecord
  belongs_to :company
  belongs_to :fiscal_year
  has_one :dividend
end
