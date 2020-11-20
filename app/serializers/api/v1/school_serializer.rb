class Api::V1::SchoolSerializer < ActiveModel::Serializer
  attributes :id, :name
  has_one :address
  has_many :recipients
end
