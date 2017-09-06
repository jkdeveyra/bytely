require 'rails_helper'

describe 'Show link' do
  let(:link) { create(:link) }

  it 'returns link json using ID' do
    get '/links/' + link.id
    expect(response).to have_http_status :ok
    expect_json(
      id: link.id.to_s,
      title: link.title,
      code: link.code,
      shorten_url: "#{server_url}/#{link.code}",
      original_url: link.url
    )
  end

  it 'returns link json using code' do
    get '/links/' + link.code
    expect(response).to have_http_status :ok
    expect_json(
      id: link.id.to_s,
      title: link.title,
      code: link.code,
      shorten_url: "#{server_url}/#{link.code}",
      original_url: link.url
    )
  end
end
