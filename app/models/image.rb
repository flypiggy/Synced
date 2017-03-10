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
#  imageable_id   :uuid
#  imageable_type :string
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  default        :boolean          default(FALSE)
#
# Indexes
#
#  index_images_on_imageable_id_and_imageable_type  (imageable_id,imageable_type)
#
