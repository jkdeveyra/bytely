module ApiHelpers
  def json_response
    JSON.parse(response.body)
  end

  def server_url
    'http://www.example.com'
  end
end
