# app/controllers/deliveries_controller.rb
class DeliveriesController < ApplicationController
  before_action :authenticate_user!
  # load_and_authorize_resource

  def index
    @deliveries = Delivery.all
    render json: { status: { code: 200, message: 'Success' }, data: @deliveries }
  end

  def show
    @delivery = Delivery.find(params[:id])
    render json: { status: { code: 200, message: 'Success' }, data: @delivery }
  end

  def create
    @delivery = Delivery.new(delivery_params)

    if @delivery.save
      render json: { status: { code: 200, message: 'Delivery created successfully' }, data: @delivery }
    else
      render json: { status: { code: 422, message: 'Delivery creation failed', errors: @delivery.errors.full_messages } }
    end
  end

  def update
    @delivery = Delivery.find(params[:id])

    if @delivery.update(delivery_params)
      render json: { status: { code: 200, message: 'Delivery updated successfully' }, data: @delivery }
    else
      render json: { status: { code: 422, message: 'Delivery update failed', errors: @delivery.errors.full_messages } }
    end
  end

  def destroy
    @delivery = Delivery.find(params[:id])
    @delivery.destroy
    render json: { status: { code: 200, message: 'Delivery deleted successfully' } }
  end

  private

  def delivery_params
    params.require(:delivery).permit(:order_id, :delivery_person_id, :status, :delivery_time)
  end
end
