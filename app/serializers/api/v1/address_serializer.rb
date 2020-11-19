class Api::V1::AddressSerializer < ActiveModel::Serializer
  attributes :address, :city, :state, :zip
  has_one :address
end
