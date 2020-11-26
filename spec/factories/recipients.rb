# frozen_string_literal: true

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
FactoryBot.define do
  factory :recipient do
    name { Faker::Name.name }
    email { Faker::Internet.email }
    school
    after(:build) do |recipient|
      recipient.address = build(:address, addressable: recipient)
    end
  end
end
