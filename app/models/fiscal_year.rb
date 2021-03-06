class FiscalYear < ApplicationRecord
  has_many :brands, through: :brand_fiscal_years

  scope :order_by_fiscal_year, ->(order = :desc) { order(fiscal_year: order) }
end
