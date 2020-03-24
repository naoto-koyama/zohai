class Api::DividendsController < ApplicationController
  def index
    @brands = Brand.all
  end
end
