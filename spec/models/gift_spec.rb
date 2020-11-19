# == Schema Information
#
# Table name: gifts
#
#  id         :bigint           not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
require 'rails_helper'

RSpec.describe Gift, type: :model do
  it { should validate_presence_of(:name) }
end
