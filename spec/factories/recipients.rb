# frozen_string_literal: true

FactoryBot.define do
  factory :recipient do
    name { Faker::Name.name }
    school
    after(:build) do |recipient|
      recipient.address = build(:address, addressable: recipient)
    end
  end
end
