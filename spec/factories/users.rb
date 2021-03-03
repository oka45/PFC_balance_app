FactoryBot.define do
  factory :user do

    name                  { Gimei.name }
    email                 { "test#{Gimei.address.city.romaji}@gmail.com" }
    password              { "password" }
    password_confirmation { "password" }
  end
end
