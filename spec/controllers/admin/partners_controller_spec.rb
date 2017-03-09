require 'rails_helper'

RSpec.describe Admin::PartnersController, type: :controller do
  before { warden.set_user create(:organizer) }

  let(:partner) { create(:partner) }

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
      get :edit, params: { id: partner.id }, xhr: true
      expect(response).to be_success
    end
  end

  describe 'Post #create' do
    it 'create a partner' do
      expect { post :create, params: { partner: attributes_for(:partner) }, xhr: true }
        .to change { Partner.count }.by(1)
    end
  end

  describe 'Patch' do
    it 'update a partner' do
      patch :update, params: { partner: { name: 'rename' }, id: partner.id }, xhr: true
      expect(partner.reload.name).to eq 'rename'
    end
  end

  describe 'Delete #destroy' do
    it 'deleta a partner' do
      delete :destroy, params: { id: partner.id }, xhr: true
      expect(Partner.find_by(id: partner.id)).to eq nil
    end
  end
end
