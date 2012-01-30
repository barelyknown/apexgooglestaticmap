Introduction
============

GoogleStaticMap.cls makes it easy to interact with the [Google Static Map API v2](http://code.google.com/apis/maps/documentation/staticmaps/) from a Force.com application. The class is self contained with no external dependencies.

Simple Example
--------------
If you're OK with default formatting, you can request a map with only one or two lines of code.

In your Apex controller:
```
String[] afcEastCities = new String[]{'Boston, MA','New York, NY','Buffalo, NY','Miami,FL'};
String afcEastMapUrl = new GoogleStaticMap().addMarkers(afcEastCities).url;
```

In your Visualforce Page:
```
<apex:image value="{!afcEastMapUrl}" />
```

![simpleExampleMap](http://maps.google.com/maps/api/staticmap?sensor=false&size=500x350&markers=Boston%2C+MA&markers=New+York%2C+NY&markers=Buffalo%2C+NY&markers=Miami%2CFL&)

Use Custom Icons
----------------
The formatting can be controlled at the lowest level if you need to communicate more detail or would like to implement a specific design.

In your Apex controller:
```
GoogleStaticMap.MapMarker dolphins = new GoogleStaticMap.MapMarker('Miami, FL').icon('http://goo.gl/2pFtB');
GoogleStaticMap.MapMarker bills = new GoogleStaticMap.MapMarker('Buffalo, NY').icon('http://goo.gl/7uRWT');
GoogleStaticMap.MapMarker jets = new GoogleStaticMap.MapMarker('New York, NY').icon('http://goo.gl/fRrSw');
GoogleStaticMap.MapMarker patriots = new GoogleStaticMap.MapMarker('Boston, MA').icon('http://goo.gl/ieqVq');
String afcEastMapUrl = new GoogleStaticMap().addMarkers(new GoogleStaticMap.MapMarker[]{dolphins,bills,jets,patriots}).url;
```

In your Visualforce Page:
```
<apex:image value="{!afcEastMapUrl}" />
```
![iconExample](http://maps.google.com/maps/api/staticmap?sensor=false&size=500x350&markers=icon:http://goo.gl/2pFtB%7CMiami%2C+FL&markers=icon:http://goo.gl/7uRWT%7CBuffalo%2C+NY&markers=icon:http://goo.gl/fRrSw%7CNew+York%2C+NY&markers=icon:http://goo.gl/ieqVq%7CBoston%2C+MA&)

Draw Paths
----------
Paths can also be drawn, with our without markers and with custom formatting.

In your Apex controller:
```
String[] homes = new String[]{'Albany, NY','Wellesley, MA','New York, NY','Pittsburgh, PA','01945','Ann Arbor, MI','Chicago, IL'};
GoogleStaticMap.MapPath moves = new GoogleStaticMap.MapPath(homes).color('0x000000ff');
String movesUrl = new GoogleStaticMap().addPath(moves).url;
```

In your Visualforce Page:
```
<apex:image value="{!movesUrl}">
```
![movesExample](http://maps.google.com/maps/api/staticmap?sensor=false&size=500x350&markers=label:0%7CAlbany%2C+NY&markers=label:1%7CWellesley%2C+MA&markers=label:2%7CNew+York%2C+NY&markers=label:3%7CPittsburgh%2C+PA&markers=label:4%7C01945&markers=label:5%7CAnn+Arbor%2C+MI&markers=label:6%7CChicago%2C+IL&markers=label:0%7CAlbany%2C+NY&markers=label:1%7CWellesley%2C+MA&markers=label:2%7CNew+York%2C+NY&markers=label:3%7CPittsburgh%2C+PA&markers=label:4%7C01945&markers=label:5%7CAnn+Arbor%2C+MI&markers=label:6%7CChicago%2C+IL&path=weight:5%7Ccolor:0x000000ff%7CAlbany%2C+NY%7CWellesley%2C+MA%7CNew+York%2C+NY%7CPittsburgh%2C+PA%7C01945%7CAnn+Arbor%2C+MI%7CChicago%2C+IL&)

Details
-------
The class implements the majority of the attributes enabled by the Google Static Maps API. Look at the source for details (and feel free to write up detailed documentation if I don't get to it first!).

Credit
------
This class started as a port of the [googlestaticmap](https://github.com/brentsowers1/googlestaticmap) Ruby repository by Brent Sowers. Big thanks to him for the main design and inspiration.
