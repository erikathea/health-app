FactoryGirl.define do
  factory :patient do
    sequence(:ssn) { |i| "#{ 999000000 + i}" }
    gender false #male
    birth_date Date.today
    registration_date Date.today
    full_name
  end
end