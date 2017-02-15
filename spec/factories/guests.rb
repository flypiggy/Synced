FactoryGirl.define do
  factory :guest do
    sequence(:name) { |n| "guest#{n}" }
  end
end
