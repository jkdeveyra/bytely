describe Link::Stat do
  it 'Returns empty stat when no clicks' do
    link = create(:link)
    result = Link::Stat.run(id: link.code)
    expect(result.count).to eq 0
  end

  it 'Returns empty stat when code is invalid' do
    result = Link::Stat.run(id: 'ABCDEFG')
    expect(result.count).to eq 0
  end
end
