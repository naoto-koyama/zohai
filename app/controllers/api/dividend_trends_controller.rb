class Api::DividendTrendsController < ApplicationController
  def show
    @dividend = BrandLatestDividend.find(params[:id]).dividend
  end
end
