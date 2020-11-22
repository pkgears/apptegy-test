# == Schema Information
#
# Table name: gifts
#
#  id         :bigint           not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
FactoryBot.define do
  factory :gift do
    name Faker::Appliance.equipment
  end
end
