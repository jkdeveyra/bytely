require 'rails_helper'

feature 'Create link', js: true do
  scenario 'Show homepage' do
    visit '/'
    expect(page).to have_content 'Byte.ly'
    expect(page).to have_selector 'input[name="link[url]"]'
  end

  scenario 'Shorten link in the homepage' do
    visit '/'

    fill_in 'link[url]', with: Faker::Internet.url
    find('input[type="submit"]').click

    expect(Link.count).to equal 1
    expect(page).to have_content "127.0.0.1/#{Link.first.code}"
  end
end
