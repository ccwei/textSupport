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

ActiveRecord::Schema.define(:version => 20130218021828) do

  create_table "irc_custom", :id => false, :force => true do |t|
    t.text      "jid",        :null => false
    t.text      "host",       :null => false
    t.text      "data",       :null => false
    t.timestamp "created_at", :null => false
  end

  add_index "irc_custom", ["jid", "host"], :name => "i_irc_custom_jid_host", :unique => true, :length => {"jid"=>75, "host"=>75}

  create_table "last", :primary_key => "username", :force => true do |t|
    t.text "seconds", :null => false
    t.text "state",   :null => false
  end

  create_table "members", :force => true do |t|
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

  add_index "members", ["email"], :name => "index_members_on_email", :unique => true
  add_index "members", ["reset_password_token"], :name => "index_members_on_reset_password_token", :unique => true

  create_table "motd", :primary_key => "username", :force => true do |t|
    t.text      "xml"
    t.timestamp "created_at", :null => false
  end

  create_table "muc_registered", :id => false, :force => true do |t|
    t.text      "jid",        :null => false
    t.text      "host",       :null => false
    t.text      "nick",       :null => false
    t.timestamp "created_at", :null => false
  end

  add_index "muc_registered", ["jid", "host"], :name => "i_muc_registered_jid_host", :unique => true, :length => {"jid"=>75, "host"=>75}
  add_index "muc_registered", ["nick"], :name => "i_muc_registered_nick", :length => {"nick"=>75}

  create_table "muc_room", :id => false, :force => true do |t|
    t.text      "name",       :null => false
    t.text      "host",       :null => false
    t.text      "opts",       :null => false
    t.timestamp "created_at", :null => false
  end

  add_index "muc_room", ["name", "host"], :name => "i_muc_room_name_host", :unique => true, :length => {"name"=>75, "host"=>75}

  create_table "privacy_default_list", :primary_key => "username", :force => true do |t|
    t.string "name", :limit => 250, :null => false
  end

  create_table "privacy_list", :id => false, :force => true do |t|
    t.string    "username",   :limit => 250, :null => false
    t.string    "name",       :limit => 250, :null => false
    t.integer   "id",         :limit => 8,   :null => false
    t.timestamp "created_at",                :null => false
  end

  add_index "privacy_list", ["id"], :name => "id", :unique => true
  add_index "privacy_list", ["username", "name"], :name => "i_privacy_list_username_name", :unique => true, :length => {"username"=>75, "name"=>75}
  add_index "privacy_list", ["username"], :name => "i_privacy_list_username"

  create_table "privacy_list_data", :id => false, :force => true do |t|
    t.integer "id",                 :limit => 8
    t.string  "t",                  :limit => 1,                                :null => false
    t.text    "value",                                                          :null => false
    t.string  "action",             :limit => 1,                                :null => false
    t.decimal "ord",                             :precision => 10, :scale => 0, :null => false
    t.boolean "match_all",                                                      :null => false
    t.boolean "match_iq",                                                       :null => false
    t.boolean "match_message",                                                  :null => false
    t.boolean "match_presence_in",                                              :null => false
    t.boolean "match_presence_out",                                             :null => false
  end

  create_table "private_storage", :id => false, :force => true do |t|
    t.string    "username",   :limit => 250, :null => false
    t.string    "namespace",  :limit => 250, :null => false
    t.text      "data",                      :null => false
    t.timestamp "created_at",                :null => false
  end

  add_index "private_storage", ["username", "namespace"], :name => "i_private_storage_username_namespace", :unique => true, :length => {"username"=>75, "namespace"=>75}
  add_index "private_storage", ["username"], :name => "i_private_storage_username"

  create_table "pubsub_item", :id => false, :force => true do |t|
    t.integer "nodeid",       :limit => 8
    t.text    "itemid"
    t.text    "publisher"
    t.text    "creation"
    t.text    "modification"
    t.text    "payload"
  end

  add_index "pubsub_item", ["itemid"], :name => "i_pubsub_item_itemid", :length => {"itemid"=>36}
  add_index "pubsub_item", ["nodeid", "itemid"], :name => "i_pubsub_item_tuple", :unique => true, :length => {"nodeid"=>nil, "itemid"=>36}

  create_table "pubsub_node", :primary_key => "nodeid", :force => true do |t|
    t.text "host"
    t.text "node"
    t.text "parent"
    t.text "type"
  end

  add_index "pubsub_node", ["host", "node"], :name => "i_pubsub_node_tuple", :unique => true, :length => {"host"=>20, "node"=>120}
  add_index "pubsub_node", ["parent"], :name => "i_pubsub_node_parent", :length => {"parent"=>120}

  create_table "pubsub_node_option", :id => false, :force => true do |t|
    t.integer "nodeid", :limit => 8
    t.text    "name"
    t.text    "val"
  end

  add_index "pubsub_node_option", ["nodeid"], :name => "i_pubsub_node_option_nodeid"

  create_table "pubsub_node_owner", :id => false, :force => true do |t|
    t.integer "nodeid", :limit => 8
    t.text    "owner"
  end

  add_index "pubsub_node_owner", ["nodeid"], :name => "i_pubsub_node_owner_nodeid"

  create_table "pubsub_state", :primary_key => "stateid", :force => true do |t|
    t.integer "nodeid",        :limit => 8
    t.text    "jid"
    t.string  "affiliation",   :limit => 1
    t.text    "subscriptions"
  end

  add_index "pubsub_state", ["jid"], :name => "i_pubsub_state_jid", :length => {"jid"=>60}
  add_index "pubsub_state", ["nodeid", "jid"], :name => "i_pubsub_state_tuple", :unique => true, :length => {"nodeid"=>nil, "jid"=>60}

  create_table "pubsub_subscription_opt", :id => false, :force => true do |t|
    t.text   "subid"
    t.string "opt_name",  :limit => 32
    t.text   "opt_value"
  end

  add_index "pubsub_subscription_opt", ["subid", "opt_name"], :name => "i_pubsub_subscription_opt", :unique => true, :length => {"subid"=>32, "opt_name"=>nil}

  create_table "roster_version", :primary_key => "username", :force => true do |t|
    t.text "version", :null => false
  end

  create_table "rostergroups", :id => false, :force => true do |t|
    t.string "username", :limit => 250, :null => false
    t.string "jid",      :limit => 250, :null => false
    t.text   "grp",                     :null => false
  end

  add_index "rostergroups", ["username", "jid"], :name => "pk_rosterg_user_jid", :length => {"username"=>75, "jid"=>75}

  create_table "rosterusers", :id => false, :force => true do |t|
    t.string    "username",     :limit => 250, :null => false
    t.string    "jid",          :limit => 250, :null => false
    t.text      "nick",                        :null => false
    t.string    "subscription", :limit => 1,   :null => false
    t.string    "ask",          :limit => 1,   :null => false
    t.text      "askmessage",                  :null => false
    t.string    "server",       :limit => 1,   :null => false
    t.text      "subscribe",                   :null => false
    t.text      "type"
    t.timestamp "created_at",                  :null => false
  end

  add_index "rosterusers", ["jid"], :name => "i_rosteru_jid"
  add_index "rosterusers", ["username", "jid"], :name => "i_rosteru_user_jid", :unique => true, :length => {"username"=>75, "jid"=>75}
  add_index "rosterusers", ["username"], :name => "i_rosteru_username"

  create_table "spool", :id => false, :force => true do |t|
    t.string    "username",   :limit => 250, :null => false
    t.text      "xml",                       :null => false
    t.integer   "seq",        :limit => 8,   :null => false
    t.timestamp "created_at",                :null => false
  end

  add_index "spool", ["seq"], :name => "seq", :unique => true
  add_index "spool", ["username"], :name => "i_despool"

  create_table "sr_group", :id => false, :force => true do |t|
    t.string    "name",       :limit => 250, :null => false
    t.text      "opts",                      :null => false
    t.timestamp "created_at",                :null => false
  end

  create_table "sr_user", :id => false, :force => true do |t|
    t.string    "jid",        :limit => 250, :null => false
    t.string    "grp",        :limit => 250, :null => false
    t.timestamp "created_at",                :null => false
  end

  add_index "sr_user", ["grp"], :name => "i_sr_user_grp"
  add_index "sr_user", ["jid", "grp"], :name => "i_sr_user_jid_group", :unique => true, :length => {"jid"=>75, "grp"=>75}
  add_index "sr_user", ["jid"], :name => "i_sr_user_jid"

  create_table "users", :id => false, :force => true do |t|
    t.integer   "id"
    t.string    "username"
    t.string    "password"
    t.timestamp "created_at", :null => false
  end

  create_table "vcard", :primary_key => "username", :force => true do |t|
    t.text      "vcard",      :limit => 16777215, :null => false
    t.timestamp "created_at",                     :null => false
  end

  create_table "vcard_search", :primary_key => "lusername", :force => true do |t|
    t.string "username",  :limit => 250, :null => false
    t.text   "fn",                       :null => false
    t.string "lfn",       :limit => 250, :null => false
    t.text   "family",                   :null => false
    t.string "lfamily",   :limit => 250, :null => false
    t.text   "given",                    :null => false
    t.string "lgiven",    :limit => 250, :null => false
    t.text   "middle",                   :null => false
    t.string "lmiddle",   :limit => 250, :null => false
    t.text   "nickname",                 :null => false
    t.string "lnickname", :limit => 250, :null => false
    t.text   "bday",                     :null => false
    t.string "lbday",     :limit => 250, :null => false
    t.text   "ctry",                     :null => false
    t.string "lctry",     :limit => 250, :null => false
    t.text   "locality",                 :null => false
    t.string "llocality", :limit => 250, :null => false
    t.text   "email",                    :null => false
    t.string "lemail",    :limit => 250, :null => false
    t.text   "orgname",                  :null => false
    t.string "lorgname",  :limit => 250, :null => false
    t.text   "orgunit",                  :null => false
    t.string "lorgunit",  :limit => 250, :null => false
  end

  add_index "vcard_search", ["lbday"], :name => "i_vcard_search_lbday"
  add_index "vcard_search", ["lctry"], :name => "i_vcard_search_lctry"
  add_index "vcard_search", ["lemail"], :name => "i_vcard_search_lemail"
  add_index "vcard_search", ["lfamily"], :name => "i_vcard_search_lfamily"
  add_index "vcard_search", ["lfn"], :name => "i_vcard_search_lfn"
  add_index "vcard_search", ["lgiven"], :name => "i_vcard_search_lgiven"
  add_index "vcard_search", ["llocality"], :name => "i_vcard_search_llocality"
  add_index "vcard_search", ["lmiddle"], :name => "i_vcard_search_lmiddle"
  add_index "vcard_search", ["lnickname"], :name => "i_vcard_search_lnickname"
  add_index "vcard_search", ["lorgname"], :name => "i_vcard_search_lorgname"
  add_index "vcard_search", ["lorgunit"], :name => "i_vcard_search_lorgunit"

  create_table "vcard_xupdate", :primary_key => "username", :force => true do |t|
    t.text      "hash",       :null => false
    t.timestamp "created_at", :null => false
  end

end
