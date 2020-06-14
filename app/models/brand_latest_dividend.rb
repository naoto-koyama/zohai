class BrandLatestDividend < ApplicationRecord
  belongs_to :brand
  belongs_to :dividend

  def yield
    brand.latest_stock.present? ? dividend.indicated_dividend.to_f * 100 / brand.latest_stock&.close_price : 0
  end
end
