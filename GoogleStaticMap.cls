public virtual class GoogleStaticMap {
  
  // DEFAULT PROPERTY VALUES
  public static final Integer DEF_WIDTH = 500;
  public static final Integer DEF_HEIGHT = 350;
  public static final Boolean DEF_SENSOR = false;
  public static final Integer DEF_SCALE = 1;
  public static final MapMarker[] DEF_MARKERS = new MapMarker[]{};
  public static final MapPath[] DEF_PATHS = new MapPath[]{};
  public static final String DEF_MAP_TYPE = 'roadmap';
  public static final String DEF_FORMAT = 'png8';
  public static final String DEF_SIZE = 'normal';
  public static final Boolean DEF_SHADOW = true;
  public static final Integer DEF_PATH_WEIGHT = 5;
  public static final MapLocation[] DEF_POINTS = new MapLocation[]{};
  public static final Boolean DEF_AUTO_INCREMENT_MARKER_LABELS = false;
  public static final Boolean DEF_MARKERS_ON_PATH = true;
  public static final Boolean DEF_AUTO_INCREMENT_MARKER_LABELS_ON_PATH = true;

  // VALID INPUT SETS
  public class GoogleStaticMapException extends Exception {}
  public static final Integer MIN_WIDTH = 1;
  public static final Integer MAX_WIDTH = 640;
  public static final Integer MIN_HEIGHT = 1;
  public static final Integer MAX_HEIGHT = 640;
  public static final Integer MAX_GEO_PRECISION = 6;
  public static final Integer MIN_PATH_WEIGHT = 1;
  public static final Integer MAX_PATH_WEIGHT = 100;
  public static final Set<Object> VALID_ZOOMS = getValidZooms();
  public static final Set<Object> VALID_SCALES = new Set<Object>{1,2,4};
  public static final Set<Object> VALID_FORMATS = new Set<Object>{'png8','png32','gif','jpg','jpg-baseline'};
  public static final Set<Object> VALID_MAP_TYPES = new Set<Object>{'roadmap','satellite','terrain','hybrid'};
  public static final Set<Object> VALID_COLORS = new Set<Object>{'black','brown','green','purple','yellow','blue','gray','orange','red','white'};
  public static final Set<Object> VALID_SIZES = new Set<Object>{'tiny','small','mid','normal'};
  
  // VALIDATION HELPER METHODS
  private static Set<Object> getValidZooms() {
    Set<Object> validZooms = new Set<Object>();
    for (Integer i = 0; i <= 21; i++) {
      validZooms.add(i);
    }
    return validZooms;
  }
  
  
  // CONSTRUCTORS
  public GoogleStaticMap() {
    
  }
  
  public GoogleStaticMap(Decimal latitude, Decimal longitude) {
    MapLocation location = new MapLocation(latitude, longitude);
    MapMarker marker = new MapMarker(location);
    this.markers.add(marker);
  }
  
  public GoogleStaticMap(String address) {
    MapLocation location = new MapLocation(address);
    MapMarker marker = new MapMarker (location);
    this.markers.add(marker);
  }
  
  public static Boolean isValidColor(String color) {
    if (GoogleStaticMap.VALID_COLORS.contains(color)) {
      return true;
    } else if (Pattern.matches('(0x([0-9A-Fa-f]{6}|[0-9A-Fa-f]{8}))',color)) {
      return true;
    }
    return false;
  }
  
  public static String toString(Set<Object> objects) {
    List<Object> sortedObjects = new List<Object>();
    sortedObjects.addAll(objects);
    sortedObjects.sort();
    String joinedString = '';
    Integer i = 0;
    for (Object obj: sortedObjects) {
      if (obj instanceof Integer) {
        joinedString += ((Integer)obj).format();
      } else if (obj instanceof String) {
        joinedString += (String)obj;
      }
      if (i != objects.size() - 1) {
        joinedString += ', ';
      }
      i++;
    }
    return joinedString;
  }

  
  // GOOGLE STATIC MAP INSTANCE METHODS AND PROPERTIES
  
  public Integer width {
    get {
      if (this.width == null) {
        return GoogleStaticMap.DEF_WIDTH;
      }
      return this.width;
    }
    set {
      if (value > GoogleStaticMap.MAX_WIDTH || value < GoogleStaticMap.MIN_WIDTH) {
        throw new GoogleStaticMapException('The width provided (' + value + ') is outside of the valid range (' + GoogleStaticMap.MIN_WIDTH + ' - ' + GoogleStaticMap.MAX_WIDTH + ').');
      }
      this.width = value;      
    }
  }
  
  public GoogleStaticMap width(Integer width) {
    this.width = width;
    return this;
  }
  
  public Integer height {
    get {
      if (this.height == null) {
        return GoogleStaticMap.DEF_HEIGHT;
      }
      return this.height;
    }
    set {
      if (value > GoogleStaticMap.MAX_HEIGHT || value < GoogleStaticMap.MIN_HEIGHT) {
        throw new GoogleStaticMapException('The height provided (' + value + ') is outside of the valid range (' + GoogleStaticMap.MIN_HEIGHT + ' - ' + GoogleStaticMap.MAX_HEIGHT + ').');
      }
      this.height = value;      
    }
  }
  
  public GoogleStaticMap height(Integer height) {
    this.height = height;
    return this;
  }
  
  public MapMarker[] markers {
    get {
      if (this.markers == null) {
        this.markers = GoogleStaticMap.DEF_MARKERS;
      }
      for (GoogleStaticMap.MapPath path: this.paths) {
        Integer p = 0;
        if (path.markersOnPath) {
          for (GoogleStaticMap.MapLocation point: path.points) {
            GoogleStaticMap.MapMarker marker = new GoogleStaticMap.MapMarker(point);
            if (path.autoIncrementMarkerLabels) {
              marker.label = Math.mod(p,10).format();
            }
            this.markers.add(marker);
            p++;
          }
        }
      }
      return this.markers;
    }
    set;
  }
  
  public GoogleStaticMap addMarker(GoogleStaticMap.MapMarker marker) {
    return addMarkers(new GoogleStaticMap.MapMarker[]{marker});
  }
  
  public GoogleStaticMap addMarker(String address) {
    return addMarkers(new GoogleStaticMap.MapMarker[]{new GoogleStaticMap.MapMarker(address)});
  }
  
  public GoogleStaticMap addMarkers(String[] addresses) {
    GoogleStaticMap.MapMarker[] markers = new GoogleStaticMap.MapMarker[]{};
    for (String address: addresses) {
      markers.add(new GoogleStaticMap.MapMarker(address));
    }
    return addMarkers(markers);
  }
  
  public GoogleStaticMap addMarkers(GoogleStaticMap.MapMarker[] markers) {
    this.markers.addAll(markers);
    return this;
  }
  
  public MapPath[] paths {
    get {
      if (this.paths == null) {
        this.paths = GoogleStaticMap.DEF_PATHS;
      }
      return this.paths;
    }
    set;
  }
  
  public GoogleStaticMap addPath(GoogleStaticMap.MapPath path) {
    return addPaths(new GoogleStaticMap.MapPath[]{path});
  }
  
  public GoogleStaticMap addPath(String[] addresses) {
    return addPaths(new GoogleStaticMap.MapPath[]{new GoogleStaticMap.MapPath(addresses)});
  }
  
  public GoogleStaticMap addPaths(GoogleStaticMap.MapPath[] paths) {
    this.paths.addAll(paths);
    return this;
  }
  
  public static GoogleStaticMap.MapLocation[] createLocations(String[] addresses) {
    MapLocation[] locations = new MapLocation[]{};
    for (String address: addresses) {
      locations.add(new MapLocation(address));
    }
    return locations;
  }
  
  public MapLocation center {
    get; set;
  }
  
  public GoogleStaticMap center(GoogleStaticMap.MapLocation center) {
    this.center = center;
    return this;
  }
  
  public Integer zoom {
    get;
    set {
      if (!GoogleStaticMap.VALID_ZOOMS.contains(value)) {
        throw new GoogleStaticMapException('The zoom (' + value + ')' + ' was not in the valid set (' + GoogleStaticMap.toString(GoogleStaticMap.VALID_ZOOMS) + ').');
      }
    }
  }
  
  public GoogleStaticMap zoom(Integer zoom) {
    this.zoom = zoom;
    return this;
  }
  
  public Boolean sensor {
    get {
      if (this.sensor == null) {
        return GoogleStaticMap.DEF_SENSOR;
      }
      return this.sensor;
    }
    set;
  }
  
  public GoogleStaticMap sensor(Boolean sensor) {
    this.sensor = sensor;
    return this;
  }
  
  public Integer scale {
    get {
      if (this.scale == null) {
        return GoogleStaticMap.DEF_SCALE;
      }
      return this.scale;
    }
    set {
      if (!GoogleStaticMap.VALID_SCALES.contains(value)) {
        throw new GoogleStaticMapException('The scale (' + value + ') was not in the valid set (' + GoogleStaticMap.toString(GoogleStaticMap.VALID_SCALES) + ').');
      }
      this.scale = value;
    }
  }
  
  public GoogleStaticMap scale(Integer scale) {
    this.scale = scale;
    return this;
  }
  
  public String format {
    get {
      if (this.format == null) {
        return GoogleStaticMap.DEF_FORMAT;
      }
      return this.format;
    }
    set {
      if (!GoogleStaticMap.VALID_FORMATS.contains(value)) {
        throw new GoogleStaticMapException('The format (' + value + ') was not in the valid set (' + GoogleStaticMap.toString(GoogleStaticMap.VALID_FORMATS) + ').');
      }
      this.format = value;
    }
  }
  
  public GoogleStaticMap format(String format) {
    this.format = format;
    return this;
  }
  
  public String mapType {
    get {
      if (this.mapType == null) {
        return GoogleStaticMap.DEF_MAP_TYPE;
      }
      return this.mapType;
    }
    set {
      if (!GoogleStaticMap.VALID_MAP_TYPES.contains(value)) {
        throw new GoogleStaticMapException('The mapType (' + value + ') was not in the valid set (' + GoogleStaticMap.toString(GoogleStaticMap.VALID_MAP_TYPES) + ').');
      }
      this.mapType = value;
    }
  }
  
  public GoogleStaticMap mapType(String mapType) {
    this.mapType = mapType;
    return this;
  }
  
  public Boolean autoIncrementMarkerLabels {
    get {
      if (this.autoIncrementMarkerLabels == null) {
        return GoogleStaticMap.DEF_AUTO_INCREMENT_MARKER_LABELS;
      }
      return this.autoIncrementMarkerLabels;
    }
    set;
  }
  
  public GoogleStaticMap autoIncrementMarkerLabels(Boolean autoIncrementMarkerLabels) {
    this.autoIncrementMarkerLabels = autoIncrementMarkerLabels;
    return this;
  }
  
  public GoogleStaticMap autoIncrementMarkerLabels() {
    this.autoIncrementMarkerLabels = true;
    return this;
  }
  
  public static String[] capitalLetters {
    get {
      String[] capitalLetters = new String[]{'A','B','C','D','E','F','G','H','I','J','K','L','M','N','O','P','Q','R','S','T','U','V','W','X','Y','Z'};
      return capitalLetters;
    }
  }
  
  public Map<String, String> getAttributeMap() {
    Map<String, String> attributeMap = new Map<String, String>();
    if (this.zoom != null) {
      attributeMap.put('zoom',this.zoom.format());
    }
    if (this.sensor != null) {
      if (this.sensor) {
        attributeMap.put('sensor','true');
      } else {
        attributeMap.put('sensor','false');
      }
    }
    if (this.scale != null && this.scale != GoogleStaticMap.DEF_SCALE) {
      attributeMap.put('scale',this.scale.format());
    }
    if (this.format != null && this.format != GoogleStaticMap.DEF_FORMAT) {
      attributeMap.put('format',this.format);
    }
    if (this.mapType != null && this.mapType != GoogleStaticMap.DEF_MAP_TYPE) {
      attributeMap.put('maptype',this.maptype);
    }
    if (this.width != null && this.height != null) {
      attributeMap.put('size',this.width.format() + 'x' + this.height.format());
    }
    return attributeMap;
  }
  
  public String url {
    get {
      if (!(this.center != null || this.markers.size() > 0 || this.paths.size() > 0)) {
        throw new GoogleStaticMapException('Need to specify either a center, markers or a path.');
      }
      String u = 'http://maps.google.com/maps/api/staticmap?';
      Map<String, String> attributeMap = getAttributeMap();
      for (String attributeKey: attributeMap.keySet()) {
        u += attributeKey + '=' + attributeMap.get(attributeKey) + '&';
      }
      List<String> markersAndPaths = new List<String>();
      Integer m = 0;
      for (GoogleStaticMap.MapMarker marker: this.markers) {
        if (this.autoIncrementMarkerLabels && (marker.size == 'mid' || marker.size == 'normal') && marker.label == null) {
          marker.label = GoogleStaticMap.capitalLetters[Math.mod(m,GoogleStaticMap.capitalLetters.size() - 1)];
        }
        markersAndPaths.add('markers=' + marker.toString);
        m++;
      }        
      for (GoogleStaticMap.MapPath path: this.paths) {
        markersAndPaths.add('path=' + path.toString);
      }
      if (this.center != null) {
        markersAndPaths.add('center=' + center.toString);
      }
      Integer i = 0;
      for (String markerOrPath: markersAndPaths) {
        u += markerOrPath;
        if (i != markersAndPaths.size() - 1) {
          u += '&';
        }
      }
      return u;
    }
  }
  
  
  // CHILD CLASSES
  
  public class MapLocation {
    
    public MapLocation(Decimal latitude, Decimal longitude) {
      this.latitude = latitude;
      this.longitude = longitude;
    }
    
    public MapLocation(String address) {
      this.address = address;
    }
    
    
    public MapLocation() {
      
    }
    
    public Decimal latitude {
      get {
        if (this.latitude != null) {
          return this.latitude.setScale(GoogleStaticMap.MAX_GEO_PRECISION).stripTrailingZeros();
        }
        return this.latitude;
      }
      set;
    }
    
    public MapLocation latitude(Decimal latitude) {
      this.latitude = latitude;
      return this;
    }
    
    public Decimal longitude {
      get {
        if (this.longitude != null) {
          return this.longitude.setScale(GoogleStaticMap.MAX_GEO_PRECISION).stripTrailingZeros();
        }
        return this.longitude;
      }
      set;
    }
    
    public MapLocation longitude(Decimal longitude) {
      this.longitude = longitude;
      return this;
    }
    
    public String address {
      get; set;
    }
    
    public MapLocation address(String address) {
      this.address = address;
      return this;
    }
    
    public String toString {
      get {
        String locationString;
        if (latitude != null && longitude != null) {
          locationString = latitude.format() + ',' + longitude.format();
        } else if (address != null) {
          locationString = EncodingUtil.urlEncode(address,'ascii');
        } else {
          throw new GoogleStaticMapException('Need to set either latitude and longitude, or address.');
        }
        return locationString;
      }
    }
    
  }
  
  public class MapMarker {
    
    public MapMarker(GoogleStaticMap.MapLocation location) {
      this.location = location;
    }
    
    public MapMarker(String address) {
      this(new GoogleStaticMap.MapLocation(address));
    }
    
    public MapMarker(Decimal latitude, Decimal longitude) {
      this(new GoogleStaticMap.MapLocation(latitude, longitude));
    }
    
    public MapMarker() {
      
    }
    
    public String color {
      get;
      set {
        if (!GoogleStaticMap.isValidColor(value)) {
          throw new GoogleStaticMapException('The color (' + value + ') was not in the valid set (' + GoogleStaticMap.toString(GoogleStaticMap.VALID_COLORS) + ') or was not a valid 24 bit hex color.');
        }
        this.color = value;
      }
    }
    
    public MapMarker color(String color) {
      this.color = color;
      return this;
    }
    
    public GoogleStaticMap.MapLocation location {
      get; set;
    }
    
    public String size {
      get {
        if (this.size == null) {
          return GoogleStaticMap.DEF_SIZE;
        }
        return this.size;
      }
      set {
        if (!GoogleStaticMap.VALID_SIZES.contains(value)) {
          throw new GoogleStaticMapException('The size (' + value + ') was not in the valid set (' + GoogleStaticMap.toString(GoogleStaticMap.VALID_SIZES) + ').');
        }
        this.size = value;
      }
    }
    
    public MapMarker size(String size) {
      this.size = size;
      return this;
    }
    
    public String label {
      get;
      set {
        if (!Pattern.matches('[0-9A-Z]{1}',value)) {
          throw new GoogleStaticMapException('The label (' + value + ') was not a single upper case letter or number.');
        } else if (!(this.size == 'normal' || this.size == 'mid')) {
          throw new GoogleStaticMapException('The label (' + value + ') can only be set if the size of the marker is mid or normal.');
        }
        this.label = value;
      }
    }
    
    public MapMarker label(String label) {
      this.label = label;
      return this;
    }
    
    public String icon {
      get; set;
    }
    
    public MapMarker icon(String icon) {
      this.icon = icon;
      return this;
    }
    
    public Boolean shadow {
      get {
        if (this.shadow == null) {
          return GoogleStaticMap.DEF_SHADOW;
        }
        return this.shadow;
      }
      set;
    }
    
    public MapMarker shadow(Boolean shadow) {
      this.shadow = shadow;
      return this;
    }
    
    public Map<String,String> getAttributeMap() {
      Map<String, String> attributeMap = new Map<String, String>();
      if (this.color != null) {
        attributeMap.put('color',EncodingUtil.urlEncode(this.color,'ascii'));
      }
      if (this.size != null && this.size != GoogleStaticMap.DEF_SIZE) {
        attributeMap.put('size',EncodingUtil.urlEncode(this.size,'ascii'));
      }
      if (this.label != null) {
        attributeMap.put('label',EncodingUtil.urlEncode(this.label,'ascii'));
      }
      if (this.icon != null) {
        attributeMap.put('icon',this.icon);
      }
      if (this.shadow != null && this.shadow != GoogleStaticMap.DEF_SHADOW) {
        String shadowString;
        if (this.shadow) {
          shadowString = 'true';
        } else {
          shadowString = 'false';
        }
        attributeMap.put('shadow',EncodingUtil.urlEncode(shadowString,'ascii'));
      }
      return attributeMap;
    }
    
    public String toString {
      get {
        if (location == null) {
          throw new GoogleStaticMapException('Need a location for the marker.');
        }
        Map<String, String> attributeMap = getAttributeMap();
        String markerString = '';
        for (String attributeKey: attributeMap.keySet()) {
          markerString += attributeKey + ':' + attributeMap.get(attributeKey) + '%7C';
        }
        markerString += this.location.toString;
        return markerString;        
      }
    }
    
  }
  
  public virtual class MapPath {
    
    public MapPath() {
      
    }
    
    public MapPath(String[] addresses) {
      this(GoogleStaticMap.createLocations(addresses));
    }
    
    public MapPath(GoogleStaticMap.MapLocation[] points) {
      this.points = points;
    }
    
    public Integer weight {
      get {
        if (this.weight == null) {
          return GoogleStaticMap.DEF_PATH_WEIGHT;
        }
        return this.weight;
      }
      set {
        if (value < GoogleStaticMap.MIN_PATH_WEIGHT || value > GoogleStaticMap.MAX_PATH_WEIGHT) {
          throw new GoogleStaticMapException('The value ( ' + value + ') was outside of the valid range (' + GoogleStaticMap.MIN_PATH_WEIGHT + ' to ' + GoogleStaticMap.MAX_PATH_WEIGHT + ').');
        }
        this.weight = value;
      }
    }
    
    public MapPath weight(Integer weight) {
      this.weight = weight;
      return this;
    }
    
    public String color {
      get;
      set {
        if (!GoogleStaticMap.isValidColor(value)) {
          throw new GoogleStaticMapException('The color (' + value + ') was not in the valid set (' + GoogleStaticMap.toString(GoogleStaticMap.VALID_COLORS) + ') or was not a valid 24 bit hex color.');
        }
        this.color = value;
      }      
    }
    
    public MapPath color (String color) {
      this.color = color;
      return this;
    }
    
    public GoogleStaticMap.MapLocation[] points {
      get {
        if (this.points == null) {
          return GoogleStaticMap.DEF_POINTS;
        }
        return this.points;
      }
      set;
    }
    
    public MapPath addPoint(GoogleStaticMap.MapLocation point) {
      this.points.add(point);
      return this;
    }
    
    public MapPath addPoints(GoogleStaticMap.MapLocation[] points) {
      this.points.addAll(points);
      return this;
    }
    
    public Boolean markersOnPath {
      get {
        if (this.markersOnPath == null) {
          return GoogleStaticMap.DEF_MARKERS_ON_PATH;
        }
        return this.markersOnPath;
      }
      set;
    }
    
    public MapPath markersOnPath(Boolean markersOnPath) {
      this.markersOnPath = markersOnPath;
      return this;
    }
    
    public Boolean autoIncrementMarkerLabels {
      get {
        if (this.autoIncrementMarkerLabels == null) {
          this.autoIncrementMarkerLabels = GoogleStaticMap.DEF_AUTO_INCREMENT_MARKER_LABELS_ON_PATH;
        }
        return this.autoIncrementMarkerLabels;
      }
      set;
    }
    
    public MapPath autoIncrementMarkerLabels(Boolean autoIncrementMarkerLabels) {
      this.autoIncrementMarkerLabels = autoIncrementMarkerLabels;
      return this;
    }
    
    public Map<String, String> getAttributeMap() {
      Map<String, String> attributeMap = new Map<String, String>();
      if (this.weight != null) {
        attributeMap.put('weight',this.weight.format());
      }
      if (this.color != null) {
        attributeMap.put('color',EncodingUtil.urlEncode(this.color,'ascii'));
      }
      return attributeMap;
    }
    
    public String toString {
      get {
        if (this.points.size() < 2) {
          throw new GoogleStaticMapException('Need more than one point for the path.');
        }
        Map<String, String> attributeMap = getAttributeMap();
        String pathString = '';
        for (String attributeKey: attributeMap.keySet()) {
          pathString += attributeKey + ':' + attributeMap.get(attributeKey) + '%7C';
        }
        Integer i = 0;
        for (GoogleStaticMap.MapLocation point: this.points) {
          pathString += point.toString;
          if (i != this.points.size() - 1) {
            pathString += '%7C';
          }
          i++;
        }
        return pathString;
      }
    }
    
  }
  
  public class MapPolygon extends MapPath {
    
    public String fillColor {
      get;
      set {
        if (!GoogleStaticMap.isValidColor(value)) {
          throw new GoogleStaticMapException('The color (' + value + ') was not in the valid set (' + GoogleStaticMap.toString(GoogleStaticMap.VALID_COLORS) + ') or was not a valid 24 bit hex color.');
        }
        this.fillColor = value;
      }      
    }
    
    public MapPolygon fillColor(String fillColor) {
      this.fillColor = fillColor;
      return this;
    }
  }


}