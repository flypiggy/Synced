class CreateVotes < ActiveRecord::Migration[5.0]
  def change
    create_table :votes, id: :uuid, default: 'uuid_generate_v4()' do |t|
      t.string :name, null: false
      t.boolean :enabled, default: false, null: false
      t.string :votable_type, null: false
      t.uuid :votable_id, null: false

      t.timestamps
    end

    add_index :votes, [:votable_type, :votable_id]
  end
end
