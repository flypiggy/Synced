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
    let(:guest_with_avatars_params) { attributes_for(:guest_with_avatars, avatar_count: 2) }
    it 'create a guest if params valid' do
      expect { post :create, params: { guest: guest_params }, format: 'js' }.to change { Guest.count }.by(1)
    end

    it 'create avatar if with images' do
      expect { post :create, params: { guest: guest_with_avatars_params }, format: 'js' }
        .to change { Image.count }.by(2)
    end
  end

  describe 'Patch #update' do
    let(:guest) { create(:guest) }
    let(:guest_with_avatars) { create(:guest_with_avatars) }
    let(:file) { Rack::Test::UploadedFile.new(Rails.root.join('app', 'assets', 'images', 'admin', 'user-bg.jpg')) }
    let(:image_attributes) { { avatars_attributes: [{ file: file }] } }
    it 'change name when update guest name' do
      patch :update, params: { guest: { name: 'changed_name' }, id: guest.id }, format: 'js'
      expect(guest.reload.name).to eq 'changed_name'
    end

    it 'create new avatar when patch more image' do
      expect { patch :update, params: { guest: image_attributes, id: guest_with_avatars.id }, format: 'js' }
        .to change { guest_with_avatars.avatars.count }.by(1)
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
