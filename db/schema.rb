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

ActiveRecord::Schema.define(version: 20150724020455) do

  create_table "assets", force: :cascade do |t|
    t.string   "resource",   limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "categories", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.text     "ext",        limit: 65535
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
    t.datetime "deleted_at"
  end

  create_table "coupons", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.decimal  "price",                  precision: 16, scale: 3, default: 0.0, null: false
    t.string   "desc",       limit: 255
    t.datetime "start_at"
    t.datetime "expired_at"
    t.datetime "created_at",                                                    null: false
    t.datetime "updated_at",                                                    null: false
  end

  create_table "delivery_areas", force: :cascade do |t|
    t.string   "province",   limit: 255
    t.string   "city",       limit: 255
    t.string   "region",     limit: 255
    t.string   "address",    limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "good_specs", force: :cascade do |t|
    t.integer  "good_id",         limit: 4
    t.integer  "status",          limit: 4,                              default: 0,   null: false
    t.string   "name",            limit: 255
    t.text     "description",     limit: 65535
    t.decimal  "origin_price",                  precision: 16, scale: 3, default: 0.0, null: false
    t.decimal  "price",                         precision: 16, scale: 3, default: 0.0, null: false
    t.string   "photo_asset_ids", limit: 255
    t.text     "ext",             limit: 65535
    t.datetime "created_at",                                                           null: false
    t.datetime "updated_at",                                                           null: false
    t.datetime "deleted_at"
  end

  add_index "good_specs", ["good_id"], name: "index_good_specs_on_good_id", using: :btree

  create_table "goods", force: :cascade do |t|
    t.string   "name",         limit: 255
    t.text     "description",  limit: 65535
    t.integer  "status",       limit: 4,                              default: 0,   null: false
    t.decimal  "origin_price",               precision: 16, scale: 3, default: 0.0, null: false
    t.decimal  "price",                      precision: 16, scale: 3, default: 0.0, null: false
    t.text     "ext",          limit: 65535
    t.datetime "created_at",                                                        null: false
    t.datetime "updated_at",                                                        null: false
    t.datetime "deleted_at"
  end

  add_index "goods", ["status"], name: "index_goods_on_status", using: :btree

  create_table "goods_categories", force: :cascade do |t|
    t.integer  "good_id",     limit: 4
    t.integer  "category_id", limit: 4
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
  end

  add_index "goods_categories", ["category_id"], name: "index_goods_categories_on_category_id", using: :btree
  add_index "goods_categories", ["good_id", "category_id"], name: "index_goods_categories_on_good_id_and_category_id", using: :btree
  add_index "goods_categories", ["good_id"], name: "index_goods_categories_on_good_id", using: :btree

  create_table "order_good_specs", force: :cascade do |t|
    t.integer  "order_id",     limit: 4
    t.integer  "good_spec_id", limit: 4
    t.decimal  "price",                  precision: 16, scale: 3, default: 0.0, null: false
    t.integer  "quantity",     limit: 4
    t.datetime "created_at",                                                    null: false
    t.datetime "updated_at",                                                    null: false
  end

  create_table "orders", force: :cascade do |t|
    t.integer  "user_id",            limit: 4
    t.string   "order_no",           limit: 255
    t.decimal  "origin_total_price",               precision: 16, scale: 3, default: 0.0, null: false
    t.decimal  "total_price",                      precision: 16, scale: 3, default: 0.0, null: false
    t.integer  "quantity",           limit: 4
    t.integer  "status",             limit: 4,                              default: 0,   null: false
    t.text     "ext",                limit: 65535
    t.datetime "created_at",                                                              null: false
    t.datetime "updated_at",                                                              null: false
  end

  create_table "posters", force: :cascade do |t|
    t.integer  "asset_id",   limit: 4
    t.integer  "good_id",    limit: 4
    t.text     "ext",        limit: 65535
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  create_table "tokens", force: :cascade do |t|
    t.string   "mobile",     limit: 255
    t.string   "body",       limit: 255
    t.integer  "type",       limit: 4,     null: false
    t.integer  "status",     limit: 4,     null: false
    t.text     "ext",        limit: 65535
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  add_index "tokens", ["mobile"], name: "index_tokens_on_mobile", using: :btree

  create_table "user_coupons", force: :cascade do |t|
    t.integer  "user_id",    limit: 4
    t.integer  "coupon_id",  limit: 4
    t.integer  "status",     limit: 4, default: 0, null: false
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
  end

  add_index "user_coupons", ["coupon_id"], name: "index_user_coupons_on_coupon_id", using: :btree
  add_index "user_coupons", ["user_id"], name: "index_user_coupons_on_user_id", using: :btree

  create_table "user_shippings", force: :cascade do |t|
    t.integer  "user_id",    limit: 4
    t.integer  "default",    limit: 4
    t.string   "province",   limit: 255
    t.string   "city",       limit: 255
    t.string   "region",     limit: 255
    t.string   "address",    limit: 255
    t.string   "zip_code",   limit: 255
    t.string   "name",       limit: 255
    t.string   "mobile",     limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  add_index "user_shippings", ["user_id"], name: "index_user_shippings_on_user_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "mobile",        limit: 255,   null: false
    t.string   "avatar",        limit: 255
    t.string   "private_token", limit: 255
    t.text     "ext",           limit: 65535
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.datetime "deleted_at"
  end

end
