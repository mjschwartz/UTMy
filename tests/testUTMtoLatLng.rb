require "../UTMtoLatLng"
require "test/unit"
 
class TestUTMtoLatLng < Test::Unit::TestCase
 
  #converting to_s in order to test
  #covering for Ruby < 1.9 round()

  def test_simple
    test = UTMtoLatLng.new(34, 'G', 683473, 4942631, 'NAD83')
    assert_equal('-45.645575', test.lat.to_s.slice(0,10) )
    assert_equal('23.3544905', test.lng.to_s.slice(0,10) )
  end

  def test_simple_27
    test = UTMtoLatLng.new(13, false, 543710, 4114220, 'NAD27')
    assert_equal('37.1752177', test.lat.to_s.slice(0,10) )
    assert_equal('-104.50762', test.lng.to_s.slice(0,10) )
  end

end

