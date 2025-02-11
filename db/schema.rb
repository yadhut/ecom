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

ActiveRecord::Schema[7.2].define(version: 2025_02_10_171234) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "bookings", force: :cascade do |t|
    t.string "reference_id", null: false
    t.bigint "user_id", null: false
    t.bigint "payment_id"
    t.bigint "hotel_id", null: false
    t.date "booking_date", null: false
    t.date "checkin_date", null: false
    t.date "checkout_date", null: false
    t.decimal "amount", null: false
    t.string "status", default: "pending"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["hotel_id"], name: "index_bookings_on_hotel_id"
    t.index ["payment_id"], name: "index_bookings_on_payment_id"
    t.index ["user_id"], name: "index_bookings_on_user_id"
  end

  create_table "coupons", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "milestone_id", null: false
    t.string "status", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["milestone_id"], name: "index_coupons_on_milestone_id"
    t.index ["user_id"], name: "index_coupons_on_user_id"
  end

  create_table "hotels", force: :cascade do |t|
    t.string "name", null: false
    t.text "address", null: false
    t.string "pin_code", null: false
    t.string "category", null: false
    t.string "status", default: "available"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "invoices", force: :cascade do |t|
    t.bigint "booking_id"
    t.string "invoice_no", null: false
    t.json "metadata"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["booking_id"], name: "index_invoices_on_booking_id"
  end

  create_table "milestones", force: :cascade do |t|
    t.string "code", null: false
    t.integer "discount", null: false
    t.integer "life_span", null: false
    t.integer "milestones_days", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "orders", force: :cascade do |t|
    t.string "order_id", null: false
    t.bigint "user_id", null: false
    t.decimal "amount", null: false
    t.string "type", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_orders_on_user_id"
  end

  create_table "payments", force: :cascade do |t|
    t.decimal "amount", null: false
    t.string "status", default: "pending"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "uid", null: false
    t.string "first_name", null: false
    t.string "last_name"
    t.date "dob", null: false
    t.string "email", null: false
    t.string "phone_number"
    t.string "password_digest", null: false
    t.string "role", default: "member", null: false
    t.string "state", default: "pending", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end
end
