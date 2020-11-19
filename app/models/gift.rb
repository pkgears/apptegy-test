# frozen_string_literal: true

# == Schema Information
#
# Table name: gifts
#
#  id         :bigint           not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Gift < ApplicationRecord
  validates :name, presence: true
end
