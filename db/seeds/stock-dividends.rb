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
      indicated_dividend: dividend['一株配当'].nil? ? 0 : dividend['一株配当'],
      surplus_dividend: dividend['剰余金の配当'].nil? ? 0 : dividend['剰余金の配当'],
      buyback: dividend['自社株買い'].nil? ? 0 : dividend['自社株買い'],
      payout_ratio: dividend['配当性向'].nil? ? 0 : dividend['配当性向']
    )
  end
end

Dividend.import(dividends)

# update continuous_dividend_increase_years
dividends = []
Brand.all.each do |brand|
  dividend_of_last_year = nil
  continuous_dividend_increase_years_of_last_year = 0
  brand.brand_fiscal_years.order_by_fiscal_year('asc').each_with_index do |brand_fiscal_year, index|
    if index.zero? || brand_fiscal_year.dividend.indicated_dividend <= dividend_of_last_year.indicated_dividend
      dividend_of_last_year = brand_fiscal_year.dividend
      continuous_dividend_increase_years_of_last_year = 0
      next
    end

    if brand_fiscal_year.dividend.indicated_dividend > dividend_of_last_year.indicated_dividend
      dividends << Dividend.new(
        brand_fiscal_year_id: brand_fiscal_year.id,
        continuous_dividend_increase_years: continuous_dividend_increase_years_of_last_year + 1,
        indicated_dividend: brand_fiscal_year.dividend.indicated_dividend,
        surplus_dividend: brand_fiscal_year.dividend.surplus_dividend,
        buyback: brand_fiscal_year.dividend.buyback,
        payout_ratio: brand_fiscal_year.dividend.payout_ratio
      )
      continuous_dividend_increase_years_of_last_year += 1
    end

    dividend_of_last_year = brand_fiscal_year.dividend
  end

end

Dividend.import(dividends,
  on_duplicate_key_update: {
    conflict_target: "brand_fiscal_year_id",
    columns: ['continuous_dividend_increase_years']
  }
)
