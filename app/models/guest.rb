class Guest < ApplicationRecord
  validate :name, presence: true

  has_many :events_guests, dependent: :destroy
  has_many :events, through: :events_guests
end
