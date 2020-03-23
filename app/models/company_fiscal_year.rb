class CompanyFiscalYear < ApplicationRecord
  belongs_to :company
  belongs_to :fiscal_year
  has_one :dividend

  delegate :indicated_dividend, to: :dividend
  scope :filter_by_keys, ->(company, fiscal_year) { where(company: company, fiscal_year: fiscal_year) }
end
