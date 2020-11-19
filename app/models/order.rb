# == Schema Information
#
# Table name: orders
#
#  id         :bigint           not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Order < ApplicationRecord
  has_and_belongs_to_many :gifts
  has_and_belongs_to_many :recipients
end
