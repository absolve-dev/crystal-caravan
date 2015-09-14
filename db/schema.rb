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

ActiveRecord::Schema.define(version: 20150914225036) do

  create_table "admins", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.integer  "failed_attempts",        default: 0
    t.string   "unlock_token"
    t.datetime "locked_at"
  end

  add_index "admins", ["email"], name: "index_admins_on_email", unique: true
  add_index "admins", ["reset_password_token"], name: "index_admins_on_reset_password_token", unique: true

  create_table "carts", force: :cascade do |t|
    t.string   "session_id"
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
    t.boolean  "active_order", default: false
    t.integer  "order_id"
  end

  create_table "catalog_cards", force: :cascade do |t|
    t.string   "name"
    t.integer  "catalog_set_id"
    t.string   "card_data_json"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.string   "product_image"
    t.integer  "product_id"
  end

  create_table "catalog_sets", force: :cascade do |t|
    t.string   "name"
    t.integer  "catalog_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.integer  "category_id"
  end

  create_table "catalogs", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.string   "library_name"
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
    t.datetime "created_at",                            null: false
    t.datetime "updated_at",                            null: false
    t.integer  "cart_id"
    t.integer  "order_status",              default: 0
    t.string   "origin_ip"
    t.integer  "payment_id"
    t.integer  "shipping_method_id"
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
    t.string   "product_image"
  end

  create_table "shipping_methods", force: :cascade do |t|
    t.string   "name"
    t.boolean  "active"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
    t.decimal  "price"
    t.integer  "shipping_service_id"
  end

  create_table "shipping_services", force: :cascade do |t|
    t.string   "name"
    t.boolean  "active"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "stock_adjustments", force: :cascade do |t|
    t.integer  "order_id"
    t.integer  "listing_id"
    t.integer  "quantity"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

end
