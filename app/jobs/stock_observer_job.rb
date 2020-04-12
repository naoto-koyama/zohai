class StockObserverJob < ApplicationJob
  sidekiq_options queue: :stock_observer, retry: 0

  def perform
    StockRegisterJob.perform_async
  end
end
