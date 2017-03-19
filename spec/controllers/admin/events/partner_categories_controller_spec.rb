require 'rails_helper'

RSpec.describe Admin::Events::PartnerCategoriesController, type: :controller do
  before { warden.set_user create(:organizer) }

  let(:event) { create(:event) }
  let(:partner_category) { create(:partner_category) }
  describe 'Get #index' do
    it 'return 200' do
      get :index, params: { event_id: event.id }
      expect(response).to be_success
    end
  end

  describe 'Post #create' do
    it 'create a partner category' do
      expect { post :create, params: { event_id: event.id, partner_category: { name: 'test' } }, xhr: true }
        .to change { event.partner_categories.count }.by(1)
    end
  end

  describe 'Patch #update' do
    it 'update partner category' do
      patch :update,
        params: {
          event_id: event.id,
          id: partner_category.id,
          partner_category: { name: 'changed_name' }
        },
        xhr: true
      expect(partner_category.reload.name).to eq 'changed_name'
    end
  end

  describe 'Delete #destroy' do
    it 'destroy' do
      delete :destroy, params: { event_id: event.id, id: partner_category.id }
      expect(PartnerCategory.find_by(id: partner_category.id)).to eq nil
    end
  end
end
