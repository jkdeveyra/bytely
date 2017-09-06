# Service to look for the link object and return the link from the shortened code.
# Asynchronously creates a Click to track user information from request.
#
# === Parameters
#   params
#     code      - Link code use to fetch the original URL
#     request   - Rails request object use to retrieve user information
#
# === Returns
#   result:
#     success?  - Successfully fetched a valid Link object
#     url       - Original URL where the user will be redirected
class Link::Visit < Operation
  def run(params, request)
    link = params[:code].present? ? Link.where(code: params[:code]).first : nil
    Click::Create.async_run(link: link, request: request) if link

    result = OpenStruct.new(success?: link.present?)
    result.url = link.url if link.present?
    result
  end
end
