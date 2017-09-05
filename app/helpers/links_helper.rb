module LinksHelper
  def link_shorten_path(link, full: true)
    return nil if link.nil?
    "#{link_shorten_prepend(full: full)}#{link.code}"
  end

  def link_shorten_prepend(full: true)
    full ? root_url : "#{request.host}:#{request.port}/"
  end
end
