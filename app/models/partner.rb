class Partner < ApplicationRecord
  validates :name, presence: true

  has_many :logos, as: :imageable, class_name: 'Image', dependent: :destroy

  accepts_nested_attributes_for :logos, allow_destroy: true
end

# == Schema Information
#
# Table name: partners
#
#  id         :uuid             not null, primary key
#  name       :string           not null
#  url        :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
