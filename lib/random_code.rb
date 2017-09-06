# Array of 58 alphanumeric characters.
# Ambiguous characters such as 0,O,1,I and l are omitted.
SEQUENCE = '123456789abcdefghijkmnopqrstuvqxyxABCDEFGHJKLMNPQRSTUVWXYZ'.split('').freeze

class RandomCode

  # Generates a sequence of characters from a randomly selected length of the string
  def self.generate(min: 3, max: 3)
    len = min >= max ? min : (min..max).to_a.sample
    (0...len).map { |i| SEQUENCE.sample }.join
  end
end
