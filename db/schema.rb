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

ActiveRecord::Schema.define(:version => 20120910031014) do

  create_table "conversations", :force => true do |t|
    t.string   "subject",    :default => ""
    t.datetime "created_at",                 :null => false
    t.datetime "updated_at",                 :null => false
  end

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

  create_table "notifications", :force => true do |t|
    t.string   "type"
    t.text     "body"
    t.string   "subject",              :default => ""
    t.integer  "sender_id"
    t.string   "sender_type"
    t.integer  "conversation_id"
    t.boolean  "draft",                :default => false
    t.datetime "updated_at",                              :null => false
    t.datetime "created_at",                              :null => false
    t.integer  "notified_object_id"
    t.string   "notified_object_type"
    t.string   "notification_code"
    t.string   "attachment"
  end

  add_index "notifications", ["conversation_id"], :name => "index_notifications_on_conversation_id"

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

  create_table "receipts", :force => true do |t|
    t.integer  "receiver_id"
    t.string   "receiver_type"
    t.integer  "notification_id",                                  :null => false
    t.boolean  "is_read",                       :default => false
    t.boolean  "trashed",                       :default => false
    t.boolean  "deleted",                       :default => false
    t.string   "mailbox_type",    :limit => 25
    t.datetime "created_at",                                       :null => false
    t.datetime "updated_at",                                       :null => false
  end

  add_index "receipts", ["notification_id"], :name => "index_receipts_on_notification_id"

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
    t.datetime "created_at"
    t.datetime "updated_at"
    t.float    "rating",                  :default => 0.0
    t.integer  "completed_conversations", :default => 0
    t.string   "firstName",               :default => ""
    t.string   "lastName",                :default => ""
    t.integer  "age",                     :default => 0
    t.integer  "new_questions",           :default => 0
    t.integer  "missed_conversations",    :default => 0
    t.string   "encrypted_password",      :default => "",  :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",           :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.string   "provider"
    t.string   "uid"
    t.integer  "points",                  :default => 100
    t.text     "blurb"
    t.string   "school",                  :default => ""
    t.string   "picture_file_name"
    t.string   "picture_content_type"
    t.datetime "picture_updated_at"
    t.integer  "picture_file_size"
    t.string   "location"
    t.string   "prefered_schedule"
    t.string   "short_bio"
  end

  add_index "users", ["confirmation_token"], :name => "index_users_on_confirmation_token", :unique => true
  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

  add_foreign_key "notifications", "conversations", :name => "notifications_on_conversation_id"

  add_foreign_key "receipts", "notifications", :name => "receipts_on_notification_id"

end
