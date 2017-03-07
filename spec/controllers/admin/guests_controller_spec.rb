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

    it 'create a guest if params valid' do
      expect { xhr :post, :create, params: { guest: guest_params }, format: 'js' }.to change { Guest.count }.by(1)
    end

    it 'will not create guest if params invalid' do
      invalid_guest_params = attributes_for(:guest, name: '')
      expect { xhr :post, :create, params: { guest: invalid_guest_params } }.to change { Guest.count }.by(0)
    end

    it 'create avatar if with images' do
      guest_params = attributes_for(:guest, avatars_attributes: [attributes_for(:image)])
      expect { xhr :post, :create, params: { guest: guest_params } }
        .to change { Image.count }.by(1)
    end
  end

  describe 'Patch #update' do
    let(:guest) { create(:guest) }
    let(:guest_with_avatars) { create(:guest_with_avatars) }
    let(:file) { Rack::Test::UploadedFile.new(Rails.root.join('app', 'assets', 'images', 'admin', 'user-bg.jpg')) }
    let(:image_attributes) { { avatars_attributes: [{ file: file }] } }

    it 'change name when update guest name' do
      xhr :patch, :update, params: { guest: { name: 'changed_name' }, id: guest.id }
      expect(guest.reload.name).to eq 'changed_name'
    end

    it 'create new avatar when patch more image' do
      expect { xhr :patch, :update, params: { guest: image_attributes, id: guest_with_avatars.id } }
        .to change { guest_with_avatars.avatars.count }.by(1)
    end
  end

  describe 'Delete #destroy' do
    let(:guest) { create(:guest) }

    it 'will destroy this gust when delete request to destroy' do
      xhr :delete, :destroy, params: { id: guest.id }
      expect(Guest.find_by(id: guest.id)).to eq nil
    end
  end
end
