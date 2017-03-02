class CreateImages < ActiveRecord::Migration[5.0]
  def change
    create_table :images, id: :uuid, default: 'uuid_generate_v4()' do |t|
      t.string  :file
      t.integer :imageable_id,   index: true
      t.string  :imageable_type, index: true
      
      t.timestamps
    end
  end
end
