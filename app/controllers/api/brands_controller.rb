class Api::BrandsController < ApplicationController
  def show
    render json: Brand.find_by(code: params[:id])
  end
end
