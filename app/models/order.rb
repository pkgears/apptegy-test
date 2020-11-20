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
end
