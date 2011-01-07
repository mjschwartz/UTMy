
$LOAD_PATH.unshift File.expand_path(File.join(File.dirname(__FILE__), "..", "lib/formats"))

require "UTMFormat"
require "test/unit"
 
class TestUTMtoLatLng < Test::Unit::TestCase
 
  #converting to_s in order to test
  #covering for Ruby < 1.9 round()


  def test_nad27_format
    test = UTMFormat.factory :nad27
    assert_equal('0.0822718542230039', test.e.to_s )
  end


  def test_nad83_format
    test = UTMFormat.factory :nad83
    assert_equal('0.081819191', test.e.to_s )
  end


end

