# frozen_string_literal: true

module Addressable
  extend ActiveSupport::Concern
  included do
    before_action :set_address, only: [:address]

    def address
      if @address.update(address_params)
        render json: @object, serializer: "Api::V1::#{model_name}Serializer".constantize, status: :ok
      else
        render json: @address.errors, status: :unprocessable_entity
      end
    end
  end

  private

  def address_params
    params.require(:address).permit(:address, :city, :state, :zip)
  end

  def set_address
    @object = model_name.find(params[:id])
    @address = @object.address
  rescue StandardError => e
    render json: { message: e }, status: :not_found
  end

  def model_name
    controller_name.classify.constantize
  end
end
