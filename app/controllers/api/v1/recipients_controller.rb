# frozen_string_literal: true

class Api::V1::RecipientsController < Api::V1::ApplicationController
  include Addressable
  before_action :set_recipient, only: %i[show update destroy]

  def index
    @recipients = Recipient.all.include(:address, :school)
    render json: @recipients, each_serializer: Api::V1::RecipientSerializer
  end

  def show
    render json: @recipient, serializer: Api::V1::RecipientSerializer
  end

  def create
    @recipient = Recipient.new(recipient_with_address_params)
    if @recipient.save
      render json: @recipient, serializer: Api::V1::RecipientSerializer, status: :created
    else
      render json: @recipient.errors, status: :unprocessable_entity
    end
  end

  def update
    if @recipient.update(recipient_params)
      render json: @recipient, serializer: Api::V1::RecipientSerializer, status: :ok
    else
      render json: @recipient.errors, status: :unprocessable_entity
    end
  end

  def destroy
    render json: { message: 'Recipient deleted' }, status: :ok if @recipient.destroy
  end

  private

  def set_recipient
    @recipient = Recipient.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    render json: { message: 'Recipient not found' }, status: :not_found
  end

  def recipient_with_address_params
    params.require(:recipient).permit(:name, :school_id, address_attributes: %i[address city state zip])
  end

  def recipient_params
    params.require(:recipient).permit(:name, :school_id)
  end
end
