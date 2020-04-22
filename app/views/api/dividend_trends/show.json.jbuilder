json.array! @brand_fiscal_years do |brand_fiscal_year|
  json.fiscal_year brand_fiscal_year.fiscal_year.fiscal_year
  json.indicated_dividend brand_fiscal_year.indicated_dividend.to_f
  json.payout_ratio brand_fiscal_year.dividend.payout_ratio.to_f
  json.continuous_dividend_increase_years brand_fiscal_year.dividend.continuous_dividend_increase_years.to_i
end
