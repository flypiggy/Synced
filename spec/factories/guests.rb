FactoryGirl.define do
  factory :guest do
    sequence(:name) { |n| "guest#{n}" }
  end

  factory :guest_with_avatars, class: Guest do
    sequence(:name) { |n| "guest#{n}" }
    transient { avatar_count 1 }

    avatars do |guest|
      (1..avatar_count).map { create(:image, imageable_type: 'guest', imageable_id: guest.id) }
    end
  end
end
