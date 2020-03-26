class Api::DividendTrendsController < ApplicationController
  def show
    @brand_fiscal_years = BrandFiscalYear.where(brand_id: brand_latest_dividend.brand_id).order_by_fiscal_year
  end

  private

  def brand_latest_dividend
    BrandLatestDividend.find(params[:id])
  end
end
