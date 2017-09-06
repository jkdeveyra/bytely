# Creates or returns an existing Link object which represents the shortened link
#
# === Parameters
# `params` accepts the following hash:
#   link:
#     title     - Title for the URL
#     url       - Original URL to redirect to
#
# === Returns
#   result:
#     success?  - Successfully created a Link document
#     link      - Created Link document (contains the code)
#     message   - User-friendly error message
class Link::Create < Operation
  def run(params)
    set_params(params)
    url = normalize_url(link_params[:url])
    if url
      link = lookup_record(url)
      if link
        success = true
      else
        success = false
        message = 'Unable to shorten link.'
      end
    else
      success = false
      message = 'Link must be a valid web URL. (Eg. https://www.google.com, google.com)'
    end

    result = OpenStruct.new(success?: success)
    result.link = link if link
    result.message = message if message
    result
  end

  private
  def set_params(params)
    if params.is_a? Hash
      @params = ActionController::Parameters.new(params)
    elsif params.is_a? ActionController::Parameters
      @params = params
    else
      @params = ActionController::Parameters.new
    end
  end

  def link_params
    @params.require(:link).permit(:title, :url)
  end

  # Normalizes and returns the URL if valid, otherwise nil
  def normalize_url(url)
    return nil if url.nil?
    begin
      uri = Addressable::URI.heuristic_parse(url)
      uri.host.present? && /^http(s)?$/.match(uri.scheme) ? uri.to_s : nil
    rescue
      nil
    end
  end

  # Find for existing record or creates a new one
  def lookup_record(url)
    begin
      Link.where(url: url).first_or_create(
        title: link_params[:title],
        code: Link::GenerateCode.run
      )
    rescue
      nil
    end
  end
end
