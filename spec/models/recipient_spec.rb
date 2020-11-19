# == Schema Information
#
# Table name: recipients
#
#  id         :bigint           not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  school_id  :bigint
#
# Indexes
#
#  index_recipients_on_school_id  (school_id)
#
require 'rails_helper'

RSpec.describe Recipient, type: :model do
  describe 'references' do
    it { should have_one(:address) }
    it { should belong_to(:school) }
  end

  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:address) }
  end
end
