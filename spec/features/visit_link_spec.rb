require 'support/helpers/uri_helpers'

feature 'Visiting link', js: true do
  let(:link) { create(:link, url: 'http://www.example.com/') }

  scenario 'Redirect to the URL' do
    visit "/#{link.code}"
    expect(current_url).to eq link.url
  end

  scenario 'Shorten URL doesn\'t exists' do
    visit '/nonexistingcode'
    expect(current_url).to eq "#{server_url}/"
    expect(page).to have_content 'Oh snap! Link not found.'
  end
end
