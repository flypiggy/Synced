require 'rails_helper'

RSpec.describe SessionsController, type: :controller do
  let(:user) { create(:basic_user) }

  describe 'Get #new' do
    it 'render success' do
      get :new
      expect(response).to be_success
    end

    context 'when already login' do
      before { warden.set_user(user) }
      it 'redirect root' do
        get :new
        expect(response).to redirect_to(root_path)
      end
    end
  end

  describe 'Post #create' do
    it 'login fail with wrong password' do
      post :create, params: { login_name: user.email, password: 'wrong password' }
      expect(warden.user).to eq nil
    end

    it 'login success when with right password' do
      post :create, params: { login_name: user.email, password: user.password }
      expect(response).to redirect_to(root_path)
      expect(warden.user).to eq user
    end
  end
end
