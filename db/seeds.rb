require 'factory_bot'
include FactoryBot::Syntax::Methods
FactoryBot.definition_file_paths = [ Rails.root.join('spec', 'factories') ]
FactoryBot.reload

(1..12).each do |month|
  (1..10).each do |n|
    create(:fiscal_year,
      fiscal_year: Date.new(Time.current.ago(n.years).year, month, 1)
    )
  end
end

100.times do |n|
  company = create(:company,
    code: Faker::Number.number(digits: 4).to_s,
    name: Faker::Company.name)

  fiscal_year = FiscalYear.where(fiscal_year: Faker::Date.in_date_period.beginning_of_month.ago(1.year)).first
  (1..10).each do |n|
    company_fiscal_year = create(:company_fiscal_year, company: company, fiscal_year: fiscal_year)

    surplus_dividend = Faker::Number.between(from: 1_000_000, to: 1_000_000_000)
    buyback = surplus_dividend * Faker::Number.between(from: 0, to: 1) * Faker::Number.between(from: 1, to: 100) / 100
    create(:dividend,
      company_fiscal_year: company_fiscal_year,
      indicated_dividend: Faker::Number.decimal(l_digits: 2, r_digits: 2),
      surplus_dividend: surplus_dividend,
      buyback: buyback
    )
  end
end

