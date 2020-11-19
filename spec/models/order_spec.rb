# == Schema Information
#
# Table name: orders
#
#  id         :bigint           not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
require 'rails_helper'

RSpec.describe Order, type: :model do
  describe 'references' do
    it { should have_and_belong_to_many(:gifts) }
    it { should have_and_belong_to_many(:recipients) }
  end
end
