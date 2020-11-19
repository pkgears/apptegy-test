# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Address, type: :model do
  describe 'references' do
    it { should belong_to(:addressable) }
  end

  describe 'validations' do
    it { should validate_presence_of(:address) }
    it { should validate_presence_of(:city) }
    it { should validate_presence_of(:state) }
    it { should validate_presence_of(:zip) }
  end
end
