Introduction
============

GoogleStaticMap.cls makes it easy to interact with the [Google Static Map API v2](http://code.google.com/apis/maps/documentation/staticmaps/) from a Force.com application. The class is self contained with no external dependencies.

Simple Example
--------------
```
String[] afcEastCities = new String[]{'Boston, MA','New York, NY','Buffalo, NY','Miami,FL'};
String afcEastMapUrl = new GoogleStaticMap().addMarkers(afcEastCities).url;
<apex:image value="{!afcEastMapUrl}" />
```

[simpleExampleMap]: (http://maps.google.com/maps/api/staticmap?sensor=false&size=500x350&markers=Boston%2C+MA&markers=New+York%2C+NY&markers=Buffalo%2C+NY&markers=Miami%2CFL&)