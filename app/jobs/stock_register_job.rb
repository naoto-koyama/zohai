class StockRegisterJob < ApplicationJob
  include Sidekiq::Worker
  sidekiq_options queue: :stock_register
  def perform
    system("python3 #{Rails.root}/app/jobs/export_stock_csv.py #{Brand.pluck(:code).join(" ")}")
    f = open("#{Rails.root}/tmp/stooq_csv/stock_list.csv")
    f.readline
    @stocks = []
    CSV.new(f, headers: true).each do |_stock|
      stock = Stock.find_or_initialize_by(brand_id: id)

      stock.update_attributes(
        brand_id: id,
        date: _stock['Date'],
        close_stock_price: _stock['Close']
      )
    end
  end
end
