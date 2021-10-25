FactoryBot.define do
  factory :tweet do
    content { "MyString" }
    likes { 1 }
    user { nil }
  end
end
