class AddShortNameToEvents < ActiveRecord::Migration[5.0]
  def change
    add_column :events, :short_name, :string, unique: true
  end
end
