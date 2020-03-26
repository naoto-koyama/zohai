class Api::DividendsController < ApplicationController
  def index
    @brand_latest_dividends = BrandLatestDividend.includes(:brand).includes(:dividend)
  end
end
