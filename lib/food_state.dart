// food_state.dart
// Barrett Koster 2025

// Hydrated, includes JSON encoding down to contained Munch etc..
// 
import 'dart:convert';import 'package:hydrated_bloc/hydrated_bloc.dart';

import 'munch.dart';

class FoodState
{ 
  List<Munch> munchies; // time stamped eating or feeling or ...
  // Map<String,About> menu; // details about each food or feeling ...
  FoodState(this.munchies);

  // toMap()
  // turns the object into a map.
  // Note: this map is ONLY things that JSON encoder knows how to 
  // encode.  
  Map<String,dynamic> toMap() // 3
  { Map<String,dynamic> theMap = {};
    List<Map<String,dynamic>> theList = [];
    for ( Munch m in munchies )
    { theList.add( m.toMap() ); // encode map version of the Munch
    } 
    theMap["munchies"] = theList;
    return theMap;
  }

  // factory FoodState.fromMap() .... like a contructor.
  // theMap we are using now is a JSON-readable map, so just strings,
  // ints, lists and more maps.  No Munch or other objects.
   factory FoodState.fromMap( Map<String,dynamic> theMap) // 3
  { List<Munch> munchies = []; // in a factory, this becomes member
    dynamic mmaps = theMap['munchies']; // Munches coded as maps
    for ( Map<String,dynamic> mmap in mmaps )
    { munchies.add( Munch.fromMap(mmap) ); // back into Munch object
    }
    return FoodState(munchies);
  }
  
  
  // turns the object into JSON.  Does this by 
  // call toMap and then encode() ing the map.
  // Note the 'toEncodable' method.  If an item in the encoding is
  // not a standard one, it calls this function.
  // Our map is presently made of all standard things, so this
  // is not used that I know of.
  String toJson() => jsonEncode( toMap() );

  // I am not sure this EVER worked. I do not know that it is called.
  // turns Json back into an object.  
  factory FoodState.fromJson( String source) 
    => FoodState.fromMap(json.decode(source));
  
}

class FoodCubit extends HydratedCubit<FoodState> // with HydratedMixin
{
  FoodCubit() : super( FoodState([ Munch("apple", "2025-01-02 10:43:17" ),
                                   Munch("banana", "2025-01-03 8:41:00" ),
                                 ]) );

  void setFood(List<Munch> m ) { emit( FoodState(m) ); }

  void addFood( String f, String cat, String dt )
  { Munch m = Munch( f, dt  );
    state.munchies.add(m);
    emit( FoodState(state.munchies) );
  }

  void reset() { emit( FoodState([]) ); }
  
  // fromJson()
  // converts the map form of FoodState into a FoodState object.
  // Should have been called fromMap, as the Hydrated stuff
  // will have already converted it from JSON to a map.
  // Note: the map is just the regular stuff that JSON encode/decode
  // knows how to handle.  There are no Munch objects.
  @override
  FoodState fromJson( Map<String,dynamic> map)
    => FoodState.fromMap(map);
  
  // This is called on state AFTER emit(state).  Every time there is a new
  // state, this function converts it to a Map and the Hydrated
  // stuff takes it from there.  
  @override
  Map<String,dynamic> toJson( FoodState state ) => state.toMap();
  /*
   { print("----- FoodCubit.toJson: starting ...");
    Map<String,dynamic> theMap = state.toMap();
    print("FoodCubit.toJson about to return $theMap");
    return theMap;
  }
  */
  

}

/*
At one level, there's really only two kinds of things to
record, stuff that a person has control over doing, and
stuff that just happens.  It might be interesting if you
always eat banana with peanut butter, but there's not
cause and effect if both are choices.  The same goes for
two feelings -- you might get headaches and dizziness 
together all of the time, but ... that does not tell us
what to do about either, no cause and effect.  So ... 
we really need to keep causes and effects in two categories.
But.
We could have more.  Do you want scratching your ear or
exercising in the same list as foods?  Keeping these 
separate will make sense for the User Interface.
So, question.
Do we store all things in one list, and attach a category
to each record saying food or feeling (or action or ...).
Or do we create separate lists?  Programming is more efficient
if there is just one list.  That way we only need one 
edit page.  Whether it is 'banana' or 'scratch', you have
the word, a number (and maybe do not list the units here?).
And there's is a food/feeling/action/.. menu.  Oh, and the 
date, that is same for all.  We can display only type X at
a time (and provide those buttons on the row in the middle
of the entry screen, between what you have and what you add).
So far that row has 3 things on it, buttons, not a menu.  Good,
the IF will be fast.
*/