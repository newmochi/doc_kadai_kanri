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

ActiveRecord::Schema.define(version: 20140902124008) do

  create_table "reqs", force: true do |t|
    t.integer  "user_id"
    t.integer  "rchap"
    t.integer  "rsec"
    t.integer  "rsubsec"
    t.integer  "rseqno"
    t.string   "rtitile"
    t.text     "rcontent"
    t.string   "rnote"
    t.text     "rnotedetail"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "reqs", ["user_id"], name: "index_reqs_on_user_id"

  create_table "solitems", force: true do |t|
    t.integer  "req_id"
    t.integer  "user_id"
    t.string   "sphase"
    t.string   "starget"
    t.string   "stitle"
    t.text     "scontent"
    t.integer  "slevel"
    t.text     "saction"
    t.string   "snote"
    t.text     "snotedetail"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.date     "sduedate"
  end

  add_index "solitems", ["req_id"], name: "index_solitems_on_req_id"
  add_index "solitems", ["user_id"], name: "index_solitems_on_user_id"

  create_table "users", force: true do |t|
    t.string   "uname"
    t.string   "upass"
    t.string   "uemail"
    t.string   "unote"
    t.text     "unotedetail"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
