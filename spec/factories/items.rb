FactoryBot.define do
  factory :item do
  
    product          {Faker::Lorem.sentence}
    explanation      {Faker::Lorem.sentence}
    category_id      {rand(2..11)} 
    sales_state_id   {rand(2..7)} 
    postage_id       {rand(2..3)} 
    prefecture_id    {rand(2..48)} 
    post_period_id   {rand(2..4)} 
    price            {rand(300..9999999)}
    association :user 

    after(:build) do |item|
      item.image.attach(io: File.open('public/images/test_image.png'), filename: 'test_image.png')
    end
  end
end
