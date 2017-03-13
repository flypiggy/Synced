require 'rails_helper'

RSpec.describe Admin::EventsController, type: :controller do
  let(:event) { create(:event) }
  describe 'Get #index' do
    it 'return 200' do
      get :index
      expect(response).to be_success
    end
  end

  describe 'Get #new' do
    it 'return 200' do
      get :index
      expect(response).to be_success
    end
  end

  describe 'Get #edit' do
    it 'return 200' do
      get :edit, params: { id: event.id }
      expect(response).to be_success
    end
  end

  describe 'Post #create' do
    let(:event_params) { attributes_for(:event) }
    it 'create a post' do
      expect { post :create, params: { event: event_params } }
        .to change { Event.count }.by(1)
    end
  end

  describe 'Patch #update' do
    it 'create a post' do
      patch :update, params: { id: event.id, event: { name: 'new_name' } }
      expect(event.reload.name).to eq 'new_name'
    end
  end

  describe 'Delete #destroy' do
    it 'delete a post' do
      delete :destroy, params: { id: event.id }, xhr: true
      expect(Event.find_by(id: event.id)).to eq nil
    end
  end
end
