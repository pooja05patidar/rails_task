# frozen_string_literal: true

if @order_item.errors.empty?
  json.code 200
  json.message 'Order updated successfully'
else
  json.code 422
  json.message 'Order updation failed'
end
json.data do
  json.id @order_item.id
  json.user_id @order_item.user_id
end
