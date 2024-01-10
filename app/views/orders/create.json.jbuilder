json.status do
  if @order.persisted?
    json.code 200
    json.message 'Order placed successfully'
  else
    json.code 422
    json.message 'Placing order was unsuccessful'
    json.errors @order.errors.full_messages
  end

  json.data do
    # json.
  end
end
