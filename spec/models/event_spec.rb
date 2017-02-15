require 'rails_helper'

RSpec.describe Event, type: :model do
  describe 'Relations' do
    let!(:event) { create(:event_with_guests) }

    it 'should destroy relation records after destroy' do
      expect(EventsGuest.count).to eq(5)

      event.destroy
      expect(EventsGuest.count).to eq(0)
      expect(Guest.count).to eq(5)
    end
  end
end
