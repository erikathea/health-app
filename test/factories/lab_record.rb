FactoryGirl.define do
  factory :lab_record do
    patient
    physician
    association :health_facility, factory: :health_facility
    sequence(:name) { |i| "LabRec #{i}" }
    date_conducted Date.today
  end
end