# frozen_string_literal: true

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
class Recipient < ApplicationRecord
  has_one :address, as: :addressable, dependent: :destroy
  validates :name, :address, presence: true

  belongs_to :school
end
