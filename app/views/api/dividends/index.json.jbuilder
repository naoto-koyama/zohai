json.array! @brand_latest_dividends do |brand_latest_dividend|
  json.id brand_latest_dividend.id
  json.code brand_latest_dividend.brand.code
  json.name brand_latest_dividend.brand.name
  json.fiscal_year brand_latest_dividend.display_fiscal_year
  json.indicated_dividend brand_latest_dividend.dividend.indicated_dividend
  json.payout_ratio brand_latest_dividend.dividend.display_payout_ratio
  json.continuous_dividend_increase_years brand_latest_dividend.dividend.display_continuous_dividend_increase_years
end