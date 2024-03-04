# frozen_string_literal: true

json.data @restaurants do |rest|
  json.id rest.id
  json.name rest.name
  json.description rest.description
end
