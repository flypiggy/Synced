require 'rails_helper'

RSpec.describe Admin::GuestsController, type: :controller do
  describe 'CRUD' do
    describe 'Get #index' do
      it 'return 200' do
        get :index
        expect(response).to be_success
      end
    end

    describe 'Get #new' do
      it 'should be ok' do
        get :new
        expect(response).to be_success
      end
    end

    describe 'Get #edit' do
      let(:guest) { create(:guest) }
      it 'should be ok' do
        get :edit, params: { id: guest.id }
        expect(response).to be_success
      end
    end

    describe 'Post #create' do
      let(:guest_params) { attributes_for(:guest) }
      let(:invalid_guest_params) { attributes_for(:guest, name: '') }
      let(:avatar_params) { attributes_for(:image) }
      it 'return error if params invalid' do
        post :create, params: { guest: guest_params }
        expect(response).to redirect_to(admin_guests_path)
      end

      it 'create a new guest if params valid' do
        post :create, params: { guest: invalid_guest_params }
        expect(flash[:error]).to include('Name不能为空字符')
      end

      it 'direct to new if params has continue' do
        post :create, params: { guest: guest_params, continue: 'anything' }
        expect(response).to redirect_to(new_admin_guest_path)
      end

      it 'create a avatar when create with a image' do
        expect { post(:create, params: { guest: guest_params, avatar: avatar_params }) }.to change { Image.count }.by(1)
      end
    end

    describe 'Patch #update' do
      let(:guest) { create(:guest) }
      it 'change name when update guest name' do
        patch :update, params: { guest: { name: 'changed_name' }, id: guest.id }
        expect(guest.reload.name).to eq 'changed_name'
      end
    end

    describe 'Delete #destroy' do
      let(:guest) { create(:guest) }
      it 'will destroy this gust when delete request to destroy' do
        delete :destroy, params: { id: guest.id }
        expect(Guest.find_by(id: guest.id)).to eq nil
      end
    end
  end
end
