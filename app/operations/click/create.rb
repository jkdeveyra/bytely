# Creates Click record from request and associate it with the given link
class Click::Create < Operation
  def run(link:, request:)
    return if link.nil? || request.nil?

    request.session.destroy unless request.session.loaded? # Forces to create a new session

    click = link.clicks.build
    click.link_code = link.code
    click.ip_address = request.remote_ip
    click.session_id = request.session.id
    click.referer = request.referer if request.referer.present?

    Click::BuildFromUserAgent.run(
      click: click,
      user_agent: request.user_agent
    )
    click.save!
  end
end
