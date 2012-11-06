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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20121104173021) do

  create_table "games", :force => true do |t|
    t.string   "name"
    t.integer  "turn"
    t.integer  "allied_power"
    t.integer  "german_morale"
    t.integer  "allied_morale"
    t.integer  "inflation"
    t.integer  "contracts_available"
    t.integer  "contracts_left"
    t.boolean  "complete"
    t.datetime "created_at",          :null => false
    t.datetime "updated_at",          :null => false
    t.integer  "creator"
  end

  create_table "games_players", :force => true do |t|
    t.integer "game_id"
    t.integer "user_id"
    t.string  "side_name"
    t.integer "score"
    t.integer "bank"
    t.integer "power"
    t.integer "factories"
    t.boolean "winner"
    t.string  "order1"
    t.string  "order2"
  end

  create_table "games_players_orders", :force => true do |t|
    t.integer  "games_player_id"
    t.integer  "turn"
    t.string   "order1"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
    t.string   "order2"
  end

  create_table "games_war_status_draws", :id => false, :force => true do |t|
    t.integer "game_id"
    t.integer "war_status_card_id"
  end

  create_table "journal_items", :force => true do |t|
    t.integer  "game_id"
    t.string   "item_type"
    t.string   "arg1"
    t.string   "arg2"
    t.string   "arg3"
    t.string   "arg4"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.integer  "turn"
  end

  create_table "users", :force => true do |t|
    t.string   "email",                  :default => "", :null => false
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

  create_table "war_status_cards", :force => true do |t|
    t.string  "title"
    t.boolean "do_inflation"
    t.integer "allied_morale_loss"
    t.integer "german_morale_loss"
    t.integer "new_contracts"
    t.boolean "do_reshuffle"
    t.boolean "upgraded_allied_ac"
    t.boolean "new_allied_ac"
    t.boolean "allied_technology_leap"
    t.integer "card_num"
  end

end
