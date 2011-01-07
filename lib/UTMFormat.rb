
=begin

UTMFormat

Class providing a factory method to supply formating variables of different UTM encoding schemes.

=end


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
