FactoryGirl.define do
  factory :vote_item do
    name 'test_vote_item'
    count 0
    association :vote, factory: :enabled_vote

    factory :vote_item_disabled do
      vote
    end
  end
end
