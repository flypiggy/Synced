class VotesController < ApplicationController
  def vote_up
    item = VoteItem.joins(:vote).merge(Vote.where(enabled: true)).find params[:id]
    item.vote_up
    respond_to do |format|
      format.json { render json: { total: item.count } }
    end
  end
end
