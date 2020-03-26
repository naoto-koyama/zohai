json.array! @brand_fiscal_years do |brand_fiscal_year|
  json.fiscal_year brand_fiscal_year.fiscal_year.display_fiscal_year
  json.indicated_dividend brand_fiscal_year.indicated_dividend
  json.payout_ratio brand_fiscal_year.dividend.display_payout_ratio
  json.continuous_dividend_increase_years brand_fiscal_year.dividend.display_continuous_dividend_increase_years
end