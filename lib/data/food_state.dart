// food_state.dart
// Barrett Koster 2025

// Hydrated, includes JSON encoding down to contained Munch etc..
// 
import 'dart:convert';import 'package:hydrated_bloc/hydrated_bloc.dart';

import 'munch.dart';
import 'about.dart';

class FoodState
{ 
  List<Munch> munchies; // time stamped eating or feeling or ...
  // All time-stamped things are in the same list, and we filter
  // by cat and date to show "what you ate on a certain day" for example.

  Map<String,About> abouts; // details about each food or feeling ...
  // This is the list that you choose from, foods, feelings, etc..
  // We start off with some stuff, but you can add to it.
  // The string map key is the food or feeling name (.what).

  FoodState(this.munchies, this.abouts);

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

    Map<String,dynamic> aboutsMap = {};
    abouts.forEach
    ( (key,value)
      { aboutsMap[key] = value.toMap();
      }
    );
    theMap['abouts'] = aboutsMap;
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

    Map<String,dynamic> aboutsMap = theMap['abouts'];
    Map<String,About> abouts = {};
    aboutsMap.forEach
    ( (key,value)
      { abouts[key] = About.fromMap(value); }
    );
    return FoodState(munchies,abouts);
  }
  
  // These apparently need to be defined, but I do not know
  // that we call them.
  // turns the object into JSON.  Does this by 
  // call toMap and then encode() ing the map.
  String toJson() => jsonEncode( toMap() );
  // turns Json back into an object.  
  factory FoodState.fromJson( String source) 
    => FoodState.fromMap(json.decode(source));
  
}

class FoodCubit extends HydratedCubit<FoodState> // with HydratedMixin
{
  FoodCubit() : super( initFS() );

  void setFood(List<Munch> m ) { emit( FoodState(m,state.abouts) ); }

  void addFood( String f, String cat, String dt )
  { Munch m = Munch( f, dt, 5  );
    state.munchies.add(m);
    if ( state.abouts[f] == null )
    { state.abouts[f] = About(cat,5,"g"); }
    emit( FoodState(state.munchies,state.abouts) );
  }

  // add a Munch to the FoodState that has this name+about+datetime
  void addMunch( String name, About a, String dt )
  { Munch m = Munch( name, dt, a.much );
    state.munchies.add(m);
    if ( state.abouts[name] == null )
    { state.abouts[name] = About(a.cat,50,"g"); }
    emit( FoodState(state.munchies,state.abouts) );

  }

  void reset() { emit( initFS() ); }
  
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
  
  // 
  static FoodState initFS()
  {
    return FoodState
    ( [],
      { "banana":About("ate",100,"g"),
        "apple" :About("ate",200,"g"),
        "peach" :About("ate",150,"g"),
        "grapes" :About("ate",200,"g"),
        "potato" :About("ate",300,"g"),
        "orange" :About("ate",150,"g"),
        "egg"   :About("ate",100,"g"),
        "oatmeal" :About("ate",300,"g"),
        "peanuts" :About("ate",50,"g"),
        "almonds" :About("ate",50,"g"),
        "raisins" :About("ate",50,"g"),
        "walnuts" :About("ate",50,"g"),
        "yogurt" :About("ate",200,"g"),

        "steps" :About("did",7000,"count"),
        "pullups" :About("did",3,"count"),
        "pushups" :About("did",20,"count"),
        "ran" :About("did",20,"minutes"),
        "sleep":About("did",8,"hours"),

        "glucose" :About("exp",110,"dk"),
        "headache" :About("exp",4,"0-10"),
        "body temp." : About("exp",37,"C"),
        "fart" :About("exp",1,"1-3"),
        "poop" :About("exp",2,"1-3"),
        "pee" :About("exp",20,"seconds"),
      }
    ); 
  }

}

