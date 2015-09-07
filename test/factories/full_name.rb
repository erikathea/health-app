FactoryGirl.define do
  factory :full_name do
    last_name 'dela Cruz'
    middle_name 'Santiago'
    sequence(:first_name) { |i| "Juan #{i}" }
  end
end