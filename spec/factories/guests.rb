FactoryGirl.define do
  factory :guest do
    sequence(:name) { |n| "guest#{n}" }

    trait :with_avatar do |guest|
      avatars { [create(:image, imageable_type: 'guest', imageable_id: guest.id)] }
    end
  end
end
