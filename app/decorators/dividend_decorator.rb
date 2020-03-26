module DividendDecorator
  def display_payout_ratio
    payout_ratio.nil? ? "-" : "#{payout_ratio}%"
  end

  def display_continuous_dividend_increase_years
    "#{continuous_dividend_increase_years}年"
  end
end
