# frozen_string_literal: true

# Address model
class Address < ApplicationRecord
  validates :address, :city, :state, :zip, presence: true
end
