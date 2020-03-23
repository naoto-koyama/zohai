require 'factory_bot'
include FactoryBot::Syntax::Methods
FactoryBot.definition_file_paths = [ Rails.root.join('spec', 'factories') ]
FactoryBot.reload

ActiveRecord::Base.transaction do
  (1..12).each do |month|
    (1..10).each do |n|
      create(:fiscal_year,
        fiscal_year: Date.new(Time.current.ago(n.years).year, month, 1)
      )
    end
  end

  company_fiscal_year = nil
  100.times do |n|
    company = create(:company,
      code: Faker::Number.number(digits: 4).to_s,
      name: Faker::Company.name)

    continuous_dividend_increase_years = 0
    date_of_fiscal_year = Faker::Date.in_date_period.beginning_of_month
    (1..10).reverse_each do |n|
      fiscal_year = FiscalYear.where(fiscal_year: date_of_fiscal_year.ago(n.years)).first
      surplus_dividend = Faker::Number.between(from: 1_000_000, to: 1_000_000_000)
      buyback = surplus_dividend * Faker::Number.between(from: 0, to: 1) * Faker::Number.between(from: 1, to: 100) / 100
      indicated_dividend = Faker::Number.decimal(l_digits: 2, r_digits: 2)

      if n == 10
        continuous_dividend_increase_years = 0
      end

      unless n == 10
        if company_fiscal_year.indicated_dividend <= indicated_dividend
          continuous_dividend_increase_years += 1
        else
          continuous_dividend_increase_years = 0
        end
      end
      company_fiscal_year = create(:company_fiscal_year,
                                   company: company,
                                   fiscal_year: fiscal_year,
                                   continuous_dividend_increase_years: continuous_dividend_increase_years)

      create(:dividend,
        company_fiscal_year: company_fiscal_year,
        indicated_dividend: indicated_dividend,
        surplus_dividend: surplus_dividend,
        buyback: buyback
      )
    end
  end
end
