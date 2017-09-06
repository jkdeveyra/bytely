# Service for generating a unique shortened code used to create Link record
# Increments code length when collides more than twice
class Link::GenerateCode < Operation
  DEFAULT_MIN_LENGTH = 1.freeze
  LENGTH_RANGE = 1.freeze
  MIN_LEN_KEY = 'LINK_CODE_MIN_LENGTH'.freeze

  def run
    loop_count = 0
    loop do
      code = RandomCode.generate(min: min_len, max: min_len + LENGTH_RANGE)
      if Link.where(code: code).exists?
        loop_count += 1
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
    prop = AppProp.where(key: MIN_LEN_KEY).first_or_initialize
    prop.value = @min_len
    prop.save
  end
end
