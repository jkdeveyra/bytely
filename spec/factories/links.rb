FactoryGirl.define do
  factory :link do
    sequence(:title) { |n| "#{Faker::GameOfThrones.quote}" }
    sequence(:url) { |n| "#{Faker::Internet.url}#{n}" }
    sequence(:code) { |n| "#{RandomCode.generate}#{n}"}
  end
end
