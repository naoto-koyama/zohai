brand_latest_dividends = []
Brand.all.each do |brand|
  brand_latest_dividends << BrandLatestDividend.new(brand: brand, dividend: brand.latest_dividend, fiscal_year: brand.latest_dividend&.fiscal_year_date)
end

BrandLatestDividend.import(brand_latest_dividends)
