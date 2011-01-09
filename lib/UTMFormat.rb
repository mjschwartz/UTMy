
=begin

UTMFormat

Class providing a factory method to supply formating variables of different UTM encoding schemes.

=end

# add current dir to loadpath
$LOAD_PATH.unshift File.expand_path(File.dirname(__FILE__))

require 'FormatNad83'
require 'FormatNad27'




class UTMFormat

  def UTMFormat.factory(type)
    formats = {
      :nad27 => FormatNad27,
      :nad83 => FormatNad83
    }

    formats[type].new
  end

end
