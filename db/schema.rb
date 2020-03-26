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

ActiveRecord::Schema.define(version: 2020_03_26_004241) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "brand_fiscal_years", force: :cascade do |t|
    t.bigint "brand_id"
    t.bigint "fiscal_year_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["brand_id"], name: "index_brand_fiscal_years_on_brand_id"
    t.index ["fiscal_year_id"], name: "index_brand_fiscal_years_on_fiscal_year_id"
  end

  create_table "brand_latest_dividends", force: :cascade do |t|
    t.bigint "brand_id"
    t.bigint "dividend_id"
    t.date "fiscal_year"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["brand_id"], name: "index_brand_latest_dividends_on_brand_id"
    t.index ["dividend_id"], name: "index_brand_latest_dividends_on_dividend_id"
  end

  create_table "brands", force: :cascade do |t|
    t.text "code", null: false
    t.text "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["code"], name: "index_brands_on_code", unique: true
  end

  create_table "dividends", force: :cascade do |t|
    t.bigint "brand_fiscal_year_id"
    t.decimal "indicated_dividend", null: false
    t.bigint "surplus_dividend", null: false
    t.bigint "buyback", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "continuous_dividend_increase_years", default: 0, null: false
    t.decimal "payout_ratio"
    t.index ["brand_fiscal_year_id"], name: "index_dividends_on_brand_fiscal_year_id"
    t.index ["brand_fiscal_year_id"], name: "index_dividends_on_brand_fiscal_year_id_unique", unique: true
  end

  create_table "fiscal_years", force: :cascade do |t|
    t.date "fiscal_year"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["fiscal_year"], name: "index_fiscal_years_on_fiscal_year", unique: true
  end

  add_foreign_key "brand_fiscal_years", "brands"
  add_foreign_key "brand_fiscal_years", "fiscal_years"
  add_foreign_key "brand_latest_dividends", "brands"
  add_foreign_key "brand_latest_dividends", "dividends"
  add_foreign_key "dividends", "brand_fiscal_years"
end
