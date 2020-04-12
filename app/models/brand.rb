class Brand < ApplicationRecord
  has_many :brand_fiscal_years
  has_many :fiscal_years, through: :brand_fiscal_years
  has_one :brand_latest_dividend
  has_many :dividends, through: :brand_fiscal_years
  has_many :latest_stocks

  def latest_fiscal_year
    @latest_fiscal_year ||= fiscal_years.order_by_fiscal_year.first
  end

  def latest_dividend
    @latest_dividend ||= brand_fiscal_years&.order_by_fiscal_year&.first&.dividend
  end
end
