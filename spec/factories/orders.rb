FactoryBot.define do
  factory :order do
    post_code { '123-4567' }
    prefecture_id { 2 }
    city { '武蔵野市' }
    address { '1-1' }
    building_name { '東京ハイツ' }
    tel { '09012345678' }
    token {"tok_abcdefghijk00000000000000000"}
  end
end
