FactoryBot.define do
  factory :user do
    nickname {Faker::Name.name}
    email {Faker::Internet.free_email}
    password { Faker::Lorem.characters(number: 6, min_alpha: 1, min_numeric: 1) }
    password_confirmation { password }
    first_name { '大器' }
    last_name { '荒木' }
    first_name_katakana { 'ダイキ' }
    last_name_katakana { 'アラキ' }
    birthday { Faker::Date.backward }
  end
end
