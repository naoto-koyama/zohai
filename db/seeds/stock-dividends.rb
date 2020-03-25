require 'csv'

path_list = Dir.glob(File.join Rails.root, 'db/seeds/csv/fy-stock-dividend*.csv')

dividends = []
path_list.each do |path|
  f = open(path)
  f.readline
  CSV.new(f, headers: true).each do |dividend|
    brand_fiscal_year = BrandFiscalYear.create(
      brand: Brand.find_by(code: dividend['コード']),
      fiscal_year: FiscalYear.find_or_create_by(fiscal_year: Date.new(dividend['年度'][0, 4].to_i, dividend['年度'][5, 2].to_i, 1))
    )
    dividends << Dividend.new(
      brand_fiscal_year: brand_fiscal_year,
      indicated_dividend:  dividend['一株配当'].nil? ? 0 : dividend['一株配当'],
      surplus_dividend:  dividend['剰余金の配当'].nil? ? 0 : dividend['剰余金の配当'],
      buyback:  dividend['自社株買い'].nil? ? 0 : dividend['自社株買い'],
      payout_ratio:  dividend['配当性向'].nil? ? 0 : dividend['配当性向']
    )
  end
end

Dividend.import(dividends)