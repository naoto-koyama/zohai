class BrandFiscalYear < ApplicationRecord
  belongs_to :brand
  belongs_to :fiscal_year
  has_one :dividend

  delegate :indicated_dividend, to: :dividend
  scope :filter_by_keys, ->(brand, fiscal_year) { where(brand: brand, fiscal_year: fiscal_year) }
  scope :order_by_fiscal_year, -> { includes(:fiscal_year).order("fiscal_years.fiscal_year desc") }
end
