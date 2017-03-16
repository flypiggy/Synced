require 'rails_helper'

RSpec.describe Admin::Events::GuestsController, type: :controller do
  before { warden.set_user create(:organizer) }

  let(:event) { create(:event) }
  let(:guest) { create(:guest) }
  let(:events_guest) { create(:events_guest) }
  describe 'Get #index' do
    it 'return 200' do
      get :index, params: { event_id: event.id }
      expect(response).to be_success
    end
  end

  describe 'Post #create' do
    it 'create a events_guest' do
      expect { post :create, params: { event_id: event.id, id: guest.id } }
        .to change { EventsGuest.count }.by(1)
    end
  end

  describe 'Delete #destroy' do
    it 'delete a events_guest' do
      create(:events_guest, event: event, guest: guest)
      expect { delete :destroy, params: { event_id: event.id, id: guest.id } }
        .to change { EventsGuest.count }.by(-1)
    end
  end

  describe 'Patch #update_order' do
    it 'change events_guest order' do
      patch :update_order, params: {
        event_id: events_guest.event_id,
        id: events_guest.guest_id,
        rank_order_position: 3
      }
      expect(response).to be_success
    end
  end

  describe 'Patch #update_show' do
    it 'change events_guest show attribute' do
      patch :update_show, params: { event_id: events_guest.event_id, id: events_guest.guest_id, show: true }
      expect(events_guest.reload.show).to eq true
    end
  end
end
