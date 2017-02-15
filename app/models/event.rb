class Event < ApplicationRecord
  validates :name, :type, :start_date, :end_date, presence: true

  enum type: { common: 1, gmis: 2 }
  enum status: { preparing: 0, normal: 10, applying: 20, processing: 30, end: 99 }
end
