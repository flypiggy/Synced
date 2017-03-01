FactoryGirl.define do
  factory :user do
    sequence(:username) { |n| "user#{n}" }
    city     '440_300'
    company  'jixiezhixin'
    title    'developer'

    trait :with_email do
      sequence(:email) { |n| "user#{n}@mail.com" }
    end

    trait :with_mobile do
      sequence(:mobile) { rand(10**11...10**12) }
    end

    trait :with_password do
      password 'password'
    end
  end

  factory :user_register_with_email, traits: [:with_email, :with_password]
end
