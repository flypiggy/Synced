class Vote < ApplicationRecord
  validates :name, presence: true

  has_many :vote_items
  belongs_to :votable, polymorphic: true
end

# == Schema Information
#
# Table name: votes
#
#  id           :uuid             not null, primary key
#  name         :string           not null
#  enabled      :boolean          default(FALSE), not null
#  votable_type :string           not null
#  votable_id   :uuid             not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
# Indexes
#
#  index_votes_on_votable_type_and_votable_id  (votable_type,votable_id)
#
