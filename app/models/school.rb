# frozen_string_literal: true

# == Schema Information
#
# Table name: schools
#
#  id         :bigint           not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class School < ApplicationRecord
  has_one :address, as: :addressable, dependent: :destroy
  validates :name, :address, presence: true

  accepts_nested_attributes_for :address, allow_destroy: true
end
