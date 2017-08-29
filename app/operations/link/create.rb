# Creates or returns an existing Link object which represents the shorten link
# Accepted hash params:
#   { link:  {
#       title,
#       url
#   }}
class Link::Create < Operation
  DEFAULT_MIN_LENGTH = 3.freeze
  LENGTH_RANGE = 1.freeze
  MIN_LEN_KEY = 'LINK_CODE_MIN_LENGTH'.freeze

  def run(params)
    set_params(params)
    begin
      link = Link.where(url: link_params[:url]).first_or_create(
        title: link_params[:title],
        code: rand_code
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

  # Guarantees to return a unique random code.
  # Increments code length when collides more than 2 times
  def rand_code
    loop_count = 0
    loop do
      code = RandomCode.generate(min: min_len, max: min_len + LENGTH_RANGE)
      if Link.where(code: code).exists?
        loop_count++
        inc_min_len if loop_count > 1
      else
        return code
      end
    end
  end

  def min_len
    @min_len ||= AppProp.where(key: MIN_LEN_KEY).first&.value&.to_i || DEFAULT_MIN_LENGTH
  end

  def inc_min_len
    @min_len = min_len + 1
    AppProp.where(key: MIN_LEN_KEY).first_or_create(value: @min_len)
  end

  def link_params
    @params.require(:link).permit(:title, :url)
  end
end
