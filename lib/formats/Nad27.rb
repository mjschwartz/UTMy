class Nad27

  attr_reader :a, :e, :e1sq, :k0

  def initialize
    @a = 6378206.4
    #b = 6356583.8 - derivatives already computed; provide for reference
    @e = 0.0822718542230039
    @e1sq = 0.00681478494591519
    @k0 = 0.9996
  end

end


