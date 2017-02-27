class CreateVoteItems < ActiveRecord::Migration[5.0]
  def change
    create_table :vote_items, id: :uuid, default: 'uuid_generate_v4()' do |t|
      t.string :name, null: false
      t.uuid :vote_id, null: false, index: true
      t.integer :count, default: 0

      t.timestamps
    end
  end
end
