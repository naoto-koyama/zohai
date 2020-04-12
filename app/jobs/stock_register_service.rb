require 'open-uri'
require 'zip'
require 'csv'

class StockRegisterService
  include ActiveModel::Model

  USER_AGENT = 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/74.0.3729.169 Safari/537.36'
  def zip_download
    open("#{download_dir}/#{file_name}.zip", 'wb') do |out|
      open(download_url, { 'User-Agent' => USER_AGENT, 'Referer' => referer }) do |data|
        out.write(data.read)
      end
    end

    Zip::File.open("#{download_dir}/#{file_name}.zip") do |zip|
      zip.each do |entry|
        zip.extract(entry, "#{download_dir}/#{file_name}.csv") { true }
      end
    end
  end

  def csv_to_db
    stocks = []
    CSV.foreach("#{download_dir}/#{file_name}.csv", encoding: 'Shift_JIS:UTF-8').each do |_stock|
      brand = Brand.find_by_code(_stock[1])
      next if brand.nil?
      stocks << LatestStock.new(
        brand_id: brand.id,
        trading_date: _stock[0],
        open_price: _stock[4],
        high_price: _stock[5],
        low_price: _stock[6],
        close_price: _stock[7],
        trading_volume: _stock[8],
        )
    end

    ActiveRecord::Base.connection.execute("TRUNCATE TABLE latest_stocks;")
    LatestStock.import!(stocks)
  end

  private

  def year
    # Time.current.year.to_s
    '20'
  end

  def month
    '04'
  end

  def day
    '10'
  end

  def download_url
    "http://mujinzou.com/d_data/20#{year}d/#{year}_#{month}d/T#{file_name}.zip"
  end

  def referer
    "http://mujinzou.com/#{year}#{month}_day_calendar.htm"
  end

  def download_dir
    "#{Rails.root}/tmp/stock"
  end

  def file_name
    @file_name ||= "#{year}#{month}#{day}"
  end
end
