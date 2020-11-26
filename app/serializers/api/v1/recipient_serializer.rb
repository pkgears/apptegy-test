# frozen_string_literal: true

class Api::V1::RecipientSerializer < ActiveModel::Serializer
  attributes :id, :name, :email
  has_one :address
  belongs_to :school
end
