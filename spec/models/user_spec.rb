require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validation' do
    let(:user_params) { attributes_for(:user, :with_password) }
    it 'when set password no email or mobile will return error' do
      user = User.new(user_params)
      user.valid?
      expect(user.errors[:password]).to include('You need set email or mobile first')
    end
  end
end
