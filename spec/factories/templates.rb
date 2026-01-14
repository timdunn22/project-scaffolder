FactoryBot.define do
  factory :template do
    name { "MyString" }
    description { "MyText" }
    file_structure { "" }
    user { nil }
    is_public { false }
  end
end
