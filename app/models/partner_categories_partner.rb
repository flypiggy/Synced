class PartnerCategoriesPartner < ApplicationRecord
  validates :partner_category_id, uniqueness: { scope: [:partner_id], message: :cant_add_repeat }
  belongs_to :partner
  belongs_to :partner_category
  after_create :set_to_top

  include RankedModel
  ranks :rank_order, with_same: :partner_category_id

  def set_to_top
    update!(rank_order_position: 0)
  end
end

# == Schema Information
#
# Table name: partner_categories_partners
#
#  id                  :integer          not null, primary key
#  partner_category_id :uuid
#  partner_id          :uuid
#  rank_order          :integer
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#
# Indexes
#
#  index_partner_categories_partners_on_partner_category_id  (partner_category_id)
#  index_partner_categories_partners_on_partner_id           (partner_id)
#
