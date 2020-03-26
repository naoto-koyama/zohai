class Dividend < ApplicationRecord
  belongs_to :brand_fiscal_year
  has_one :brand_latest_dividend
end
