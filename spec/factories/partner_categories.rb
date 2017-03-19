FactoryGirl.define do
  factory :partner_category do
    name 'name'
    factory :partner_category_with_partners do
      transient do
        partners_count 5
      end

      after(:create) do |category, evaluator|
        create_list(:partner, evaluator.partners_count, partner_categories: [category])
      end
    end
  end
end
