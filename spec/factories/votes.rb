FactoryGirl.define do
  factory :vote do
    name 'test_vote'
    association :votable, factory: :event

    factory :enabled_vote do
      enabled true
    end
  end
end
