class Image < ApplicationRecord
  belongs_to :imageable, polymorphic: true, optional: true
  mount_uploader :avatar, ImageUploader
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
#  index_images_on_imageable_id    (imageable_id)
#  index_images_on_imageable_type  (imageable_type)
#
