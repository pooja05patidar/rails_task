# module AddToCart
#   extend ActiveSupport::Concern

#   def add_to_cart_action
#     menu_id = params.require(:order_item).permit(:menu_id)[:menu_id]
#     quantity = params.require(:order_item).permit(:quantity)[:quantity]
#     menu = Menu.find(menu_id)
#     total_price = menu.price * quantity.to_i

#     cart_item = current_user.cart_items.find_or_initialize_by(menu: menu)
#     cart_item.quantity ||= 0
#     cart_item.quantity += quantity.to_i
#     cart_item.save!

#     render json: {
#       status: { code: 200, message: 'Added to cart successfully' },
#       data: {
#         cart_item: cart_item,
#         total_price: total_price,
#         menu: {
#           id: menu.id,
#           name: menu.name,
#           description: menu.description,
#           price: menu.price
#         }
#       }
#     }
#   end
# end


# module AddToCart
#   extend ActiveSupport::Concern

#   def add_to_cart_action
#     menu_id = params.require(:order_item).permit(:menu_id)[:menu_id]
#     quantity = params.require(:order_item).permit(:quantity)[:quantity]
#     menu = Menu.find(menu_id)
#     total_price = menu.price * quantity.to_i

#     cart_item = current_user.cart_items.find_or_initialize_by(menu: menu)
#     cart_item.quantity ||= 0
#     cart_item.quantity += quantity.to_i
#     cart_item.save!

#     update_cart_totals

#     render json: {
#       status: { code: 200, message: 'Added to cart successfully' },
#       data: {
#         cart_item: cart_item,
#         total_price: total_price, # Use the total_price calculated above
#         menu: {
#           id: menu.id,
#           name: menu.name,
#           description: menu.description,
#           price: menu.price
#         }
#       }
#     }
#   end

#   private

#   def update_cart_totals
#     current_user.cart_items.reload
#     total_items = current_user.cart_items.count
#     total_price = current_user.cart_items.sum { |item| item.menu.price * item.quantity.to_i }

#     current_user.update!(cart_total_items: total_items, cart_total_price: total_price)
#   end
# end
