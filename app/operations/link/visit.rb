class Link::Visit < Operation
  def run(params, request)
    link = params[:code].present? ? Link.where(code: params[:code]).first : nil
    Click::Create.run(link: link, request: request) if link
    OpenStruct.new(
      success?: link.present?,
      link: link
    )
  end
end
