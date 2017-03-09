require 'rails_helper'

RSpec.describe VotesController, type: :controller do
  describe 'PUT #vote_up' do
    let(:vote_item) { create :vote_item }

    it 'should returen 404 when vote disabled' do
      vote_item = create :vote_item_disabled
      expect(put(:vote_up, params: { id: vote_item.id, format: :js })).to have_http_status(404)
    end

    it 'should success vote enabled' do
      put :vote_up, params: { id: vote_item.id, format: :json }
      expect(response).to be_success
    end

    it 'should render right count' do
      3.times { put :vote_up, params: { id: vote_item.id, format: :json } }
      expect(JSON.parse(response.body)['total']).to eq 3
    end
  end
end
