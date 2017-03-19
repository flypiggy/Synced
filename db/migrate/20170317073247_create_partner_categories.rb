class CreatePartnerCategories < ActiveRecord::Migration[5.0]
  def change
    create_table :partner_categories, id: :uuid, default: 'uuid_generate_v4()' do |t|
      t.string :name,   null: false
      t.uuid :event_id, index: true
      t.integer :rank_order

      t.timestamps
    end
  end
end
