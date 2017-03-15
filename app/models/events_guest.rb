class EventsGuest < ApplicationRecord
  validates :event_id, uniqueness: { scope: [:guest_id], message: :cant_add_repeat }
  belongs_to :event
  belongs_to :guest
  after_create :set_to_top

  include RankedModel
  ranks :rank_order, with_same: :event_id

  def set_to_top
    update!(rank_order_position: 0)
  end
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
#  rank_order :integer
#  show       :boolean          default(FALSE)
#
# Indexes
#
#  index_events_guests_on_event_id  (event_id)
#  index_events_guests_on_guest_id  (guest_id)
#
