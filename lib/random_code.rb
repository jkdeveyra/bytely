# Array of 58 alphanumeric characters.
# Ambiguous characters such as 0,O,1,I and l are omitted.
SEQUENCE = '123456789abcdefghijkmnopqrstuvqxyxABCDEFGHJKLMNPQRSTUVWXYZ'.split('').freeze

class RandomCode
  def self.generate(min: 3, max: 3)
    len = min >= max ? min : (min..max).to_a.sample
    (0...len).map { |i| SEQUENCE.sample }.join
  end
end
