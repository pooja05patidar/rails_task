json.data @restaurants do |rest|
  json.id rest.id
  json.name rest.name
  json.description rest.description
end

  # t.decimal "ratings"
  # t.integer "user_id", null: false
  # t.datetime "created_at", null: false
  # # t.datetime "updated_at", null: false
  # t.index ["user_id"], name
