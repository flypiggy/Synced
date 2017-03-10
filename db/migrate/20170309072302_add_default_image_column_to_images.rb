class AddDefaultImageColumnToImages < ActiveRecord::Migration[5.0]
  def change
    add_column :images, :default, :boolean, default: false
  end
end
