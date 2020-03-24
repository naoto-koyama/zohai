# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_03_24_010341) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "companies", force: :cascade do |t|
    t.text "code", null: false
    t.text "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "company_fiscal_years", force: :cascade do |t|
    t.bigint "company_id"
    t.bigint "fiscal_year_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["company_id"], name: "index_company_fiscal_years_on_company_id"
    t.index ["fiscal_year_id"], name: "index_company_fiscal_years_on_fiscal_year_id"
  end

  create_table "dividends", force: :cascade do |t|
    t.bigint "company_fiscal_year_id"
    t.decimal "indicated_dividend", precision: 6, scale: 4, null: false
    t.bigint "surplus_dividend", null: false
    t.bigint "buyback", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "continuous_dividend_increase_years", default: 0, null: false
    t.decimal "payout_ratio"
    t.index ["company_fiscal_year_id"], name: "index_dividends_on_company_fiscal_year_id"
  end

  create_table "fiscal_years", force: :cascade do |t|
    t.date "fiscal_year"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "company_fiscal_years", "companies"
  add_foreign_key "company_fiscal_years", "fiscal_years"
  add_foreign_key "dividends", "company_fiscal_years"
end
