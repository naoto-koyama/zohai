json.array! @companies do |company|
  json.code company.code
  json.name company.name
  json.latest_fiscal_year ActiveDecorator::Decorator.instance.decorate(company.latest_fiscal_year).display_fiscal_year
  company_fiscal_year = CompanyFiscalYear.filter_by_keys(company, company.latest_fiscal_year).first
  json.latest_dividend company_fiscal_year.indicated_dividend
  json.continuous_dividend_increase_years company_fiscal_year.continuous_dividend_increase_years
end