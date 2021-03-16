FactoryBot.define do
  factory :user do
    sequence(:email) { |i| "rafael#{i}@email.com" }
    password { '123456' }
  end
end