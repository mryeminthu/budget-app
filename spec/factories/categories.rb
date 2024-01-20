FactoryBot.define do
  factory :category do
    name { 'Example Category' }
    after(:build) do |category|
      category.icon.attach(io: File.open(Rails.root.join('app', 'assets', 'images', 'arrow-left.svg')),
                           filename: 'arrow-left.svg', content_type: 'image/svg+xml')
    end
    association :user, factory: :user
  end
end
