require 'csv'

path = File.join Rails.root, 'db/seeds/csv/brand_list.csv'

brands = []
CSV.foreach(path, headers: true) do |brand|
  brands << Brand.new(
    code: brand['コード'],
    name: brand['銘柄名']
  )
end

Brand.import(brands)