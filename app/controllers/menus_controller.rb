class MenusController < ApplicationController
  before_action :authenticate_user!
  # load_and_authorize_resource

  def index
    @menus = Menu.all
    render json: { status: { code: 200, message: 'Success' }, data: @menus }
  end

  def show
    @menu = Menu.find(params[:id])
    render json: { status: { code: 200, message: 'Success' }, data: @menu }
  end

  def create
    # debugger
    @id = params.require(:menu)[:restaurant_id]
    @res = Restaurant.find(@id)
    @menu = @res.build_menu

    if @menu.save
      render json: { status: { code: 200, message: 'Menu created successfully' }, data: @menu }, status: 422
    else
      render json: { status: { code: 422, message: 'Menu creation failed', errors: @menu.errors.full_messages } }
    end
  end

  def update
    @menu = Menu.find(params[:id])

    if @menu.update(menu_params)
      render json: { status: { code: 200, message: 'Menu updated successfully' }, data: @menu }
    else
      render json: { status: { code: 422, message: 'Menu update failed', errors: @menu.errors.full_messages } }
    end
  end

  def destroy
    @menu = Menu.find(params[:id])
    @menu.destroy
    render json: { status: { code: 200, message: 'Menu deleted successfully' } }
  end

  private

  def menu_params
    params.require(:menu).permit(:name, :description, :price, :restaurant_id)
  end
end
