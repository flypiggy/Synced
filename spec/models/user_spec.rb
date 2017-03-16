require 'rails_helper'

RSpec.describe User, type: :model do
  let!(:user) { create(:basic_user) }

  describe 'validation' do
    let(:user_params) { attributes_for(:user, :with_password) }
    it 'when set password no email or mobile will return error' do
      user = User.new(user_params)
      user.valid?
      expect(user.errors[:password]).to include('You need set email or mobile first')
    end
  end

  describe 'pinyinable' do
    it 'should generate pinyin' do
      expect(user.pinyin).to eq('jiqizhixin')
      expect(user.pinyin_abbr).to eq('jqzx')
    end
  end

  describe 'username' do
    it 'should autogenerate on create' do
      expect(user.username).to eq('jiqizhixin')
    end

    it 'should random username when username exists' do
      expect(create(:basic_user).username).not_to eq('jiqizhixin')
    end

    it 'should sliced when pinyin is too long' do
      user2 = create(:basic_user, name: '机器之心' * 5)
      expect(user2.username.length).to eq(20)
    end
  end
end
