class StockObserverJob < ApplicationJob
  sidekiq_options queue: :stock_observer
  def perform
    StockRegisterJob.perform_async
  end
end
