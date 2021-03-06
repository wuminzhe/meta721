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

ActiveRecord::Schema.define(version: 2021_12_21_034550) do

  create_table "token_contracts", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", force: :cascade do |t|
    t.string "address"
    t.text "name"
    t.text "symbol"
    t.boolean "metadata"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "blacklisted"
    t.index ["address"], name: "index_token_contracts_on_address", unique: true
  end

  create_table "token_contracts_infos", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", force: :cascade do |t|
    t.string "key"
    t.string "value"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["key"], name: "index_token_contracts_infos_on_key", unique: true
  end

  create_table "tokens", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", force: :cascade do |t|
    t.text "token_uri", limit: 16777215
    t.integer "mint_time"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "token_contract_address"
    t.string "token_id"
    t.index ["token_contract_address", "token_id"], name: "index_tokens_on_token_contract_address_and_token_id", unique: true
  end

  create_table "tokens_infos", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", force: :cascade do |t|
    t.string "key"
    t.string "value"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["key"], name: "index_tokens_infos_on_key", unique: true
  end

end
