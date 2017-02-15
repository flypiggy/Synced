class CreateEventsGuests < ActiveRecord::Migration[5.0]
  def change
    create_table :events_guests do |t|
      t.uuid :event_id, index: true
      t.uuid :guest_id, index: true

      t.timestamps
    end
  end
end
