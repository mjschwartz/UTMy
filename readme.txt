UTM-y

A library of ruby classes to assist handling geodata encoded in the Universal Transverse Mercator (UTM) system.  As UTM data is a grid-based system, different data sets can vary wildly depending on which paticular model of the earth was used to generate the grid.

NAD 27 and NAD 83 are two UTM formats commonly used in North America.  Much of the published USGS data is wrapped in these contianers.


UTMtoLatLng.rb is a class that computes a standard latitude and longitude from UTM data.  It supports both NAD 27 and NAD 83 formatted input.

Usage:

To convert a NAD 83 encoded geopoint:

UTMtoLatLng.new(LatitudeZone, ZoneLetter, easting, northing, format)

test = UTMtoLatLng.new(34, 'G', 683473, 4942631, 'NAD83')
test.lat # -45.6455755128126
test.lng # 23.3544905255577
test.lat.class # Float
test.lng.class # Float

As NAD 27 is specific to North America there is typically not a zone letter required.  Simply pass a false value for the zone letter in your constructor.

test = UTMtoLatLng.new(13, false, 543710, 4114220, 'NAD27')
test.lat # 23.4577922405194
test.lng # -104.507625861921


Attributions:

Much of the math to convert NAD 83 (read: the hard part) comes from Sami Salkosuo's excellent article on the IBM website at http://www.ibm.com/developerworks/java/library/j-coordconvert/

Other Reading:

To save you the Googling:
http://www.colorado.edu/geography/gcraft/notes/datum/gif/molodens.gif
http://www.uwgb.edu/dutchs/usefuldata/utmformulas.htm
http://en.wikipedia.org/wiki/North_American_Datum
