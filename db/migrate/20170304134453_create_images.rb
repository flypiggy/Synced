class CreateImages < ActiveRecord::Migration[5.0]
  def change
    create_table :images, id: :uuid, default: 'uuid_generate_v4()' do |t|
      t.string  :file
      t.integer :imageable_id
      t.string  :imageable_type

      t.timestamps
    end
    add_index :images, [:imageable_id, :imageable_type]
  end
end
