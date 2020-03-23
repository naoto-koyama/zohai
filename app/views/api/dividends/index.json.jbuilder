json.array! @companies do |company|
  json.code company.code
  json.name company.name
  latest_fiscal_year = company.latest_fiscal_year
  json.latest_fiscal_year ActiveDecorator::Decorator.instance.decorate(latest_fiscal_year).display_fiscal_year
  json.latest_dividend CompanyFiscalYear.filter_by_keys(company, latest_fiscal_year).first.indicated_dividend
end