require 'user_agent_parser'

# Parses the user_agent and assign relevant attributes
# to the given Click document
class Click::BuildFromUserAgent < Operation
  OTHER = 'Other'.freeze

  def run(click: Click.new, user_agent:)
    throw 'click must not be nil' if click.nil?
    ua = UserAgentParser.parse user_agent

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
    click
  end
end
