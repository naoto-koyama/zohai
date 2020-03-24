class Api::DividendsController < ApplicationController
  def index
    @companies = Company.all
  end
end
