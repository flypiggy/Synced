class User < ApplicationRecord
  include Pinyinable

  has_secure_password validation: false

  validates :name, length: { in: 2..20 }, presence: true,
    format: { with: /\A(?!_)(?!.*?_$)[a-zA-Z0-9_\u4e00-\u9fa5]+\z/ }

  validates :email,  uniqueness: true,
    format: { with: /\A[^@]+@([^@\.]+\.)+[^@\.]+\z/ },
    allow_nil: true
  validates :mobile, uniqueness: true,
    format: { with: /\A\d{11}\z/, message: 'only 11 numbers china mobile' },
    allow_nil: true
  validates :mobile, presence: { message: 'email and mobile at least have one' },
                     on: :create, if: ->(user) { user.email.blank? }

  validates :username, length: { in: 4..20 },
    format: { with: /\A(?!_)(?!.*?_$)[a-zA-Z0-9_]+\z/ },
    uniqueness: true, on: :update
  validates :password, length: { in: 6...32 }
  validates_absence_of :password, message: 'You need set email or mobile first',
    if: -> { email.blank? && mobile.blank? }

  before_create :generate_username

  class << self
    def search_by_login_name(identify)
      q = identify.to_s.downcase.chomp
      return unless q
      find_by('lower(email) = ? or mobile = ? or username = ?', q, q, q)
    end
  end

  def authenticate(password)
    super(password)
  rescue BCrypt::Errors::InvalidHash
    nil
  end

  private

  def generate_username
    self[:username] = pinyin.slice(0, 20)
    self[:username] = SecureRandom.hex(10) while User.exists? username: username
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
#  name            :string
#  pinyin          :string
#  pinyin_abbr     :string
#
# Indexes
#
#  index_users_on_email        (email)
#  index_users_on_mobile       (mobile)
#  index_users_on_pinyin       (pinyin)
#  index_users_on_pinyin_abbr  (pinyin_abbr)
#  index_users_on_username     (username)
#
