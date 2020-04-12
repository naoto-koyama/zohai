class StockRegisterJob < ApplicationJob
  sidekiq_options queue: :stock_register, retry: 0

  def perform
    stock_register_service = StockRegisterService.new
    stock_register_service.zip_download
    stock_register_service.csv_to_db
  end
end
