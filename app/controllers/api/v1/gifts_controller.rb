# frozen_string_literal: true
class Api::V1::GiftsController < Api::V1::ApplicationController
  before_action :set_gift, only: %i[show update destroy]

  # GET /api/v1/gifts
  def index
    @gifts = Gift.all

    render json: @gifts, each_serializer: Api::V1::GiftSerializer
  end

  # GET /api/v1/gifts/1
  def show
    render json: @gift
  end

  # POST /api/v1/gifts
  def create
    @gift = Gift.new(gift_params)

    if @gift.save
      render json: @gift, serializer: Api::V1::GiftSerializer, status: :created
    else
      render json: @gift.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /api/v1/gifts/1
  def update
    if @gift.update(gift_params)
      render json: @gift, serializer: Api::V1::GiftSerializer
    else
      render json: @gift.errors, status: :unprocessable_entity
    end
  end

  # DELETE /api/v1/gifts/1
  def destroy
    render json: { message: 'Gift deleted' }, status: :ok if @gift.destroy
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_gift
    @gift = Gift.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    render json: { message: 'Gift not found' }, status: :not_found
  end

  # Only allow a trusted parameter "white list" through.
  def gift_params
    params.require(:gift).permit(:name)
  end
end
