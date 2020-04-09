class Api::DividendsController < ApplicationController
  def index
    StockRegisterJob.perform_async
    @brand_latest_dividends = BrandLatestDividend.includes(:brand).includes(:dividend)
  end
end
