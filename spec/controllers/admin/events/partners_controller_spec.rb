require 'rails_helper'

RSpec.describe Admin::Events::PartnersController, type: :controller do
  before { warden.set_user create(:organizer) }

  let(:event) { create(:event) }
  let(:partner) { create(:partner) }
  let(:partner_category) { create(:partner_category_with_partners, partners_count: 3) }
  describe 'Post #create' do
    it 'create a partner_categories_partner' do
      expect do
        post :create, params: {
          event_id: event.id,
          partner_category_id: partner_category.id,
          id: partner.id
        }
      end.to change { partner_category.partners.count }.by(1)
    end
  end

  describe 'Patch #update' do
    it 'create a partner_categories_partner' do
      partner = partner_category.partners.first
      patch :update, params: {
        event_id: event.id,
        partner_category_id: partner_category.id,
        id: partner.id,
        partner_categories_partner: {
          rank_order_position: 0
        }
      }
      partner_categories_partner = PartnerCategoriesPartner.find_by(
        partner_category: partner_category,
        partner: partner
      )
      top = partner_category.partner_categories_partners.rank(:rank_order).first
      expect(top).to eq partner_categories_partner
    end
  end

  describe 'Delete #destroy' do
    it 'create a partner_categories_partner' do
      partner = partner_category.partners.first
      expect do
        delete :destroy, params: {
          event_id: event.id,
          partner_category_id: partner_category.id,
          id: partner.id
        }
      end.to change { partner_category.partners.count }.by(-1)
    end
  end
end
