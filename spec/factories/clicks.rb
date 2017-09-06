FactoryGirl.define do
  factory :click do
    sequence(:session_id) { |n| n.to_s }
    ip_address { Faker::Internet.ip_v4_address }
    referer { Faker::Internet.url }
    link
    link_code { link.code }
    created_at { Time.now }

    after(:build) do |click|
      Click::BuildFromUserAgent.run(
        click: click,
        user_agent: Faker::Internet.user_agent
      )
    end
  end
end
