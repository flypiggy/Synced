class EventsGuest < ApplicationRecord
  belongs_to :events
  belongs_to :guests
end
