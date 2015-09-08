FactoryGirl.define do
  factory :health_facility do
    sequence(:name) { |i| "Health Facility #{i}" }
  end
end