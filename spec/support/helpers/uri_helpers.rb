def server_host_and_port
  "#{page.server.host}:#{page.server.port}"
end

def server_url
  "http://#{server_host_and_port}"
end
