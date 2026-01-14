FactoryBot.define do
  factory :generated_project do
    template { nil }
    user { nil }
    config_choices { "" }
    download_count { 1 }
  end
end
