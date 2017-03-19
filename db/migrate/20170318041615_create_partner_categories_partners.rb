class CreatePartnerCategoriesPartners < ActiveRecord::Migration[5.0]
  def change
    create_table :partner_categories_partners do |t|
      t.uuid :partner_category_id, index: true
      t.uuid :partner_id, index: true
      t.integer :rank_order

      t.timestamps
    end
  end
end
