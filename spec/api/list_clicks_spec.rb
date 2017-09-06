require 'rails_helper'

describe 'List clicks' do
  let!(:link) { create(:link) }

  it 'response empty json if no click' do
    get "/links/#{link.code}/clicks"
    expect_status :ok
    expect_json []
  end

  it 'response with list of clicks for visited link' do
    clicks = create_list(:click, 3, link: link)
    get "/links/#{link.code}/clicks"
    expect_status :ok
    expect_json clicks.map { |c| expected_hash(c) }
  end
end

def expected_hash(click)
  {
    id: click.id.to_s,
    session_id: click.session_id,
    ip_address: click.ip_address,
    referer: click.referer,
    browser: click.browser,
    version_major: click.version_major,
    version_minor: click.version_minor,
    os_family: click.os_family,
    os_version: click.os_version,
    device_family: click.device_family,
    device_brand: click.device_brand,
    device_model: click.device_model,
    link_code: link.code,
    created_at: click.created_at.iso8601
  }
end
