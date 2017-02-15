class Guest < ApplicationRecord
  validate :name, presence: true
end
