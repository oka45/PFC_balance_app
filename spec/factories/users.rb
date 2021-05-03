FactoryBot.define do

  factory :user do
    name                  { Gimei.name }
    email                 { "test#{Gimei.address.city.romaji}@gmail.com" }
    password              { "password" }
    password_confirmation { "password" }

    trait :admin_user do
      name                  { "test" }
      email                 { "testokaoka@gmail.com" }
      password              { "password" }
      password_confirmation { "password" }
      admin                 { true }
    end
  end

end
