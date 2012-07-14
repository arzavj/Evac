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

ActiveRecord::Schema.define(:version => 20120713034719) do

  create_table "delayed_jobs", :force => true do |t|
    t.integer  "priority",   :default => 0
    t.integer  "attempts",   :default => 0
    t.text     "handler"
    t.text     "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string   "locked_by"
    t.string   "queue"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "delayed_jobs", ["priority", "run_at"], :name => "delayed_jobs_priority"

  create_table "profiles", :force => true do |t|
    t.string   "file_name"
    t.string   "file_type"
    t.integer  "size"
    t.binary   "data"
    t.text     "blurb"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "School"
  end

  create_table "questions", :force => true do |t|
    t.integer  "ask_id"
    t.text     "question",                                                       :null => false
    t.string   "tag",                           :limit => 50
    t.integer  "category"
    t.integer  "rank",                          :limit => 8
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "in_session",                                  :default => true
    t.integer  "answer_id"
    t.integer  "schedule_id",                                 :default => -1
    t.text     "notes"
    t.boolean  "was_answered",                                :default => false
    t.text     "answerer_notes"
    t.integer  "ask_rank",                      :limit => 8
    t.string   "current_session"
    t.boolean  "delete_past_question_ask",                    :default => false
    t.boolean  "delete_past_question_answerer",               :default => false
    t.boolean  "deleted",                                     :default => false
    t.boolean  "reposted",                                    :default => false
    t.datetime "first_entry"
    t.boolean  "ask_missed",                                  :default => false
    t.boolean  "answer_missed",                               :default => false
  end

  add_index "questions", ["ask_id"], :name => "index_questions_on_user_id"

  create_table "schedules", :force => true do |t|
    t.datetime "appointment", :null => false
    t.integer  "question_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
  end

  add_index "schedules", ["question_id"], :name => "index_schedules_on_question_id"
  add_index "schedules", ["user_id"], :name => "index_schedules_on_user_id"

  create_table "users", :force => true do |t|
    t.string   "email"
    t.string   "password"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.float    "rating",                  :default => 0.0
    t.integer  "profile_id"
    t.integer  "completed_conversations", :default => 0
    t.string   "verify"
    t.string   "firstName",               :default => ""
    t.string   "lastName",                :default => ""
    t.integer  "age",                     :default => 0
    t.integer  "new_questions",           :default => 0
    t.integer  "missed_conversations",    :default => 0
  end

  add_index "users", ["profile_id"], :name => "index_users_on_profile_id"

end
