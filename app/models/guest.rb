class Guest < ApplicationRecord
  validates :name, presence: true

  has_many :events_guests, dependent: :destroy
  has_many :events, through: :events_guests, source: :event
  has_many :avatars, as: :imageable, class_name: 'Image', dependent: :destroy

  accepts_nested_attributes_for :avatars, allow_destroy: true
end

# == Schema Information
#
# Table name: guests
#
#  id         :uuid             not null, primary key
#  name       :string           not null
#  company    :string
#  title      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
