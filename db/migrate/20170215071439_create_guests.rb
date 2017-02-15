class CreateGuests < ActiveRecord::Migration[5.0]
  def change
    create_table :guests, id: :uuid, default: "uuid_generate_v4()" do |t|
      t.string   'name',    null: false
      t.string   'company'
      t.string   'title'

      t.timestamps
    end
  end
end
