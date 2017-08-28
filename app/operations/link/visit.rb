require 'user_agent_parser'

OTHER = 'Other'.freeze

class Link::Visit < Operation
  def run(params, request)
    link = params[:code].present? ? Link.where(code: params[:code]).first : nil
    if link
      request.session.destroy unless request.session.loaded? # Forces to create a new session

      ua = UserAgentParser.parse request.user_agent
      click = Click.new(
         link_code: link.code,
        ip_address: request.remote_ip,
        session_id: request.session.id
      )

      click.referer = request.referer if request.referer.present?

      if ua.family != OTHER
        click.browser = ua.family
        click.version_major = ua.version.major
        click.version_minor = ua.version.minor
      end

      if ua.os.family != OTHER
        click.os_family = ua.os.family
        click.os_version = ua.os.version if ua&.os&.respond_to?(:version) && ua&.os&.version
      end

      if ua.device.family != OTHER
        click.device_family = ua.device.family
        click.device_brand = ua.device.brand if ua&.device&.respond_to?(:brand) && ua.device.brand.present?
        click.device_model = ua.device.model if ua&.device&.respond_to?(:model) && ua.device.model.present?
      end

      link.clicks << click
    end

    OpenStruct.new(
      success?: link.present?,
      link: link
    )
  end
end
