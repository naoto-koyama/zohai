fiscal_years = []
(0..120).each do |month|
  create_time = Time.current.ago(month.months)
  fiscal_years << FiscalYear.new(fiscal_year: Date.new(create_time.year, create_time.month, 1))
end

FiscalYear.import(fiscal_years)