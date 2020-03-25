require 'factory_bot'
include FactoryBot::Syntax::Methods
FactoryBot.definition_file_paths = [ Rails.root.join('spec', 'factories') ]
FactoryBot.reload

def continuous_dividend_increase_years(_continuous_dividend_increase_years, indicated_dividend_of_last_year, indicated_dividend_of_current_year, is_first)
  return 0 if is_first

  indicated_dividend_of_last_year <= indicated_dividend_of_current_year ? _continuous_dividend_increase_years + 1 : 0
end

ActiveRecord::Base.transaction do
  (1..12).each do |month|
    (1..10).each do |n|
      create(:fiscal_year,
        fiscal_year: Date.new(Time.current.ago(n.years).year, month, 1)
      )
    end
  end

  dividend = nil
  100.times do |n|
    brand = create(:brand,
      code: Faker::Number.unique.number(digits: 4).to_s,
      name: Faker::Company.unique.name)

    _continuous_dividend_increase_years = 0
    date_of_fiscal_year = Faker::Date.in_date_period.beginning_of_month
    (1..10).reverse_each do |n|
      fiscal_year = FiscalYear.where(fiscal_year: date_of_fiscal_year.ago(n.years)).first
      surplus_dividend = Faker::Number.between(from: 1_000_000, to: 1_000_000_000)
      indicated_dividend = Faker::Number.decimal(l_digits: 2, r_digits: 2)

      brand_fiscal_year = create(:brand_fiscal_year,
                                   brand: brand,
                                   fiscal_year: fiscal_year)

      _continuous_dividend_increase_years = continuous_dividend_increase_years(_continuous_dividend_increase_years, dividend&.indicated_dividend, indicated_dividend, n == 10)
      dividend = create(:dividend,
        brand_fiscal_year: brand_fiscal_year,
        indicated_dividend: indicated_dividend,
        surplus_dividend: surplus_dividend,
        buyback: (surplus_dividend * Faker::Number.between(from: 0, to: 1) * Faker::Number.between(from: 1, to: 100) / 100),
        payout_ratio: Faker::Number.decimal(l_digits: 2, r_digits: 2),
        continuous_dividend_increase_years: _continuous_dividend_increase_years
      )
    end
  end
end