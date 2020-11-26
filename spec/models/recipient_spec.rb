# == Schema Information
#
# Table name: recipients
#
#  id         :bigint           not null, primary key
#  email      :string
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
    it { should accept_nested_attributes_for :address }
    it { should belong_to(:school) }
  end

  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:address) }
    it { should validate_uniqueness_of(:email) }

    it 'validate school existence' do
      recipient = Recipient.new(name: Faker::Name.name, school_id: 150)
      expect(recipient.valid?).to be(false)
    end
  end
end
