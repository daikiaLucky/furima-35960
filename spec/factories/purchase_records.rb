FactoryBot.define do
  factory :purchase_record_shipping_address do
    postal_code   { '123-4567' }
    prefecture_id { Faker::Number.between(from: 2, to: 48) }
    municipality  { Faker::Address.city }
    house_number  { Faker::Address.street_name }
    building_name { Faker::Address.building_number }
    phone_number  { Faker::PhoneNumber.subscriber_number(length: 11) }
    token         { 'tok_abcdefghijk00000000000000000' }
    association :user
    association :item
  end
end
