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

ActiveRecord::Schema[7.0].define(version: 20_230_623_180_851) do
  # These are extensions that must be enabled in order to support this database
  enable_extension 'plpgsql'

  create_table 'groups', force: :cascade do |t|
    t.string 'name'
    t.text 'description'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
  end

  create_table 'members', force: :cascade do |t|
    t.string 'name'
    t.string 'handle'
    t.string 'member_id'
    t.bigint 'group_id', null: false
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['group_id'], name: 'index_members_on_group_id'
  end

  create_table 'teams', force: :cascade do |t|
    t.string 'team_id'
    t.string 'name'
    t.string 'domain'
    t.string 'token'
    t.string 'oauth_scope'
    t.string 'oauth_version', default: 'v1', null: false
    t.string 'bot_user_id'
    t.string 'activated_user_id'
    t.string 'activated_user_access_token'
    t.boolean 'active', default: true
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
  end

  add_foreign_key 'members', 'groups'
end
