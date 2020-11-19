# == Schema Information
#
# Table name: orders
#
#  id         :bigint           not null, primary key
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
end
