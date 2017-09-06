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
    expect(result_a.to_json).to eq [
      { 'date': { 'year': 2017, 'month': 9, 'day': 1, 'hour': 0 }, 'count': 2 },
      { 'date': { 'year': 2017, 'month': 9, 'day': 1, 'hour': 1 }, 'count': 1 }
    ].to_json

    result_b = Link::Stat.run(id: link_b.code)
    expect(result_b.to_json).to eq [
      { 'date': { 'year': 2017, 'month': 10, 'day': 1, 'hour': 0 }, 'count': 1 },
    ].to_json
  end

  it 'counts unique clicks by session id' do
    link = create(:link)
    create(:click, link: link, session_id: 'a', created_at: Time.utc(2017, 10, 1, 0))
    create(:click, link: link, session_id: 'a', created_at: Time.utc(2017, 10, 1, 0, 10))

    result = Link::Stat.run(id: link.code)
    expect(result.to_json).to eq [
      { 'date': { 'year': 2017, 'month': 10, 'day': 1, 'hour': 0 }, 'count': 1 },
    ].to_json
  end

  it 'can return filtered hourly stat by date' do
    link = create(:link)
    create(:click, link: link, created_at: Time.utc(2017, 9, 1, 23))
    create(:click, link: link, created_at: Time.utc(2017, 9, 2, 0))
    create(:click, link: link, created_at: Time.utc(2017, 9, 2, 0, 59))
    create(:click, link: link, created_at: Time.utc(2017, 9, 2, 1))
    create(:click, link: link, created_at: Time.utc(2017, 9, 3, 23))
    create(:click, link: link, created_at: Time.utc(2017, 9, 4, 0))

    result = Link::Stat.run(
      id: link.code,
      from: '2017-9-2',
      to: '2017-9-3'
    )

    expect(result.to_json).to eq [
      { 'date': { 'year': 2017, 'month': 9, 'day': 2, 'hour': 0 }, 'count': 2 },
      { 'date': { 'year': 2017, 'month': 9, 'day': 2, 'hour': 1 }, 'count': 1 },
      { 'date': { 'year': 2017, 'month': 9, 'day': 3, 'hour': 23 }, 'count': 1 },
    ].to_json
  end

  it 'returns paginated hourly stat' do
    link = create(:link)
    create_list(:click, 31, link: link)

    result = Link::Stat.run(id: link.code, after: 0)
    expect(result.count).to eq 30

    result_b = Link::Stat.run(id: link.code, after: 29) # 29 is the 30th item
    expect(result_b.count).to eq 1
  end
end
