FactoryBot.define do
  factory :research do
    title { Faker::Lorem.sentence }
    status { %w[open closed].sample }
  end
end
