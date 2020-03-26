class Dividend < ApplicationRecord
  belongs_to :brand_fiscal_year
  has_one :brand_latest_dividend

  def fiscal_year_date
    brand_fiscal_year&.fiscal_year&.fiscal_year
  end
end
