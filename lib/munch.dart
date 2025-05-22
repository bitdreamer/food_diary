// munch.dart
// Barrett Koster 2025
// This is for ONE item, something you ate
// and when you ate it, presumably.

// import "package:flutter/material.dart";

import 'dart:convert';

class Munch 
{
  String what; // name of the food
  String when; // date+time stored as string to not hang on format,
               // for now
  // int when;
  // DateTime when;

  Munch( this.what, this.when );
  // Munch( this.what, String whenString )
  // : when = DateTime.parse(whenString);

  // returns a Map containing the information of this object
  Map<String,dynamic> toMap()
  { // print("Munch.toMap: called on $what");
    Map<String,dynamic> theMap = {};
    theMap['what'] = what;
    theMap['when'] = when;
    return theMap;
  }

  // returns an object made from the Map
  factory Munch.fromMap( Map<String,dynamic> theMap )
  { // print("Munch.fromMap called on ${theMap['what']}");
    String what = theMap['what'];
    String when = theMap['when'];
    return Munch(what,when);
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

