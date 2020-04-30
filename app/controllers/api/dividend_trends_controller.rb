class Api::DividendTrendsController < ApplicationController
  def show
    @brand_fiscal_years = BrandFiscalYear.where(brand_id: brand.id).order_by_fiscal_year
  end

  private

  def brand
    Brand.find_by(code: params[:id])
  end
end
