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

ActiveRecord::Schema.define(version: 2020_05_29_123427) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "accounts", force: :cascade do |t|
    t.bigint "user_id"
    t.string "nickname"
    t.string "phone"
    t.string "city"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_accounts_on_user_id"
  end

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.bigint "byte_size", null: false
    t.string "checksum", null: false
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "ad_bars", force: :cascade do |t|
    t.bigint "ad_id"
    t.bigint "bar_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["ad_id"], name: "index_ad_bars_on_ad_id"
    t.index ["bar_id"], name: "index_ad_bars_on_bar_id"
  end

  create_table "ad_boards", force: :cascade do |t|
    t.bigint "ad_id"
    t.bigint "board_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["ad_id"], name: "index_ad_boards_on_ad_id"
    t.index ["board_id"], name: "index_ad_boards_on_board_id"
  end

  create_table "ad_kites", force: :cascade do |t|
    t.bigint "ad_id"
    t.bigint "kite_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["ad_id"], name: "index_ad_kites_on_ad_id"
    t.index ["kite_id"], name: "index_ad_kites_on_kite_id"
  end

  create_table "ad_stuffs", force: :cascade do |t|
    t.bigint "ad_id"
    t.bigint "stuff_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["ad_id"], name: "index_ad_stuffs_on_ad_id"
    t.index ["stuff_id"], name: "index_ad_stuffs_on_stuff_id"
  end

  create_table "ads", force: :cascade do |t|
    t.string "title", null: false
    t.text "description"
    t.integer "total_price", null: false
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "approve", default: false
    t.index ["user_id"], name: "index_ads_on_user_id"
  end

  create_table "bar_names", force: :cascade do |t|
    t.bigint "brand_id"
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "approve", default: false
    t.index ["brand_id"], name: "index_bar_names_on_brand_id"
  end

  create_table "bars", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "bar_name_id"
    t.integer "length", null: false
    t.integer "year", null: false
    t.integer "price", null: false
    t.integer "quality", null: false
    t.boolean "singly_sale", default: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["bar_name_id"], name: "index_bars_on_bar_name_id"
    t.index ["user_id"], name: "index_bars_on_user_id"
  end

  create_table "board_names", force: :cascade do |t|
    t.bigint "brand_id"
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "approve", default: false
    t.index ["brand_id"], name: "index_board_names_on_brand_id"
  end

  create_table "boards", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "board_name_id"
    t.integer "width", null: false
    t.integer "length", null: false
    t.boolean "pads", default: true
    t.boolean "fins", default: true
    t.boolean "singly_sale", default: true
    t.integer "year", null: false
    t.integer "quality", null: false
    t.integer "price", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["board_name_id"], name: "index_boards_on_board_name_id"
    t.index ["user_id"], name: "index_boards_on_user_id"
  end

  create_table "brands", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "approve", default: false
  end

  create_table "kite_names", force: :cascade do |t|
    t.bigint "brand_id"
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "approve", default: false
    t.index ["brand_id"], name: "index_kite_names_on_brand_id"
  end

  create_table "kites", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "kite_name_id"
    t.integer "year", null: false
    t.integer "size", null: false
    t.integer "price", null: false
    t.integer "quality", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "singly_sale", default: true
    t.index ["kite_name_id"], name: "index_kites_on_kite_name_id"
    t.index ["user_id"], name: "index_kites_on_user_id"
  end

  create_table "stuff_names", force: :cascade do |t|
    t.bigint "brand_id"
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "approve", default: false
    t.index ["brand_id"], name: "index_stuff_names_on_brand_id"
  end

  create_table "stuffs", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "stuff_name_id"
    t.integer "price", null: false
    t.integer "quality", null: false
    t.integer "year"
    t.text "description"
    t.boolean "singly_sale", default: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["stuff_name_id"], name: "index_stuffs_on_stuff_name_id"
    t.index ["user_id"], name: "index_stuffs_on_user_id"
  end

  create_table "subscriptions", force: :cascade do |t|
    t.bigint "user_id"
    t.string "subscriptionable_type"
    t.bigint "subscriptionable_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["subscriptionable_type", "subscriptionable_id"], name: "index_subscription"
    t.index ["user_id"], name: "index_subscriptions_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "role", default: "User"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "accounts", "users"
  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "ad_bars", "ads"
  add_foreign_key "ad_bars", "bars"
  add_foreign_key "ad_boards", "ads"
  add_foreign_key "ad_boards", "boards"
  add_foreign_key "ad_kites", "ads"
  add_foreign_key "ad_kites", "kites"
  add_foreign_key "ad_stuffs", "ads"
  add_foreign_key "ad_stuffs", "stuffs"
  add_foreign_key "ads", "users"
  add_foreign_key "bar_names", "brands"
  add_foreign_key "bars", "bar_names"
  add_foreign_key "bars", "users"
  add_foreign_key "board_names", "brands"
  add_foreign_key "boards", "board_names"
  add_foreign_key "boards", "users"
  add_foreign_key "kite_names", "brands"
  add_foreign_key "kites", "kite_names"
  add_foreign_key "kites", "users"
  add_foreign_key "stuff_names", "brands"
  add_foreign_key "stuffs", "stuff_names"
  add_foreign_key "stuffs", "users"
  add_foreign_key "subscriptions", "users"
end
