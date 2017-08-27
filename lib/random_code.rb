SEQUENCE = '123456789abcdefghijkmnopqrstuvqxyxABCDEFGHJKLMNPQRSTUVWXYZ'.split('').freeze

class RandomCode
  def self.generate(n: 3)
    (0..n).map { |i| SEQUENCE.sample }.join
  end
end
