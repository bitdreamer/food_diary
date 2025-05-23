// daily.dart
// Barrett Koster 2025


import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";

import "food_state.dart";
import "show_state.dart";
import "munch.dart";
import "about.dart";

// the Daily layer sets up the Bloc stuff with the FoodCubit
// alreayd open from the top of the program.  
class Daily extends StatelessWidget
{
  final BuildContext bc;
  Daily( this.bc ); // contains the FoodCubit we need 

  Widget build( BuildContext context )
  { FoodCubit fc = BlocProvider.of<FoodCubit>(bc);
    return BlocProvider<FoodCubit>.value
    ( value: fc,
      child: BlocBuilder<FoodCubit,FoodState>
      ( builder: (context,state) => Daily2(),
// to do: add a layer with HOW to display ... date, sort criteria
// state for this is NOT hydrated
      ),
    );
  }
}

// This is the data entry page.
class Daily2 extends StatelessWidget 
{ final String title = "Daily - ${DateTime.now().toString().split(" ")[0]}";
  Daily2( {super.key} );

  @override
  Widget build(BuildContext context) 
  { FoodCubit fc = BlocProvider.of<FoodCubit>(context);
    FoodState fs = fc.state;
    TextEditingController tec = TextEditingController();
    String cat = "ate";

    // print("json=${fs.toJson()}"); // debugging

    return Scaffold
    ( appBar: AppBar(  title: Text(title),),
      body: Column
      ( children: 
        [ dayLog(context), // today so far
          EntryRow(),
          ItemChoices(cat),
        ],
      ),
    );
  }  

  Widget dayLog( BuildContext context )
  { FoodCubit fc = BlocProvider.of<FoodCubit>(context);
    FoodState fs = fc.state;
    List<Munch> theList = fs.munchies;

    List<Widget> kids = [];
    for ( Munch m in theList )
    { kids.add( Text( m.show()) ); }
    return Container
    ( height:300, width:400,
      decoration: BoxDecoration( border:Border.all(width:1)),
      child: Wrap ( children: kids, ),
    );
  }
}

class ItemChoices extends StatelessWidget
{
  String cat;
  ItemChoices(this.cat);

  Widget build( BuildContext context )
  { FoodCubit fc = BlocProvider.of<FoodCubit>(context);
    FoodState fs = fc.state;
    Map<String,About> abouts = fs.abouts;

    List<Widget> kids = [];
    for ( MapEntry<String,About> me in abouts.entries )
    { if ( me.value.cat==cat)
      {  kids.add
        ( //Text(me.key) 
          ElevatedButton
          ( onPressed: (){ fc.addFood(me.key,cat,DateTime.now().toString()); },
            child: Text(me.key),
          )
        );
      }
    }

    return Wrap( children: kids );
  }
}

class EntryRow extends StatelessWidget
{ 
  final TextEditingController tec;

  EntryRow( ) : tec = TextEditingController();

  Widget build( BuildContext context )
  { 
    FoodCubit fc = BlocProvider.of<FoodCubit>(context);
    // FoodState fs = fc.state;
    String cat = "ate"; // ate, did,felt,hap  
    String dt = DateTime.now().toString();

    return Row
    ( children:
      [ Text("ate"), // to do: menu of ate, did, felt, hap 'cat'egory
        SizedBox
        ( height:40, width:200,
          child: TextField(controller: tec ),
        ),
        Text("now"), // to do: make a menu of previous hours
        ElevatedButton
        ( onPressed: (){ fc.addFood(tec.text,cat,dt); }, // to do: add cat, date
          child: Text("add"),
        ),
      ],
    );
  }
}

