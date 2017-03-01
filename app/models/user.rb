class User < ApplicationRecord
  has_secure_password validation: false
  validates_absence_of :password, message: 'You need set email or mobile first',
    if: -> { email.blank? && mobile.blank? }
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
