class FiscalYear < ApplicationRecord
  has_many :dividend_view_form, through: :company_fiscal_years

  scope :order_by_fiscal_year, ->(order = :desc) { order(fiscal_year: order) }
end
