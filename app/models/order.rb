# frozen_string_literal: true
# == Schema Information
#
# Table name: orders
#
#  id         :bigint           not null, primary key
#  status     :integer          default("ORDER_RECEIVED")
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  school_id  :bigint
#
# Indexes
#
#  index_orders_on_school_id  (school_id)
#
class Order < ApplicationRecord
  has_and_belongs_to_many :gifts
  has_and_belongs_to_many :recipients
  belongs_to :school

  validate :number_of_recipients
  validate :number_of_gifts

  before_update :can_update?

  enum status: %w[ORDER_RECEIVED ORDER_PROCESSING ORDER_SHIPPED ORDER_CANCELLED]

  private

  def can_update?
    if status_was == 'ORDER_SHIPPED'
      errors.add(:status, 'order was shipped, it cannot be updated')
      throw :abort
    end
    true
  end

  def number_of_recipients
    errors.add(:recipients, 'number of recipients exceeded. 20 is the limit allowed.') if recipients.size > 20
    errors.add(:recipients, 'order should has almost one recipient') if recipients.empty?
  end

  def number_of_gifts
    errors.add(:gifts, 'order should has almost one gift') if gifts.empty?
  end
end
