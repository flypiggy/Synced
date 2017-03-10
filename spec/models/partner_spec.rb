require 'rails_helper'

RSpec.describe Partner, type: :model do
  describe 'Validate logo count limit' do
    it 'return error if exceed count limit' do
      partner = Partner.new(attributes_for(:partner, logos_attributes: attributes_for_list(:image, 7)))
      partner.valid?
      expect(partner.errors.full_messages).to include 'LOGO超过数量限制'
    end
  end
end
