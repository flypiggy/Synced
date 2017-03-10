require 'rails_helper'

RSpec.describe Guest, type: :model do
  describe 'Validate avatar count limit' do
    it 'return error if exceed count limit' do
      guest = Guest.new(attributes_for(:guest, avatars_attributes: attributes_for_list(:image, 7)))
      guest.valid?
      expect(guest.errors.full_messages).to include '头像超过数量限制'
    end
  end
end
