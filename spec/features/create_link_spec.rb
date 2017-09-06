require 'rails_helper'
require 'support/helpers/uri_helpers'

feature 'Create link', js: true do
  scenario 'Show homepage' do
    visit '/'
    expect(page).to have_content 'Byte.ly'
    expect(page).to have_selector 'input[name="link[url]"]'
  end

  scenario 'Shorten link in the homepage' do
    url = Faker::Internet.url

    visit '/'
    fill_in_and_submit_url url

    expect(Link.count).to equal 1
    expect(page).to have_content "#{server_host_and_port}/#{Link.first.code}"
  end

  scenario 'Same code for same URL' do
    link = create(:link, url: 'http://www.google.com')

    visit '/'
    fill_in_and_submit_url link.url

    expect(Link.count).to equal 1
    expect(page).to have_content "#{server_host_and_port}/#{link.code}"
  end

  scenario 'Invalid URL show validation error' do
    invalid_urls = %w'
      abcd
      ftp://google.com
      httpp:google.com
      http://:3000
      john@gmail.com'

    visit '/'
    invalid_urls.each do |url|
      fill_in_and_submit_url url
      expect(page).to have_content 'Link must be a valid web URL.'
      page.evaluate_script 'window.location.reload()'
    end
  end
end

def fill_in_and_submit_url(url)
  fill_in 'link[url]', with: url
  find('input[type="submit"]').click
end
