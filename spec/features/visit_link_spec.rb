feature 'Visiting link', js: true do

  let(:server_url) { "http://#{page.server.host}:#{page.server.port}" }

  skip 'Redirect to the URL' do
    link = create(:link, url: 'www.google.com')
    visit "/#{link.code}"
    expect(current_url).to eq(link.url)
  end

  scenario 'Shorten URL doesn\'t exists' do
    visit '/nonexistingcode'
    expect(current_url).to eq "#{server_url}/"
    expect(page).to have_content 'Oh snap! Link not found.'
  end
end
