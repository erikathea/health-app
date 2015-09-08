FactoryGirl.define do
  factory :lab_detail do
    lab_record
    sequence(:name) { |i| "Detail #{i}" }
    sequence(:value) { |i| "0#{i}" }
  end
end