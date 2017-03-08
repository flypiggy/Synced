require 'rails_helper'

RSpec.describe Admin::SponsorsController, type: :controller do
  before { warden.set_user create(:organizer) }

  let (:sponsor) { create(:sponsor) }

  describe 'Get #index' do
    it 'return 200' do
      get :index
      expect(response).to be_success
    end
  end

  describe 'Get #new' do
    it 'return 200' do
      get :new, xhr: true
      expect(response).to be_success
    end
  end

  describe 'Get #edit' do
    it 'return 200' do
      get :edit, params: { id: sponsor.id }, xhr: true
      expect(response).to be_success
    end
  end

  describe 'Post #create' do
    it 'create a sponsor' do
      expect { post :create, params: { sponsor: attributes_for(:sponsor) }, xhr: true }.to change { Sponsor.count }.by(1)
    end
  end

  describe 'Patch' do
    it 'update a sponsor' do
      patch :update, params: { sponsor: { name: 'rename' }, id: sponsor.id }, xhr: true
      expect(sponsor.reload.name).to eq 'rename'
    end
  end

  describe 'Delete #destroy' do
    it 'deleta a sponsor' do
      delete :destroy, params: { id: sponsor.id }, xhr: true
      expect(Sponsor.find_by(id: sponsor.id)).to eq nil
    end
  end
end
