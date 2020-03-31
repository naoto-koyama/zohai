def continuous_dividend_increase_years(_continuous_dividend_increase_years, indicated_dividend_of_last_year, indicated_dividend_of_current_year, is_first)
  return 0 if is_first

  indicated_dividend_of_last_year <= indicated_dividend_of_current_year ? _continuous_dividend_increase_years + 1 : 0
end

ActiveRecord::Base.transaction do
  fiscal_years = []
  (0..132).each do |month|
    create_time = Time.current.ago(month.months)
    fiscal_years << FiscalYear.new(fiscal_year: Date.new(create_time.year, create_time.month, 1))
  end
  FiscalYear.import!(fiscal_years)

  brands = []
  100.times do |n|
    brands << Brand.new(
      code: Faker::Number.unique.number(digits: 4).to_s,
      name: Faker::Company.unique.name
    )
  end
  Brand.import!(brands)

  dividend = nil
  Brand.all.each do |brand|
    _continuous_dividend_increase_years = 0
    date_of_fiscal_year = Faker::Date.in_date_period.beginning_of_month
    (1..10).reverse_each do |n|
      fiscal_year = FiscalYear.where(fiscal_year: date_of_fiscal_year.ago(n.years)).first
      brand_fiscal_year = BrandFiscalYear.create!(brand: brand, fiscal_year: fiscal_year)

      surplus_dividend = Faker::Number.between(from: 1_000_000, to: 1_000_000_000)
      indicated_dividend = Faker::Number.decimal(l_digits: 2, r_digits: 2)
      _continuous_dividend_increase_years = continuous_dividend_increase_years(_continuous_dividend_increase_years, dividend&.indicated_dividend, indicated_dividend, n == 10)
      dividend = Dividend.create!(
        brand_fiscal_year: brand_fiscal_year,
        indicated_dividend: indicated_dividend,
        surplus_dividend: surplus_dividend,
        buyback: (surplus_dividend * Faker::Number.between(from: 0, to: 1) * Faker::Number.between(from: 1, to: 100) / 100),
        payout_ratio: Faker::Number.decimal(l_digits: 2, r_digits: 2),
        continuous_dividend_increase_years: _continuous_dividend_increase_years
      )
    end
  end

  brand_latest_dividends = []
  Brand.all.each do |brand|
    brand_latest_dividends << BrandLatestDividend.new(brand: brand, dividend: brand.latest_dividend, fiscal_year: brand.latest_dividend.fiscal_year_date)
  end
  BrandLatestDividend.import!(brand_latest_dividends)
end