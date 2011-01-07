
=begin

UTMFormat

Class providing a factory method to supply formating variables of different UTM encoding schemes.

=end


require 'Nad83'
require 'Nad27'




class UTMFormat

  def UTMFormat.factory(type)
    formats = {
      :nad27 => Nad27,
      :nad83 => Nad83
    }

    formats[type].new
  end

end
