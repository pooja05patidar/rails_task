# frozen_string_literal: true

# menu controller
class MenuItemsController < ApplicationController
  before_action :authenticate_user!
  before_action :pagination
  before_action :set_menu, only: %i[show update destroy]
  # load_and_authorize_resource

  def index
    @restaurant = Restaurant.find(params[:restaurant_id])
    @menu_items = @restaurant.menu_items
    # @menu_items = MenuItem.all
    # if params[:category].present?
    #   MenuItem.where(category: params[:category])
    # else
    #   @menu_items = MenuItem.all
    # end
    # render json: @menu_items
  end

  def pagination
    MenuItem.page params[:page]
  end

  def filter_menu
    search_query = params[:search_query]
    @filtered_menus = MenuItem.filter_by_query(search_query)
    render json: { status: { code: 200, message: 'Success' }, data: @filtered_menus }
  end

  def show; end

  def create
    res = Restaurant.find(menu_item_params[:restaurant_id])
    item = res.menu_items.create(menu_item_params)

    if item.save
      render json: { status: { code: 200 }, menu: item }
    else
      render json: { status: { code: 422, errors: item.errors.full_messages } }
    end
  end

  def update
    res = Restaurant.find(@id)
    item = res.menu_items.update
    if item.save
      render json: { status: { code: 200 }, data: item }
    else
      render json: { status: { code: 422, errors: item.errors.full_messages } }
    end
  end

  def destroy
    @menu.destroy
  end

  private

  def set_menu
    @menu = MenuItem.find(params[:id])
  end

  def menu_item_params
    params.require(:menu_item).permit(:name, :description, :price, :restaurant_id, :category)
  end
end
