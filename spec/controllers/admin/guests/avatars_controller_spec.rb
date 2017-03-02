require 'rails_helper'

RSpec.describe Admin::Guests::AvatarsController, type: :controller do
  describe 'Post #create' do
    let(:guest) { create(:guest) }
    let(:avatar_params) { attributes_for(:image) }
    it 'create a guest avatar when valid request' do
      expect { post :create, params: { guest_id: guest.id, avatar: avatar_params } }
        .to change { guest.avatars.count }.by(1)
    end
  end

  describe 'Delete #destroy' do
    let(:guest) { create(:guest, :with_avatar) }
    it 'destroy a avatar' do
      expect { delete :destroy, params: { guest_id: guest.id, id: guest.avatars.first.id } }
        .to change { guest.avatars.count }.by(-1)
    end
  end
end
