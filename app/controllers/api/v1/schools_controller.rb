class Api::V1::SchoolsController < ApplicationController
  include Addressable
  before_action :set_school, only: %i[show update destroy]

  def index
    @schools = School.all
    render json: @schools, each_serializer: Api::V1::SchoolSerializer
  end

  def show
    render json: @school, serializer: Api::V1::SchoolSerializer
  end

  def create
    @school = School.new(school_with_address_params)
    if @school.save
      render json: @school, serializer: Api::V1::SchoolSerializer, status: :created
    else
      render json: @school.errors, status: :unprocessable_entity
    end
  end

  def update
    if @school.update(school_params)
      render json: @school, serializer: Api::V1::SchoolSerializer, status: :ok
    else
      render json: @school.errors, status: :unprocessable_entity
    end
  end

  def destroy
    render json: { message: 'School deleted' }, status: :ok if @school.destroy
  end

  private

  def set_school
    @school = School.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    render json: { message: 'School not found' }, status: :not_found
  end

  def school_with_address_params
    params.require(:school).permit(:name, address_attributes: %i[address city state zip])
  end

  def school_params
    params.require(:school).permit(:name)
  end
end
