# frozen_string_literal: true

# == Schema Information
#
# Table name: schools
#
#  id         :bigint           not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
FactoryBot.define do
  factory :school do
    name { Faker::Educator.university }
    after(:build) do |school|
      school.address = build(:address, addressable: school)
    end
  end
end
