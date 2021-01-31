FactoryBot.define do
  factory :pay_form do
    token { 'sampletokensampletoken' }
    postal_code { '123-4567' }
    prefecture_id { 1 }
    city { '千代田区' }
    address { '丸の内3丁目3番１号' }
    building {'新東京ビル４F テックキャンプ 東京丸の内校'}
    phone_number { '09012345678' }
  end
end