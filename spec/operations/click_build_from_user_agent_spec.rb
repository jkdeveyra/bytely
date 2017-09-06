describe Click::BuildFromUserAgent do
  it 'can parse Safari browser in iPad' do
    user_agent = 'Mozilla/5.0 (iPad; CPU OS 6_0_1 like Mac OS X) AppleWebKit/536.26 (KHTML, like Gecko) Version/6.0 Mobile/10A523 Safari/8536.25'
    click = Click::BuildFromUserAgent.run(user_agent: user_agent)
    expect(click).not_to be_nil
    expect(click.browser).to eq 'Mobile Safari'
    expect(click.version_major).to eq '6'
    expect(click.version_minor).to eq '0'
    expect(click.os_family).to eq 'iOS'
    expect(click.os_version).to eq '6.0.1'
    expect(click.device_family).to eq 'iPad'
    expect(click.device_brand).to be_nil
    expect(click.device_model).to be_nil
  end
end