require 'rails_helper'

RSpec.describe Admin::GuestsController, type: :controller do
  describe 'CRUD' do
    describe 'Get #index' do
      it 'return 200' do
        get :index
        expect(response).to be_success
      end
    end
  end
end
