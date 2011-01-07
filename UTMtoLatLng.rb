=begin

Copyright (C) <year> by <copyright holders>

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.

=end

class UTMtoLatLng

  attr_accessor :latitude, :longitude

  def initialize(zone, latZone, easting, northing, datum)
    @easting = easting.to_f
    @northing = northing.to_f
    @zone = zone
    @northern_hemisphere = determine_hemisphere(latZone)
    if datum == 'NAD27'
      self.set_nad27
      #default to nad83
    else
      self.set_nad83
    end
    self.utmToLatLng
  end

  def lat
    @latitude
  end

  def lng
    @longitude
  end

  def set_nad83
    @a = 6378137
    # b = 6356752.3142 - derivatives already computed; provide for reference
    @e = 0.081819191
    @e1sq = 0.006739497
    @k0 = 0.9996
  end

  def set_nad27
    @a = 6378206.4
    #b = 6356583.8 - derivatives already computed; provide for reference
    @e = 0.0822718542230039
    @e1sq = 0.00681478494591519
    @k0 = 0.9996
    # NAD27 lacks a char specifier for zone and 
    # is specific to North America
    @northern_hemisphere = true
  end

  def determine_hemisphere(latZone)
    if !latZone 
      return true
    end

    "NPQRSTUVWXZ".include?(latZone)
  end


  def utmToLatLng()
    if !@northern_hemisphere
      @northing = 10000000 - @northing
    end
    
    arc = @northing / @k0
    mu = arc / (@a * (1 - (@e** 2) / 4.0 - 3 * (@e**4) / 64.0 - 5 * (@e**6) / 256.0))
    
    ei = (1 - (1 - @e * @e)**(1.0 / 2.0)) / (1 + (1 - @e * @e)**(1 / 2.0))
    
    ca = 3 * ei / 2 - 27 * (ei**3) / 32.0

    cb = 21 * (ei**2) / 16 - 55 * ei**4 / 32
    cc = 151 * (ei**3) / 96
    cd = 1097 * (ei**4) / 512
    phi1 = mu + ca * Math.sin(2 * mu) + cb * Math.sin(4 * mu) + cc * Math.sin(6 * mu) + cd * Math.sin(8 * mu)
    
    n0 = @a / ( (1 - ( (@e * Math.sin(phi1) )**2))**(1 / 2.0) )
    
    r0 = @a * (1 - @e * @e) / ( 1 - ((@e * Math.sin(phi1))**2) )**(3.0 / 2.0)
    
    fact1 = n0 * Math.tan(phi1) / r0
    
    _a1 = 500000 - @easting
    dd0 = _a1 / (n0 * @k0)
    fact2 = dd0 * dd0 / 2
    
    t0 = Math.tan(phi1)**2
    _Q0 = @e1sq * (Math.cos(phi1)**2)
    fact3 = (5 + 3 * t0 + 10 * _Q0 - 4 * _Q0 * _Q0 - 9 * @e1sq) * (dd0**4) / 24
    
    fact4 = (61 + 90 * t0 + 298 * _Q0 + 45 * t0 * t0 - 252 * @e1sq - 3 * _Q0 * _Q0) * (dd0**6) / 720
    
    lof1 = _a1 / (n0 * @k0)
    lof2 = (1 + 2 * t0 + _Q0) * (dd0**3) / 6.0
    lof3 = (5 - 2 * _Q0 + 28 * t0 - 3 * (_Q0**2) + 8 * @e1sq + 24 * (t0**2)) * (dd0**5) / 120
    _a2 = (lof1 - lof2 + lof3) / Math.cos(phi1)
    _a3 = _a2 * 180 / Math::PI
    
    self.latitude = 180 * (phi1 - fact1 * (fact2 + fact3 + fact4)) / Math::PI
    
    if !@northern_hemisphere
      self.latitude = -latitude
    end
    self.longitude = ((@zone > 0) and (6 * @zone - 183.0) or 3.0) - _a3

  end

end

