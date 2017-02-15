class CreateEvents < ActiveRecord::Migration[5.0]
  def change
    enable_extension 'uuid-ossp' unless extension_enabled?('uuid-ossp')

    create_table :events, id: :uuid, default: "uuid_generate_v4()" do |t|
      t.string  :name, null: false
      t.text    :description
      t.integer :event_type, null:false, default: 1
      t.integer :status, default: 0
      t.date    :start_date
      t.date    :end_date

      t.timestamps
    end

    add_index :events, :name
    add_index :events, :status
  end
end
