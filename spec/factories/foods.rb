FactoryBot.define do
  factory :food do
    food_name { "鶏卵　全卵　ゆで" }
    protein { 12.9 }
    carbohydrate { 0.3 }
    fat { 10 }
    salt_equivalents { 0.3 }
    calorie { 151 }
    total_calories { 151 }
    quantity { 100 }
    date { "2021-03-02" }
    created_at { 10.minutes.ago }
    time_zone {"昼"}
    association :user

    trait :minutes do
      food_name { "＜畜肉類＞_ぶた　［大型種肉］　ロース　脂身つき　とんかつ　" }
      protein { 22 }
      carbohydrate { 9.8 }
      fat { 35.9 }
      salt_equivalents { 0.3 }
      calorie { 450 }
      total_calories { 450 }
      quantity { 100 }
      date { "2021-03-02" }
      time_zone {"夜"}
      created_at { 50.minutes.ago }
    end

    trait :hour do
      food_name { "＜鳥肉類＞にわとり　［成鶏肉］　手羽　皮つき　生" }
      protein { 23 }
      carbohydrate { 0 }
      fat { 10.4 }
      salt_equivalents { 0.1 }
      calorie { 195 }
      total_calories { 195 }
      quantity { 100 }
      date { "2021-03-02" }
      time_zone {"昼"}
      created_at { 1.hour.ago }
    end

    trait :most do
      food_name { "＜魚類＞あこうだい　生　　" }
      protein { 16.8 }
      carbohydrate { 0.1 }
      fat { 2.3 }
      salt_equivalents { 0.1 }
      calorie { 93 }
      total_calories { 93 }
      quantity { 100 }
      date { "2021-03-02" }
      time_zone {"朝"}
      created_at { Time.zone.now }
    end
  end
end
