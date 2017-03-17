require 'rails_helper'

RSpec.describe Admin::Events::GuestsController, type: :controller do
  before { warden.set_user create(:organizer) }

  let(:event) { create(:event_with_guests, guests_count: 1) }
  let(:guest) { create(:guest) }
  describe 'Get #index' do
    it 'return 200' do
      get :index, params: { event_id: event.id }
      expect(response).to be_success
    end
  end

  describe 'Post #create' do
    it 'create a events_guest' do
      expect { post :create, params: { event_id: event.id, id: guest.id } }
        .to change { event.guests.count }.by(1)
    end
  end

  describe 'Delete #destroy' do
    it 'delete a events_guest' do
      expect { delete :destroy, params: { event_id: event.id, id: event.guests.first.id } }
        .to change { event.guests.count }.by(-1)
    end
  end

  describe 'Patch #update' do
    it 'update events_guest' do
      guest_id = event.guests.first.id
      patch :update, params: {
        event_id: event.id,
        id: guest_id,
        events_guest: attributes_for(:events_guest, show: true)
      }
      events_guest = EventsGuest.find_by(event_id: event.id, guest_id: guest_id)
      expect(response).to be_success
      expect(events_guest.show).to eq true
    end
  end
end
