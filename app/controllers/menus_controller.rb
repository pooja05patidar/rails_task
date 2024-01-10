class MenusController < ApplicationController
  before_action :authenticate_user!
  before_action :set_menu, only: [:show, :update, :destroy]
  load_and_authorize_resource

  def index
    @menus = Menu.all
    # render json: { status: { code: 200, message: 'Success' }, data: @menus }
  end

  def filter_menu
    search_query = params[:search_query]
    @filtered_menus = Menu.filter_by_query(search_query)
    render json: { status: { code: 200, message: 'Success' }, data: @filtered_menus }
  end

  def show
    render json: { status: { code: 200, message: 'Success' }, data: @menu }
  end

  def create
    # debugger
    @id = params.require(:menu)[:restaurant_id]
    @res = Restaurant.find(@id)
    @item = @res.menus.create

    if @item.save
      render json: { status: { code: 200, message: 'Menu created successfully' }, data: @menu }, status: 422
    else
      render json: { status: { code: 422, message: 'Menu creation failed', errors: @menu.errors.full_messages } }
    end
  end

  def update
    if @menu.update(menu_params)
      render json: { status: { code: 200, message: 'Menu updated successfully' }, data: @menu }
    else
      render json: { status: { code: 422, message: 'Menu update failed', errors: @menu.errors.full_messages } }
    end
  end

  def destroy
    @menu.destroy
    # render json: { status: { code: 200, message: 'Menu deleted successfully' } }
  end

  private

  def set_menu
    @menu = Menu.find(params[:id])
  end

  def menu_params
    params.require(:menu).permit(:name, :description, :price, :restaurant_id)
  end
end
