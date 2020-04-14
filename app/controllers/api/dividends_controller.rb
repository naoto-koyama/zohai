class Api::DividendsController < ApplicationController
  def index
    @brand_latest_dividends = BrandLatestDividend.includes(brand: :latest_stock).includes(:dividend)
  end
end
