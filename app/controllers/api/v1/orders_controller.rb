# frozen_string_literal: true

class Api::V1::OrdersController < Api::V1::ApplicationController
  before_action :set_order, except: %i[create]

  def create
    @order = Order.new(order_params)
    if @order.save
      render json: @order, serializer: Api::V1::OrderSerializer, status: :created
    else
      render json: @order.errors, status: :unprocessable_entity
    end
  end

  def update
    if @order.update(order_params)
      render json: @order, serializer: Api::V1::OrderSerializer, status: :ok
    else
      render json: @order.errors, status: :unprocessable_entity
    end
  end

  def ship
    change_status('ORDER_SHIPPED')
  end

  def cancel
    change_status('ORDER_CANCELLED')
  end

  private

  def set_order
    @order = Order.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    render json: { message: 'Order not found' }, status: :not_found
  end

  def order_params
    params.require(:order).permit(:school_id, recipient_ids: [], gifts_ids: [])
  end

  def change_status(status)
    @order.send("#{status}!")
    render json: @order, serializer: Api::V1::OrderSerializer, status: :ok
  rescue StandardError
    render json: @order.errors, status: :unprocessable_entity
  end
end
