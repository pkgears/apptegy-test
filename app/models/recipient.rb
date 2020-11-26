# frozen_string_literal: true

# == Schema Information
#
# Table name: recipients
#
#  id         :bigint           not null, primary key
#  email      :string
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  school_id  :bigint
#
# Indexes
#
#  index_recipients_on_school_id  (school_id)
#
class Recipient < ApplicationRecord
  has_one :address, as: :addressable, dependent: :destroy
  accepts_nested_attributes_for :address, allow_destroy: true
  belongs_to :school

  validates :name, :email, :address, presence: true
  validates :email, uniqueness: true
  validate :email_valid?

  REGEX_PATTERN = /^(.+)@(.+)$/.freeze

  private

  def email_valid?
    email =~ REGEX_PATTERN
  end
end
