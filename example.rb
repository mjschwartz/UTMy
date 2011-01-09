


require 'UTMtoLatLng'
require 'UTMFormat'



# Create a formating object that matches your encoding through the 
# UTMFormat factory method
format = UTMFormat.factory(:nad27)

# Create a new UTMtoLatLng object 

point = UTMtoLatLng.new(13, false, 543710, 4114220, format)
puts point.lat
puts point.lng
