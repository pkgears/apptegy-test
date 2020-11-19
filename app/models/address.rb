# frozen_string_literal: true

# Address model
class Address < ApplicationRecord
  belongs_to :addressable, polymorphic: true
  validates :address, :city, :state, :zip, presence: true
end
