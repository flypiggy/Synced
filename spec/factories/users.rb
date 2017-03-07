FactoryGirl.define do
  factory :user do
    sequence(:username) { |n| "username#{n}" }
    city     '440_300'
    company  'jixiezhixin'
    title    'developer'

    trait :with_email do
      sequence(:email) { |n| "user#{n}@gmail.com" }
    end

    trait :with_mobile do
      sequence(:mobile) { rand(10**10...10**11) }
    end

    trait :with_password do
      password 'password'
    end

    factory :basic_user do
      with_email
      with_password

      factory :admin do
        roles ['admin']
      end

      factory :organizer do
        roles ['organizer']
      end
    end
  end
end
