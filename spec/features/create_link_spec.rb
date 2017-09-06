require 'rails_helper'
require 'support/helpers/uri_helpers'

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
    expect(page).to have_content "#{server_host_and_port}/#{Link.first.code}"
  end

  scenario 'Same code for same URL' do
    link = create(:link, url: 'http://www.google.com')

    visit '/'
    fill_in 'link[url]', with: link.url
    find('input[type="submit"]').click

    expect(Link.count).to equal 1
    expect(page).to have_content "#{server_host_and_port}/#{link.code}"
  end
end
