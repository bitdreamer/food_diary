// munch.dart
// Barrett Koster 2025
// This is for ONE item, something you ate or did or felt,
// and when that happened.

// import "package:flutter/material.dart";

// import 'dart:convert';

class Munch 
{
  String what; // name of the food or feeling or action
  String when; // date+time stored as string in DateTime.toString() format,
               // Just for now?
  double much;
  // DateTime when;

  Munch( this.what, this.when, this.much );
  // Munch( this.what, String whenString )
  // : when = DateTime.parse(whenString);

  String show()
  { List<String> t = when.split(" ")[1].split(":"); // time as a list h,m,s
    String hm = "${t[0]}"; // just show the hour
    return "$hm $what ";
  }

  // returns a Map containing the information of this object
  Map<String,dynamic> toMap()
  { // print("Munch.toMap: called on $what");
    Map<String,dynamic> theMap = {};
    theMap['what'] = what;
    theMap['when'] = when;
    theMap['much'] = much;
    return theMap;
  }

  // returns an object made from the Map
  factory Munch.fromMap( Map<String,dynamic> theMap )
  { // print("Munch.fromMap called on ${theMap['what']}");
    String what = theMap['what'];
    String when = theMap['when'];
    double much = theMap['much'];
    return Munch(what,when,much);
  }
  
/* These do not seem to be needed.
  // turns the object into JSON.  Does this by 
  // call toMap and then encode() ing the map.
  String toJson() =>json.encode(toMap());

  // turns Json back into an object.  
  factory Munch.fromJson( String source) 
  => Munch.fromMap( json.decode(source) );
*/
}

