FactoryBot.define do
  factory :user do
    username { "tony" }
    password { "123456" }
    password_confirmation { "123456" }
    full_name { "Tony Stark" }
  end
end
