require 'rails_helper'

RSpec.describe Admin::GuestsController, type: :controller do
  before { warden.set_user create(:organizer) }

  describe 'Get #index' do
    it 'return 200' do
      get :index
      expect(response).to be_success
    end
  end

  describe 'Post #create' do
    let(:guest_params) { attributes_for(:guest) }
    let(:invalid_guest_params) { attributes_for(:guest, name: '') }
    it 'create a guest if params valid' do
      expect { post :create, params: { guest: guest_params }, format: 'js' }.to change { Guest.count }.by(1)
    end
  end

  describe 'Patch #update' do
    let(:guest) { create(:guest) }
    it 'change name when update guest name' do
      patch :update, params: { guest: { name: 'changed_name' }, id: guest.id }, format: 'js'
      expect(guest.reload.name).to eq 'changed_name'
    end
  end

  describe 'Delete #destroy' do
    let(:guest) { create(:guest) }
    it 'will destroy this gust when delete request to destroy' do
      delete :destroy, params: { id: guest.id }, format: 'js'
      expect(Guest.find_by(id: guest.id)).to eq nil
    end
  end
end
