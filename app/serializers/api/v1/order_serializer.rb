class Api::V1::OrderSerializer < ActiveModel::Serializer
  attributes :id, :status
  has_many :recipients
  has_many :gifts
  belongs_to :school
end
