class AddRankOrderToEventsGuest < ActiveRecord::Migration[5.0]
  def change
    add_column :events_guests, :rank_order, :integer
    add_column :events_guests, :show, :boolean, default: false
  end
end
