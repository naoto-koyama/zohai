json.array! @companies do |company|
  json.code company.code
  json.name company.name
  json.latest_fiscal_year ActiveDecorator::Decorator.instance.decorate(company.latest_fiscal_year).display_fiscal_year
  json.latest_dividend company.latest_dividend.indicated_dividend
  json.payout_ratio company.latest_dividend.display_payout_ratio
  json.continuous_dividend_increase_years company.latest_dividend.continuous_dividend_increase_years
end