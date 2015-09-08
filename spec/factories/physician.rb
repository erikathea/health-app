FactoryGirl.define do
  factory :physician do
    association :full_name, factory: :full_name, prefix: 'Dr.', suffix: 'Sr'
  end
end