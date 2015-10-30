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

ActiveRecord::Schema.define(version: 20151030054350) do

  create_table "administrators", force: :cascade do |t|
    t.string   "mobile",          limit: 255,                   null: false
    t.string   "password_digest", limit: 255,                   null: false
    t.boolean  "admin_power",     limit: 1,     default: false
    t.boolean  "edit_power",      limit: 1,     default: false
    t.boolean  "order_power",     limit: 1,     default: false
    t.text     "ext",             limit: 65535
    t.datetime "created_at",                                    null: false
    t.datetime "updated_at",                                    null: false
    t.datetime "deleted_at"
  end

  create_table "areas", force: :cascade do |t|
    t.string   "province",   limit: 255
    t.string   "city",       limit: 255
    t.string   "region",     limit: 255
    t.string   "name",       limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "assets", force: :cascade do |t|
    t.string   "resource",   limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "categories", force: :cascade do |t|
    t.string   "name",          limit: 255
    t.integer  "category_type", limit: 4,     default: 0, null: false
    t.integer  "status",        limit: 4,     default: 0, null: false
    t.integer  "queue",         limit: 4,     default: 0, null: false
    t.text     "ext",           limit: 65535
    t.datetime "created_at",                              null: false
    t.datetime "updated_at",                              null: false
    t.datetime "deleted_at"
  end

  create_table "cities", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "coupons", force: :cascade do |t|
    t.string   "name",        limit: 255
    t.decimal  "price",                   precision: 16, scale: 3, default: 0.0, null: false
    t.decimal  "minimum",                 precision: 16, scale: 3, default: 0.0, null: false
    t.string   "desc",        limit: 255
    t.integer  "coupon_type", limit: 4
    t.datetime "start_at"
    t.datetime "expired_at"
    t.datetime "created_at",                                                     null: false
    t.datetime "updated_at",                                                     null: false
  end

  create_table "goods", force: :cascade do |t|
    t.integer  "status",          limit: 4,                              default: 0,   null: false
    t.string   "name",            limit: 255
    t.text     "description",     limit: 65535
    t.decimal  "origin_price",                  precision: 16, scale: 3, default: 0.0, null: false
    t.decimal  "price",                         precision: 16, scale: 3, default: 0.0, null: false
    t.string   "photo_asset_ids", limit: 255
    t.integer  "sales",           limit: 4,                              default: 0,   null: false
    t.integer  "likes",           limit: 4,                              default: 0,   null: false
    t.text     "ext",             limit: 65535
    t.datetime "created_at",                                                           null: false
    t.datetime "updated_at",                                                           null: false
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

  create_table "order_goods", force: :cascade do |t|
    t.integer  "order_id",   limit: 4
    t.integer  "good_id",    limit: 4
    t.decimal  "price",                    precision: 16, scale: 3, default: 0.0, null: false
    t.integer  "quantity",   limit: 4
    t.text     "ext",        limit: 65535
    t.datetime "created_at",                                                      null: false
    t.datetime "updated_at",                                                      null: false
  end

  create_table "order_payments", force: :cascade do |t|
    t.string   "order_id",   limit: 255, null: false
    t.string   "payment_no", limit: 255, null: false
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  add_index "order_payments", ["order_id", "payment_no"], name: "index_order_payments_on_order_id_and_payment_no", using: :btree
  add_index "order_payments", ["order_id"], name: "index_order_payments_on_order_id", using: :btree
  add_index "order_payments", ["payment_no"], name: "index_order_payments_on_payment_no", using: :btree

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

  create_table "payments", force: :cascade do |t|
    t.integer  "user_id",                 limit: 4
    t.string   "payment_no",              limit: 191,                                          null: false
    t.string   "subject",                 limit: 255,                                          null: false
    t.decimal  "original_amount",                     precision: 16, scale: 3, default: 0.0,   null: false
    t.decimal  "amount",                              precision: 16, scale: 3, default: 0.0,   null: false
    t.integer  "gateway",                 limit: 4,                            default: 0
    t.string   "gateway_transacation_id", limit: 255
    t.boolean  "notified",                limit: 1,                            default: false
    t.integer  "status",                  limit: 4,                            default: 0
    t.datetime "deleted_at"
    t.datetime "created_at",                                                                   null: false
    t.datetime "updated_at",                                                                   null: false
  end

  create_table "posters", force: :cascade do |t|
    t.integer  "asset_id",   limit: 4
    t.integer  "good_id",    limit: 4
    t.text     "ext",        limit: 65535
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  create_table "regions", force: :cascade do |t|
    t.integer  "city_id",    limit: 4
    t.string   "name",       limit: 255, null: false
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "schools", force: :cascade do |t|
    t.string   "province",   limit: 255
    t.string   "city",       limit: 255
    t.string   "region",     limit: 255
    t.string   "name",       limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "taggings", force: :cascade do |t|
    t.integer  "tag_id",        limit: 4
    t.integer  "taggable_id",   limit: 4
    t.string   "taggable_type", limit: 255
    t.integer  "tagger_id",     limit: 4
    t.string   "tagger_type",   limit: 255
    t.string   "context",       limit: 128
    t.datetime "created_at"
  end

  add_index "taggings", ["tag_id", "taggable_id", "taggable_type", "context", "tagger_id", "tagger_type"], name: "taggings_idx", unique: true, using: :btree
  add_index "taggings", ["taggable_id", "taggable_type", "context"], name: "index_taggings_on_taggable_id_and_taggable_type_and_context", using: :btree

  create_table "tags", force: :cascade do |t|
    t.string  "name",           limit: 255
    t.integer "taggings_count", limit: 4,   default: 0
  end

  add_index "tags", ["name"], name: "index_tags_on_name", unique: true, using: :btree

  create_table "tokens", force: :cascade do |t|
    t.string   "mobile",     limit: 255
    t.string   "body",       limit: 255
    t.integer  "token_type", limit: 4,     default: 0, null: false
    t.integer  "status",     limit: 4,     default: 0, null: false
    t.text     "ext",        limit: 65535
    t.datetime "created_at",                           null: false
    t.datetime "updated_at",                           null: false
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
    t.string   "area",       limit: 255
    t.string   "school",     limit: 255
    t.string   "address",    limit: 255
    t.string   "name",       limit: 255
    t.string   "mobile",     limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  add_index "user_shippings", ["user_id"], name: "index_user_shippings_on_user_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "mobile",            limit: 255,                   null: false
    t.string   "avatar",            limit: 255
    t.string   "private_token",     limit: 255
    t.boolean  "get_regist_coupon", limit: 1,     default: false, null: false
    t.string   "invite_code",       limit: 255
    t.boolean  "used_invite_code",  limit: 1,     default: false, null: false
    t.text     "ext",               limit: 65535
    t.datetime "created_at",                                      null: false
    t.datetime "updated_at",                                      null: false
    t.datetime "deleted_at"
  end

  create_table "warehouses", force: :cascade do |t|
    t.integer  "region_id",     limit: 4
    t.string   "name",          limit: 255,   null: false
    t.string   "business_time", limit: 255
    t.string   "address",       limit: 255,   null: false
    t.string   "longitude",     limit: 255
    t.string   "latitude",      limit: 255
    t.string   "tel",           limit: 255
    t.text     "content",       limit: 65535
    t.string   "url",           limit: 255
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
  end

end
