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

ActiveRecord::Schema.define(version: 20191118172803) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "carriers", force: :cascade do |t|
    t.string   "name"
    t.integer  "age"
    t.boolean  "has_driver_licence_a"
    t.boolean  "has_driver_licence_b"
    t.boolean  "has_driver_licence_c"
    t.integer  "transporter_id"
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
  end

  add_index "carriers", ["transporter_id"], name: "index_carriers_on_transporter_id", using: :btree

  create_table "locations", force: :cascade do |t|
    t.float    "latitude"
    t.float    "longitude"
    t.float    "altitude"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "carrier_id"
  end

  add_index "locations", ["carrier_id"], name: "index_locations_on_carrier_id", using: :btree

  create_table "postal_codes", force: :cascade do |t|
    t.string   "code"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "postal_codes", ["code"], name: "index_postal_codes_on_code", unique: true, using: :btree

  create_table "transporter_postal_codes", force: :cascade do |t|
    t.integer  "transporter_id"
    t.integer  "postal_code_id"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  add_index "transporter_postal_codes", ["postal_code_id"], name: "index_transporter_postal_codes_on_postal_code_id", using: :btree
  add_index "transporter_postal_codes", ["transporter_id"], name: "index_transporter_postal_codes_on_transporter_id", using: :btree

  create_table "transporters", force: :cascade do |t|
    t.string   "name"
    t.string   "siret"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "carriers", "transporters"
  add_foreign_key "locations", "carriers"
  add_foreign_key "transporter_postal_codes", "postal_codes"
  add_foreign_key "transporter_postal_codes", "transporters"
end
