class StockRegisterJob < ApplicationJob
  sidekiq_options queue: :stock_register, retry: 0

  def perform
    stock_register_service = StockRegisterService.call
  end
end
