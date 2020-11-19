# frozen_string_literal: true

FactoryBot.define do
  factory :school do
    name { Faker::Educator.university }
    after(:build) do |school|
      school.address = build(:address, addressable: school)
    end
  end
end
