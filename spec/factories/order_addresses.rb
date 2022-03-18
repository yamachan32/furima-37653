FactoryBot.define do
  factory :order_address do

    token { "tok_0000000000000000000000000000" }
    post_code { "000-0000" }
    prefecture_id { rand(2..48) }
    city { Gimei.address.city.kanji }
    block { "#{Gimei.address.town.kanji} 0-0-0" }
    building { "仮想マンション" }
    phone_number {"00000000000"}
    
  end
end
