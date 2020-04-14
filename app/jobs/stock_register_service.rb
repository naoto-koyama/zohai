require 'open-uri'
require 'zip'
require 'csv'
require 'net/http'
require "fileutils"

class StockRegisterService
  USER_AGENT = 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/74.0.3729.169 Safari/537.36'.freeze
  class << self
    def call
      zip_download
      csv_to_db
      delete_download_file
    end

    private

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

      ActiveRecord::Base.transaction do
        ActiveRecord::Base.connection.execute('TRUNCATE TABLE latest_stocks;')
        LatestStock.import!(stocks)
      end
    end

    def delete_download_file
      FileUtils.rm("#{download_dir}/#{file_name}.zip")
      FileUtils.rm("#{download_dir}/#{file_name}.csv")
    end

    def download_date
      return @download_date unless @download_date.nil?
      time_current = Time.current
      date = time_current
      loop do
        break if url_exist?(url_build(date)) || (date == time_current - 7.days)
        date -= 1.day
      end
      @download_date = date
    end

    def url_exist?(url)
      res = ->(url) {
        begin
          uri = URI.parse(url)
          uri_path = uri.path.empty? ? '/' : uri.path
          Net::HTTP.start(uri.host, uri.port) { |http| http.get(uri_path) }
        rescue TypeError, SocketError, URI::InvalidURIError
          false
        end
      }
      !url.nil? && !url.empty? && (Net::HTTPSuccess === res.call(url) || Net::HTTPRedirection === res.call(url))
    end

    def download_url
      url_build(download_date)
    end

    def url_build(date)
      year = date.strftime('%y')
      month = date.strftime('%m')
      "http://mujinzou.com/d_data/20#{year}d/#{year}_#{month}d/T#{date.strftime('%y%m%d')}.zip"
    end

    def referer
      year = download_date.strftime('%y')
      month = download_date.strftime('%m')
      "http://mujinzou.com/#{year}#{month}_day_calendar.htm"
    end

    def download_dir
      "#{Rails.root}/tmp/stock"
    end

    def file_name
      @file_name ||= download_date.strftime('%y%m%d')
    end
  end
end
