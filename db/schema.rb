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

ActiveRecord::Schema.define(:version => 20130728020326) do

  create_table "pg_search_documents", :force => true do |t|
    t.text     "content"
    t.integer  "searchable_id"
    t.string   "searchable_type"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  create_table "photos", :force => true do |t|
    t.string   "name"
    t.integer  "user_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "schedules", :force => true do |t|
    t.boolean  "days"
    t.boolean  "nights"
    t.boolean  "weekends"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.integer  "user_id"
  end

  create_table "search_suggestions", :force => true do |t|
    t.string   "term"
    t.integer  "popularity"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "skills", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "skills_users", :id => false, :force => true do |t|
    t.integer "user_id"
    t.integer "skill_id"
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
    t.string   "postal_code"
    t.string   "name"
    t.string   "last_name"
    t.string   "first_name"
    t.string   "address_1"
    t.string   "address_2"
    t.string   "city"
    t.string   "state"
    t.string   "contact_phone"
    t.string   "cell_phone"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

  create_table "zip_codes", :force => true do |t|
    t.string   "ZipCode"
    t.string   "City"
    t.string   "State"
    t.string   "County"
    t.string   "AreaCode"
    t.string   "CityType"
    t.string   "CityAliasAbbreviation"
    t.string   "CityAliasName"
    t.string   "Latitude"
    t.string   "Longitude"
    t.string   "TimeZone"
    t.integer  "Elevation"
    t.string   "CountyFIPS"
    t.string   "DayLightSaving"
    t.string   "PreferredLastLineKey"
    t.string   "ClassificationCode"
    t.string   "MultiCounty"
    t.string   "StateFIPS"
    t.string   "CityStateKey"
    t.string   "CityAliasCode"
    t.string   "PrimaryRecord"
    t.string   "CityMixedCase"
    t.string   "CityAliasMixedCase"
    t.string   "StateANSI"
    t.string   "CountyANSI"
    t.string   "FacilityCode"
    t.string   "CityDeliveryIndicator"
    t.string   "CarrierRouteRateSortation"
    t.string   "FinanceNumber"
    t.string   "UniqueZIPName"
    t.datetime "created_at",                :null => false
    t.datetime "updated_at",                :null => false
  end

end
