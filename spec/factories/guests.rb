FactoryGirl.define do
  factory :guest do
    sequence(:name) { |n| "guest#{n}" }

    factory :guest_with_avatars, class: Guest do
      sequence(:name) { |n| "guest#{n}" }
      transient { avatar_count 1 }

      after(:create) do |guest, evaluator|
        create_list(:image, evaluator.avatar_count, imageable: guest)
      end
    end
  end
end
