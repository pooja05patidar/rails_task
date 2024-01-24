# frozen_string_literal: true

# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.1].define(version: 20_240_119_180_032) do
  create_table 'cart_items', force: :cascade do |t|
    t.integer 'user_id', null: false
    t.integer 'menu_id', null: false
    t.integer 'quantity'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.integer 'cart_id'
    t.index ['cart_id'], name: 'index_cart_items_on_cart_id'
    t.index ['menu_id'], name: 'index_cart_items_on_menu_id'
    t.index ['user_id'], name: 'index_cart_items_on_user_id'
  end

  create_table 'carts', force: :cascade do |t|
    t.integer 'user_id', null: false
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['user_id'], name: 'index_carts_on_user_id'
  end

  create_table 'deliveries', force: :cascade do |t|
    t.integer 'order_id', null: false
    t.integer 'users_id', null: false
    t.string 'status'
    t.datetime 'delivery_time'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['order_id'], name: 'index_deliveries_on_order_id'
    t.index ['users_id'], name: 'index_deliveries_on_users_id'
  end

  create_table 'items', force: :cascade do |t|
    t.string 'name'
    t.decimal 'price'
    t.integer 'menu_id', null: false
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['menu_id'], name: 'index_items_on_menu_id'
  end

  create_table 'menu_item', force: :cascade do |t|
    t.string 'name'
    t.text 'description'
    t.decimal 'price'
    t.integer 'restaurant_id', null: false
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['restaurant_id'], name: 'index_menu_item_on_restaurant_id'
  end

  create_table 'order_items', force: :cascade do |t|
    t.integer 'order_id', null: false
    t.integer 'menu_id', null: false
    t.integer 'quantity'
    t.decimal 'total_price'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['menu_id'], name: 'index_order_items_on_menu_id'
    t.index ['order_id'], name: 'index_order_items_on_order_id'
  end

  create_table 'orders', force: :cascade do |t|
    t.integer 'user_id', null: false
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.integer 'order_id'
    t.index ['user_id'], name: 'index_orders_on_user_id'
  end

  create_table 'restaurants', force: :cascade do |t|
    t.string 'name'
    t.text 'description'
    t.decimal 'ratings'
    t.integer 'user_id', null: false
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['user_id'], name: 'index_restaurants_on_user_id'
  end

  create_table 'reviews', force: :cascade do |t|
    t.integer 'user_id', null: false
    t.integer 'restaurant_id', null: false
    t.integer 'rating'
    t.text 'comment'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['restaurant_id'], name: 'index_reviews_on_restaurant_id'
    t.index ['user_id'], name: 'index_reviews_on_user_id'
  end

  create_table 'users', force: :cascade do |t|
    t.string 'email', default: '', null: false
    t.string 'encrypted_password', default: '', null: false
    t.string 'reset_password_token'
    t.datetime 'reset_password_sent_at'
    t.datetime 'remember_created_at'
    t.integer 'role', default: 0
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.string 'jti', null: false
    t.string 'name'
    t.text 'address'
    t.integer 'contact'
    t.string 'aadhaar_card_number'
    t.string 'id_proof'
    t.integer 'age'
    t.string 'username'
    t.index ['email'], name: 'index_users_on_email', unique: true
    t.index ['jti'], name: 'index_users_on_jti', unique: true
    t.index ['reset_password_token'], name: 'index_users_on_reset_password_token', unique: true
  end

  add_foreign_key 'cart_items', 'carts'
  add_foreign_key 'cart_items', 'menu_item', column: 'menu_id'
  add_foreign_key 'cart_items', 'users'
  add_foreign_key 'carts', 'users'
  add_foreign_key 'deliveries', 'orders'
  add_foreign_key 'deliveries', 'users', column: 'users_id'
  add_foreign_key 'items', 'menu_item', column: 'menu_id'
  add_foreign_key 'menu_item', 'restaurants'
  add_foreign_key 'order_items', 'menu_item', column: 'menu_id'
  add_foreign_key 'order_items', 'orders'
  add_foreign_key 'orders', 'users'
  add_foreign_key 'restaurants', 'users'
  add_foreign_key 'reviews', 'restaurants'
  add_foreign_key 'reviews', 'users'
end
