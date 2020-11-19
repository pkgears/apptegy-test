# == Schema Information
#
# Table name: schools
#
#  id         :bigint           not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
require 'rails_helper'

RSpec.describe School, type: :model do
  describe 'references' do
    it { should have_one(:address) }
  end

  describe 'validations' do
    it { should validate_presence_of(:name) }
  end
end
