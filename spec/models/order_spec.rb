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

  describe '#number_of_recipients' do
    before do
      @recipients = create_list(:recipient, 21)
      @school = create(:school)
    end

    it 'should return error of recipients limit exceeded' do
      order = Order.new(school: @school, recipient_ids: @recipients.map(&:id), gift_ids:[create(:gift).id])
      expect(order.valid?).to be(false)
    end

    it 'should return error for no one recipient' do
      order = Order.new(school: @school, recipient_ids: [], gift_ids:[create(:gift).id])
      expect(order.valid?).to be(false)
    end

    it 'should return a valid  order' do
      order = Order.new(school: @school, recipient_ids: @recipients.first(5).map(&:id), gift_ids:[create(:gift).id])
      expect(order.valid?).to be(true)
    end
  end

  describe '#number_of_gifts' do
    before do
      @gifts = create_list(:gift, 5)
      @school = create(:school)
    end

    it 'should return error for no one gift' do
      order = Order.new(school: @school, gift_ids: [], recipient_ids: [create(:recipient).id])
      expect(order.valid?).to be(false)
    end

    it 'should return a valid order' do
      order = Order.new(school: @school, gift_ids: @gifts.map(&:id), recipient_ids: [create(:recipient).id])
      expect(order.valid?).to be(true)
    end
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
