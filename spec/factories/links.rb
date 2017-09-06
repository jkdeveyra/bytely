FactoryGirl.define do
  sequence(:url) { |n| "#{Faker::Internet.url}#{n}" }
  sequence(:url_title) { |n|  "#{Faker::GameOfThrones.quote}#{n}" }

  factory :link do
    url
    title { generate(:url_title) }
    sequence(:code) { |n| "#{RandomCode.generate}#{n}" }
  end
end
