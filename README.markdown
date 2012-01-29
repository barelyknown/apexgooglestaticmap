Introduction
============

GoogleStaticMap.cls makes it easy to interact with the [Google Static Map API v2](http://code.google.com/apis/maps/documentation/staticmaps/) from a Force.com application. The class is self contained with no external dependencies.


`
String[] afcEastCities = new String[]{'Boston, MA','New York, NY','Buffalo, NY','Miami,FL'};
String afcEastMapUrl = new GoogleStaticMap().addMarkers(afcEastCities).url;
`