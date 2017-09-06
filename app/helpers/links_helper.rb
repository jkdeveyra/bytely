module LinksHelper
  # Provide the shortened url from the given Link document
  # Include protocol (e.g "http") if full: true
  def link_shortened_path(link, full: true)
    return nil if link.nil?
    "#{site_url(full: full)}#{link.code}"
  end

  # Return the site url.
  # Include protocol (e.g "http") if full: true
  def site_url(full: true)
    full ? root_url : "#{request.host}:#{request.port}/"
  end
end
