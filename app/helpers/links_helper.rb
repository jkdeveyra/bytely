module LinksHelper
  def link_shorten_path(link, full: true)
    if full
    "#{root_url}#{link.code}"
    else
      "#{request.host}/#{link.code}"
    end
  end
end
