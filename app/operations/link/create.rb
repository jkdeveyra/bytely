# Creates or returns an existing Link object which represents the shorten link
# Accepted hash params: link: { title, url }
class Link::Create < Operation
  def run(params)
    set_params(params)
    begin
      link = Link.where(url: link_params[:url]).first_or_create(
        title: link_params[:title],
        code: Link::GenerateCode.run
      )
      success = true
    rescue Exception => e # e is used for debugging
      success = false
    end

    OpenStruct.new(
      success?: success,
      link: link
    )
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
end
