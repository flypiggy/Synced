class Image < ApplicationRecord
  validates :file, presence: true
  belongs_to :imageable, polymorphic: true, optional: true
  mount_uploader :file, ImageUploader
end

# == Schema Information
#
# Table name: images
#
#  id             :uuid             not null, primary key
#  file           :string
#  imageable_id   :integer
#  imageable_type :string
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#
# Indexes
#
#  index_images_on_imageable_id_and_imageable_type  (imageable_id,imageable_type)
#
