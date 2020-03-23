class CreateCompanies < ActiveRecord::Migration[5.2]
  def change
    create_table :companies do |t|
      t.text :code, null: false
      t.text :name, null: false

      t.timestamps
    end
  end
end
