describe Link::Create do
  it 'can create 1000 links successfully' do
    size = 1000
    (1..size).each do
      params = {
        link: {
          url: generate(:url),
          title: generate(:url_title)
        }
      }
      result = Link::Create.run(params)
      expect(result.success?).to be_truthy
      expect(result.link.persisted?).to be_truthy
      expect(result.message).to be_nil
    end
    expect(Link.count).to eq size
  end
end