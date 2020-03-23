class Api::DividendsController < ApplicationController
  def index
    @companies = Company.order(:code)
  end
end
