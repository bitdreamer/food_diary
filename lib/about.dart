

// About holds details about a food, action, feeling, or happening.
// We do not actually store the name of the thing, because this is
// used in a map (where that name gets you here).
class About
{
  // String what;
  String cat; // 'ate','did','felt','hap'
  double much; // default quantity for this thing
  String units; // Kg, ml, count, 0-10 .... 

  About( this.cat, this.much, this.units );

  // returns a Map containing the information of this object
  Map<String,dynamic> toMap()
  { Map<String,dynamic> theMap = {};
    theMap['cat'] = cat;
    theMap['much'] = much;
    theMap['units'] = units;
    return theMap;
  }

  // returns an object made from the Map
  factory About.fromMap( Map<String,dynamic> theMap )
  { // print("Munch.fromMap called on ${theMap['what']}");
    String cat = theMap['cat'];
    double much = theMap['much'];
    String units = theMap['units'];
    return About(cat,much,units);
  }
  
}