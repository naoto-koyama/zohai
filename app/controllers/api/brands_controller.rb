class Api::BrandsController < ApplicationController
  def show
    render json: Brand.find(params[:id])
  end
end
