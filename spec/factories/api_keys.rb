FactoryGirl.define do
  factory :api_key do
    sequence(:access_token) { |i| SecureRandom.hex }
  end
end
