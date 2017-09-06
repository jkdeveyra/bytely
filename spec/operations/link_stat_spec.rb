describe Link::Stat do
  it 'returns empty stat when no clicks' do
    link = create(:link)
    result = Link::Stat.run(id: link.code)
    expect(result.count).to be_zero
  end

  it 'returns empty stat when code is invalid' do
    result = Link::Stat.run(id: 'ABCDEFG')
    expect(result.count).to be_zero
  end

  it 'returns hourly stat for visited links' do
    link_a = create(:link)
    create(:click, link: link_a, created_at: Time.utc(2017, 9, 1, 0))
    create(:click, link: link_a, created_at: Time.utc(2017, 9, 1, 0, 59))
    create(:click, link: link_a, created_at: Time.utc(2017, 9, 1, 1))

    link_b = create(:link)
    create(:click, link: link_b, created_at: Time.utc(2017, 10, 1, 0))

    result_a = Link::Stat.run(id: link_a.code)
    expected_a = [
      { 'date': { 'year': 2017, 'month': 9, 'day': 1, 'hour': 0 }, 'count': 2 },
      { 'date': { 'year': 2017, 'month': 9, 'day': 1, 'hour': 1 }, 'count': 1 }
    ]
    expect(result_a.to_json).to eq expected_a.to_json

    result_b = Link::Stat.run(id: link_b.code)
    expected_b = [
      { 'date': { 'year': 2017, 'month': 10, 'day': 1, 'hour': 0 }, 'count': 1 },
    ]
    expect(result_b.to_json).to eq expected_b.to_json
  end

  it 'counts unique clicks by session id' do
    link_b = create(:link)
    create(:click, link: link_b, session_id: 'a', created_at: Time.utc(2017, 10, 1, 0))
    create(:click, link: link_b, session_id: 'a', created_at: Time.utc(2017, 10, 1, 0, 10))

    result_b = Link::Stat.run(id: link_b.code)

    expected_b = [
      { 'date': { 'year': 2017, 'month': 10, 'day': 1, 'hour': 0 }, 'count': 1 },
    ]
    expect(result_b.to_json).to eq expected_b.to_json
  end
end
