class EventsGuest < ApplicationRecord
  belongs_to :event
  belongs_to :guest
end

# == Schema Information
#
# Table name: events_guests
#
#  id         :integer          not null, primary key
#  event_id   :uuid
#  guest_id   :uuid
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_events_guests_on_event_id  (event_id)
#  index_events_guests_on_guest_id  (guest_id)
#
