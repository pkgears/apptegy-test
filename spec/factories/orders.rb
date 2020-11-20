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
FactoryBot.define do
  factory :order do
    school
    after(:build) do |order|
      order.recipient_ids = create_list(:recipient, 3).map(&:id)
      order.gift_ids = create_list(:gift, 3).map(&:id)
    end
  end
end
