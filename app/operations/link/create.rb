class Link::Create < Operation
  def run(params)
    @params = params
    link = Link.new(link_params)
    loop do
      code = RandomCode.generate
      unless Link.where(code: code).exists?
        link.code = code
        break
      end
    end

    OpenStruct.new(
      success?: link.save,
      link: link
    )
  end

  private
  def link_params
    @params.require(:link).permit(:title, :url, :code)
  end
end
