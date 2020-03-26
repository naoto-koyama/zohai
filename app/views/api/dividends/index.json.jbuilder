json.array! @brands do |brand|
  json.code brand.code
  json.name brand.name
  json.latest_fiscal_year ActiveDecorator::Decorator.instance.decorate(brand.latest_fiscal_year)&.display_fiscal_year
  json.latest_dividend brand.latest_dividend&.indicated_dividend
  json.payout_ratio brand.latest_dividend&.display_payout_ratio
  json.continuous_dividend_increase_years brand.latest_dividend&.continuous_dividend_increase_years
end