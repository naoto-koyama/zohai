class AddPayoutRatioToDividend < ActiveRecord::Migration[5.2]
  def change
    add_column :dividends, :payout_ratio,:numeric, precision: 6, scale: 2
  end
end
