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

ActiveRecord::Schema[7.0].define(version: 2023_07_08_120748) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "account_invitations", force: :cascade do |t|
    t.bigint "account_id", null: false
    t.bigint "invited_by_id"
    t.string "token", null: false
    t.string "name", null: false
    t.string "email", null: false
    t.jsonb "roles", default: {}, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["account_id"], name: "index_account_invitations_on_account_id"
    t.index ["invited_by_id"], name: "index_account_invitations_on_invited_by_id"
    t.index ["token"], name: "index_account_invitations_on_token", unique: true
  end

  create_table "account_users", force: :cascade do |t|
    t.bigint "account_id"
    t.bigint "user_id"
    t.jsonb "roles", default: {}, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["account_id"], name: "index_account_users_on_account_id"
    t.index ["user_id"], name: "index_account_users_on_user_id"
  end

  create_table "accounts", force: :cascade do |t|
    t.string "name", null: false
    t.bigint "owner_id"
    t.boolean "personal", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "extra_billing_info"
    t.string "domain"
    t.string "subdomain"
    t.index ["owner_id"], name: "index_accounts_on_owner_id"
  end

  create_table "action_text_embeds", force: :cascade do |t|
    t.string "url"
    t.jsonb "fields"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "action_text_rich_texts", force: :cascade do |t|
    t.string "name", null: false
    t.text "body"
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["record_type", "record_id", "name"], name: "index_action_text_rich_texts_uniqueness", unique: true
  end

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.bigint "byte_size", null: false
    t.string "checksum", null: false
    t.datetime "created_at", null: false
    t.string "service_name", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "announcements", force: :cascade do |t|
    t.string "kind"
    t.string "title"
    t.datetime "published_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "api_tokens", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "token"
    t.string "name"
    t.jsonb "metadata", default: {}
    t.boolean "transient", default: false
    t.datetime "last_used_at"
    t.datetime "expires_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["token"], name: "index_api_tokens_on_token", unique: true
    t.index ["user_id"], name: "index_api_tokens_on_user_id"
  end

  create_table "autopay_schedules", force: :cascade do |t|
    t.date "date"
    t.decimal "charge", precision: 8, scale: 2
    t.integer "mindbody_contract_id"
    t.bigint "client_contract_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["client_contract_id"], name: "index_autopay_schedules_on_client_contract_id"
  end

  create_table "client_contracts", force: :cascade do |t|
    t.bigint "client_id", null: false
    t.string "name"
    t.string "autopay_status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "mindbody_contract_id"
    t.date "start_date"
    t.date "end_date"
    t.integer "mindbody_client_contract_id"
    t.integer "account_id"
    t.index ["client_id"], name: "index_client_contracts_on_client_id"
  end

  create_table "clients", force: :cascade do |t|
    t.string "mindbody_id"
    t.string "first_name"
    t.string "last_name"
    t.string "email"
    t.string "photo"
    t.string "gender"
    t.date "date_of_birth"
    t.boolean "member"
    t.datetime "mindbody_profile_created"
    t.datetime "mindbody_profile_updated"
    t.integer "account_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "status"
  end

  create_table "fitness_class_bookings", id: false, force: :cascade do |t|
    t.bigint "fitness_class_schedule_id", null: false
    t.bigint "client_id", null: false
    t.integer "account_id"
  end

  create_table "fitness_class_schedules", force: :cascade do |t|
    t.bigint "fitness_class_id", null: false
    t.date "start_date"
    t.time "start_time"
    t.time "end_time"
    t.integer "capacity"
    t.integer "book_online_capacity"
    t.integer "waitlist_capacity"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "mindbody_class_schedule_id"
    t.integer "mindbody_id"
    t.integer "account_id"
    t.index ["fitness_class_id"], name: "index_fitness_class_schedules_on_fitness_class_id"
  end

  create_table "fitness_classes", force: :cascade do |t|
    t.string "name"
    t.string "category"
    t.string "class_type"
    t.string "level"
    t.string "image"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "mindbody_id"
    t.text "description"
    t.integer "account_id"
  end

  create_table "mindbody_account_details", force: :cascade do |t|
    t.integer "mindbody_site_id"
    t.string "mindbody_admin_user"
    t.string "mindbody_admin_password"
    t.bigint "account_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "completed", default: false
    t.index ["account_id"], name: "index_mindbody_account_details_on_account_id"
  end

  create_table "notification_tokens", force: :cascade do |t|
    t.bigint "user_id"
    t.string "token", null: false
    t.string "platform", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_notification_tokens_on_user_id"
  end

  create_table "notifications", force: :cascade do |t|
    t.bigint "account_id", null: false
    t.string "recipient_type", null: false
    t.bigint "recipient_id", null: false
    t.string "type"
    t.jsonb "params"
    t.datetime "read_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "interacted_at"
    t.index ["account_id"], name: "index_notifications_on_account_id"
    t.index ["recipient_type", "recipient_id"], name: "index_notifications_on_recipient_type_and_recipient_id"
  end

  create_table "pay_charges", force: :cascade do |t|
    t.string "processor_id", null: false
    t.integer "amount", null: false
    t.integer "amount_refunded"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.jsonb "data"
    t.integer "application_fee_amount"
    t.string "currency"
    t.jsonb "metadata"
    t.integer "subscription_id"
    t.bigint "customer_id"
    t.index ["customer_id", "processor_id"], name: "index_pay_charges_on_customer_id_and_processor_id", unique: true
  end

  create_table "pay_customers", force: :cascade do |t|
    t.string "owner_type"
    t.bigint "owner_id"
    t.string "processor"
    t.string "processor_id"
    t.boolean "default"
    t.jsonb "data"
    t.datetime "deleted_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["owner_type", "owner_id", "deleted_at"], name: "customer_owner_processor_index"
    t.index ["processor", "processor_id"], name: "index_pay_customers_on_processor_and_processor_id"
  end

  create_table "pay_merchants", force: :cascade do |t|
    t.string "owner_type"
    t.bigint "owner_id"
    t.string "processor"
    t.string "processor_id"
    t.boolean "default"
    t.jsonb "data"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["owner_type", "owner_id", "processor"], name: "index_pay_merchants_on_owner_type_and_owner_id_and_processor"
  end

  create_table "pay_payment_methods", force: :cascade do |t|
    t.bigint "customer_id"
    t.string "processor_id"
    t.boolean "default"
    t.string "type"
    t.jsonb "data"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["customer_id", "processor_id"], name: "index_pay_payment_methods_on_customer_id_and_processor_id", unique: true
  end

  create_table "pay_subscriptions", id: :serial, force: :cascade do |t|
    t.string "name", null: false
    t.string "processor_id", null: false
    t.string "processor_plan", null: false
    t.integer "quantity", default: 1, null: false
    t.datetime "trial_ends_at"
    t.datetime "ends_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string "status"
    t.jsonb "data"
    t.decimal "application_fee_percent", precision: 8, scale: 2
    t.jsonb "metadata"
    t.bigint "customer_id"
    t.index ["customer_id", "processor_id"], name: "index_pay_subscriptions_on_customer_id_and_processor_id", unique: true
  end

  create_table "pay_webhooks", force: :cascade do |t|
    t.string "processor"
    t.string "event_type"
    t.jsonb "event"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "plans", force: :cascade do |t|
    t.string "name", null: false
    t.integer "amount", default: 0, null: false
    t.string "interval", null: false
    t.jsonb "details", default: {}, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "trial_period_days", default: 0
    t.boolean "hidden"
    t.string "currency"
    t.integer "interval_count", default: 1
    t.string "description"
  end

  create_table "purchased_items", force: :cascade do |t|
    t.bigint "sale_id", null: false
    t.integer "mindbody_purchased_item_id"
    t.boolean "is_service"
    t.string "description"
    t.string "contract_id"
    t.integer "quantity"
    t.decimal "unti_price", precision: 8, scale: 2
    t.decimal "tax", precision: 8, scale: 2
    t.decimal "amount", precision: 8, scale: 2
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["sale_id"], name: "index_purchased_items_on_sale_id"
  end

  create_table "sales", force: :cascade do |t|
    t.bigint "client_id", null: false
    t.integer "mindbody_sale_id"
    t.string "mindbody_client_id"
    t.datetime "date"
    t.decimal "price", precision: 8, scale: 2
    t.decimal "tax", precision: 8, scale: 2
    t.decimal "total_amount", precision: 8, scale: 2
    t.string "description"
    t.string "payment_type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["client_id"], name: "index_sales_on_client_id"
  end

  create_table "sidekiq_sequence_records", force: :cascade do |t|
    t.jsonb "data"
    t.integer "current_step", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "user_connected_accounts", force: :cascade do |t|
    t.bigint "user_id"
    t.string "provider"
    t.string "uid"
    t.string "refresh_token"
    t.datetime "expires_at"
    t.text "auth"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "access_token"
    t.string "access_token_secret"
    t.index ["user_id"], name: "index_user_connected_accounts_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.string "first_name"
    t.string "last_name"
    t.string "time_zone"
    t.datetime "accepted_terms_at"
    t.datetime "accepted_privacy_at"
    t.datetime "announcements_read_at"
    t.boolean "admin"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "invitation_token"
    t.datetime "invitation_created_at"
    t.datetime "invitation_sent_at"
    t.datetime "invitation_accepted_at"
    t.integer "invitation_limit"
    t.string "invited_by_type"
    t.bigint "invited_by_id"
    t.integer "invitations_count", default: 0
    t.string "preferred_language"
    t.boolean "otp_required_for_login"
    t.string "otp_secret"
    t.integer "last_otp_timestep"
    t.text "otp_backup_codes"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["invitation_token"], name: "index_users_on_invitation_token", unique: true
    t.index ["invitations_count"], name: "index_users_on_invitations_count"
    t.index ["invited_by_id"], name: "index_users_on_invited_by_id"
    t.index ["invited_by_type", "invited_by_id"], name: "index_users_on_invited_by"
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "account_invitations", "accounts"
  add_foreign_key "account_invitations", "users", column: "invited_by_id"
  add_foreign_key "account_users", "accounts"
  add_foreign_key "account_users", "users"
  add_foreign_key "accounts", "users", column: "owner_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "api_tokens", "users"
  add_foreign_key "autopay_schedules", "client_contracts"
  add_foreign_key "client_contracts", "clients"
  add_foreign_key "fitness_class_schedules", "fitness_classes"
  add_foreign_key "mindbody_account_details", "accounts"
  add_foreign_key "pay_charges", "pay_customers", column: "customer_id"
  add_foreign_key "pay_payment_methods", "pay_customers", column: "customer_id"
  add_foreign_key "pay_subscriptions", "pay_customers", column: "customer_id"
  add_foreign_key "purchased_items", "sales"
  add_foreign_key "sales", "clients"
  add_foreign_key "user_connected_accounts", "users"

  create_view "views_client_contract_lengths", sql_definition: <<-SQL
      SELECT sub3.client_id,
      sub3.contract_nr,
      max(sub3.sum_days) AS client_contract_length
     FROM ( SELECT sub2.client_id,
              sub2.start_date,
              sub2.end_date,
              sub2.continous_contract,
              sub2.contract_days,
              sub2.contract_nr,
              sum(sub2.contract_days) OVER (PARTITION BY sub2.client_id, sub2.contract_nr ORDER BY sub2.end_date) AS sum_days
             FROM ( SELECT sub1.client_id,
                      sub1.start_date,
                      sub1.end_date,
                      sub1.continous_contract,
                      sub1.contract_days,
                      count(*) FILTER (WHERE (NOT sub1.continous_contract)) OVER (PARTITION BY sub1.client_id ORDER BY sub1.end_date) AS contract_nr
                     FROM ( SELECT client_contracts.client_id,
                              client_contracts.start_date,
                              client_contracts.end_date,
                              (client_contracts.start_date <= (lag(client_contracts.end_date, 1, client_contracts.end_date) OVER (PARTITION BY client_contracts.client_id ORDER BY client_contracts.end_date) + 1)) AS continous_contract,
                              (client_contracts.end_date - client_contracts.start_date) AS contract_days
                             FROM client_contracts) sub1) sub2) sub3
    GROUP BY sub3.client_id, sub3.contract_nr
    ORDER BY sub3.client_id;
  SQL
end
