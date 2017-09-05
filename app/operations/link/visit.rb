# Service to look for the link object and return the link from the shortened code.
# Asynchronously creates a Click to track user information from request.
class Link::Visit < Operation
  def run(params, request)
    link = params[:code].present? ? Link.where(code: params[:code]).first : nil
    Click::Create.async_run(link: link, request: request) if link

    result = OpenStruct.new success?: link.present?
    result.url = link.url if link.present?
    result
  end
end
