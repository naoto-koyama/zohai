module DividendDecorator
  def display_payout_ratio
    payout_ratio.nil? ? "-" : "#{payout_ratio}%"
  end
end
