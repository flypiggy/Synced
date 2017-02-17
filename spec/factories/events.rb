FactoryGirl.define do
  factory :event do
    name 'GMIS2017'

    start_date { 10.days.since }
    end_date { 12.days.since }

    factory :event_with_guests do
      transient do
        guests_count 5
      end

      after(:create) do |event, evaluator|
        create_list(:guest, evaluator.guests_count, events: [event])
      end
    end
  end
end
