class Company < ApplicationRecord
  has_many :company_fiscal_years
  has_many :fiscal_years, through: :company_fiscal_years

  def latest_fiscal_year
    @latest_fiscal_year ||= fiscal_years.order_by_fiscal_year.first
  end
end
