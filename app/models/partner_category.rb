class PartnerCategory < ApplicationRecord
  validates :name, presence: true

  belongs_to :event
  has_many :partner_categories_partners
  has_many :partners, through: :partner_categories_partners, source: :partner

  include RankedModel
  ranks :rank_order, with_same: :event_id
end

# == Schema Information
#
# Table name: partner_categories
#
#  id         :uuid             not null, primary key
#  name       :string           not null
#  event_id   :uuid
#  rank_order :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_partner_categories_on_event_id  (event_id)
#
