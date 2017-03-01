class User < ApplicationRecord
  has_secure_password validation: false
  validates_absence_of :password, message: 'You need set email or mobile first',
    if: -> { email.blank? && mobile.blank? }
  validates :email,  uniqueness: true,
    format: { with: /\A[^@]+@([^@\.]+\.)+[^@\.]+\z/ },
    allow_nil: true
  validates :mobile, uniqueness: true,
    format: { with: /\A\d{11}\z/, message: 'only 11 numbers china mobile' },
    allow_nil: true
  validates :password, length: { in: 6...32 }
  validates :username, length: { in: 6...20 }

  class << self
    def search_by_email_or_mobile(identify)
      q = identify.to_s.downcase.chomp
      return unless q
      find_by('lower(email) = ? or mobile = ?', q, q)
    end
  end
end

# == Schema Information
#
# Table name: users
#
#  id              :uuid             not null, primary key
#  email           :string
#  password_digest :string           default(""), not null
#  username        :string
#  mobile          :string
#  roles           :string           default([]), is an Array
#  city            :string
#  company         :string
#  title           :string
#  avatar          :string
#  bio             :string
#
# Indexes
#
#  index_users_on_email   (email)
#  index_users_on_mobile  (mobile)
#
