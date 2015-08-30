# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20150830063355) do

  create_table "carts", force: :cascade do |t|
    t.string   "session_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "categories", force: :cascade do |t|
    t.string   "name"
    t.integer  "category_id"
    t.string   "description"
    t.string   "permalink"
    t.datetime "created"
    t.integer  "update_id"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.string   "default_picture"
  end

  create_table "line_items", force: :cascade do |t|
    t.integer  "cart_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "listing_id"
    t.integer  "quantity"
  end

  create_table "listings", force: :cascade do |t|
    t.string   "name"
    t.integer  "product_id"
    t.decimal  "price"
    t.integer  "quantity"
    t.boolean  "active"
    t.datetime "update_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "orders", force: :cascade do |t|
    t.string   "first_name_billing"
    t.string   "last_name_billing"
    t.string   "company_billing"
    t.string   "address_line_one_billing"
    t.string   "address_line_two_billing"
    t.string   "city_billing"
    t.string   "country_billing"
    t.string   "state_billing"
    t.integer  "zip_billing"
    t.string   "phone_billing"
    t.string   "first_name_shipping"
    t.string   "last_name_shipping"
    t.string   "company_shipping"
    t.string   "address_line_one_shipping"
    t.string   "address_line_two_shipping"
    t.string   "city_shipping"
    t.string   "country_shipping"
    t.string   "state_shipping"
    t.integer  "zip_shipping"
    t.string   "phone_shipping"
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  create_table "payments", force: :cascade do |t|
    t.string   "transaction_id"
    t.string   "order_id"
    t.string   "gateway"
    t.decimal  "amount"
    t.integer  "status"
    t.string   "response_message"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
  end

  create_table "products", force: :cascade do |t|
    t.string   "name"
    t.integer  "category_id"
    t.string   "permalink"
    t.string   "description"
    t.string   "short_description"
    t.boolean  "active"
    t.decimal  "weight"
    t.datetime "created"
    t.integer  "update_id"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.integer  "default_listing_id"
    t.string   "default_picture"
  end

  create_table "stock_adjustments", force: :cascade do |t|
    t.integer  "order_id"
    t.integer  "listing_id"
    t.integer  "quantity"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
