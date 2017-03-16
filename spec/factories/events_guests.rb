FactoryGirl.define do
  factory :events_guest do
    association :guest, factory: :guest
    association :event, factory: :event
    rank_order 1
    show false
  end
end
