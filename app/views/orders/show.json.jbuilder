# frozen_string_literal: true

json.data @order do |order|
  json.id order.id
  json.user_id order.user_id
end
