# == Schema Information
#
# Table name: orders
#
#  id         :bigint           not null, primary key
#  status     :integer          default('ORDER_RECEIVED")
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  school_id  :bigint
#
# Indexes
#
#  index_orders_on_school_id  (school_id)
#
require 'rails_helper'

RSpec.describe Order, type: :model do
  let(:order) { create(:order) }

  describe 'references' do
    it { should have_and_belong_to_many(:gifts) }
    it { should have_and_belong_to_many(:recipients) }
    it { should belong_to(:school) }
  end

  describe 'enums' do
    it { should define_enum_for(:status).with_values(%w[ORDER_RECEIVED ORDER_PROCESSING ORDER_SHIPPED ORDER_CANCELLED]) }
  end

  describe '#can_update?' do
    context 'when order status is not SHIPPED' do
      it 'should allow update' do
        expect(order.update(school: create(:school))).to be(true)
      end
    end

    context 'when order status is SHIPPED' do
      it 'should NOT allow update' do
        # order.status = 'ORDER_SHIPPED'
        order.ORDER_SHIPPED!
        expect(order.update(school: create(:school))).to be(false)
      end
    end
  end
end
