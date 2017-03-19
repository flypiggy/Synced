class Partner < ApplicationRecord
  validates :name, presence: true
  validates :logos, length: { in: 0..6, message: :logos_count_limit }, allow_blank: true

  has_many :logos, as: :imageable, class_name: 'Image', dependent: :destroy
  has_many :partner_categories_partners
  has_many :partner_categories, through: :partner_categories_partners, source: :partner_category

  accepts_nested_attributes_for :logos, allow_destroy: true

  def default_logo
    logos.find_by(default: true) || logos.first
  end
end

# == Schema Information
#
# Table name: partners
#
#  id         :uuid             not null, primary key
#  name       :string           not null
#  url        :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
