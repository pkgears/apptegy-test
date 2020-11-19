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
require 'rails_helper'

RSpec.describe Order, type: :model do
  describe 'references' do
    it { should have_and_belong_to_many(:gifts) }
    it { should have_and_belong_to_many(:recipients) }
    it { should belong_to(:school) } 
  end
end
