// daily.dart
// Barrett Koster 2025

// The tree with Daily at the top shows what you have
// eaten (or done) today (or on a chosen day) and lets you add foods
// (or events) with one touch (each).  
// We can also pick the category (food, action, event) from a menu
// and set a different date amd time.

import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";

import "../data/food_state.dart";
import "../data/show_state.dart";
import "../data/munch.dart";
import "../data/about.dart";
import "about_edit.dart";

// the Daily layer sets up the Bloc stuff with the FoodCubit
// already open from the top of the program.  
// We also start the ShowCubit layer with currently selected
// settings like date, time and what category we are showing.
class Daily extends StatelessWidget
{
  final BuildContext bc;
  Daily( this.bc ); // contains the FoodCubit we need 

  Widget build( BuildContext context )
  { FoodCubit fc = BlocProvider.of<FoodCubit>(bc);
    return BlocProvider<FoodCubit>.value
    ( value: fc,
      child: BlocBuilder<FoodCubit,FoodState>
      ( builder: (context,state) => 
        BlocProvider<ShowCubit>
        ( create: (context) => ShowCubit(),
          child: BlocBuilder<ShowCubit,ShowState>
          ( builder: (context, state) =>Daily2(), ),
        ),
      ),
    );
  }
}

// This is the data entry page.
class Daily2 extends StatelessWidget 
{ // final String title = "Daily - ${DateTime.now().toString().split(" ")[0]}";
  Daily2( {super.key} );

  @override
  Widget build(BuildContext context) 
  { FoodCubit fc = BlocProvider.of<FoodCubit>(context);
    FoodState fs = fc.state;
    TextEditingController tec = TextEditingController();
    String cat = "ate";

    // print("json=${fs.toJson()}"); // debugging
    // get the date out of ShowState
    ShowCubit sc = BlocProvider.of<ShowCubit>(context);
    ShowState ss = sc.state;
    String dt = ss.datetime;
    String date = dt.split(" ")[0];

    return Scaffold
    ( appBar: AppBar(  title: Text("Daily = $date"),),
      body: Column
      ( children: 
        [ dayLog(context), // today so far
          EntryRow(),
          ItemChoices(),
        ],
      ),
    );
  }  

  // returns a widget (container) that has all of the foods
  // you ate or stuff you felt etc..  
  Widget dayLog( BuildContext context )
  { FoodCubit fc = BlocProvider.of<FoodCubit>(context);
    FoodState fs = fc.state;
    ShowCubit sc = BlocProvider.of<ShowCubit>(context);
    ShowState ss = sc.state;
    String dt = ss.datetime;
    String date = dt.split(" ")[0];
    List<Munch> theList = fs.munchies;

    List<Widget> kids = [];
    for ( Munch m in theList )
    { if ( m.when.split(" ")[0] == date )
      { String thisCat="no cat";
        About? aboutM = fs.abouts[m.what];
        if ( aboutM != null ) { thisCat = aboutM.cat; }
        if ( thisCat == ss.cat )
        { kids.add( aboutEditButton(context,m)); }
      }
    }
    return   Wrap ( children: kids, ) ;
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
    ShowCubit sc = BlocProvider.of<ShowCubit>(context);
    ShowState ss = sc.state;
    String cat = ss.cat; // "ate"; // ate, did,exp  
    String dt = ss.datetime; // DateTime.now().toString();

    return Container
    ( decoration: BoxDecoration
      ( border: Border.all(width:1),color: Colors.yellow,
      ),
      child: Row
      ( children:
        [ CatMenu(),
          SizedBox
          ( height:40, width:200,
            child: TextField(controller: tec ),
          ),
          // Text("now"), // to do: make a menu of previous hours
          hoursMenu(context),
          ElevatedButton
          ( onPressed: (){ fc.addFood(tec.text,cat,dt); }, // to do: add cat, date
            child: Text("add"),
          ),
        ],
      )
    );
  }
  
  Widget hoursMenu( BuildContext context )
  { ShowCubit sc = BlocProvider.of<ShowCubit>(context);
    ShowState ss = sc.state;
    String hour = ss.getHour();
    List<DropdownMenuItem<String>> hours = [];
    for ( int i=0; i<24; i++ )
    { String ii = "$i";
      hours.add(DropdownMenuItem(value:ii,child:Text(ii)));
    }

    return DropdownButton<String>
    ( value: hour,
      items: hours,
      onChanged: (h) { sc.setHour(h!); }
    );
  }
}
  // each 'about' item is a button that goes to an edit page
  // for that item.
  Widget aboutEditButton( BuildContext context, Munch m)
  { return ElevatedButton
    ( onPressed: ()
      { Navigator.of(context).push
        ( MaterialPageRoute( builder: (_)=>AboutEdit(context, m) )
        );
      },
      child: Text(m.show()),
    );
  }


// This returns a Wrap object
// listing as buttons all of the items in the 'abouts' list 
// of the current category.  
class ItemChoices extends StatelessWidget
{
  //String cat;
  //ItemChoices(this.cat);

  Widget build( BuildContext context )
  { FoodCubit fc = BlocProvider.of<FoodCubit>(context);
    FoodState fs = fc.state;
    Map<String,About> abouts = fs.abouts;

        ShowCubit sc = BlocProvider.of<ShowCubit>(context);
    ShowState ss = sc.state;
    String cat = ss.cat; // "ate"; // ate, did,exp  
    String dt = ss.datetime; // DateTime.now().toString();

  
    List<Widget> kids = [];
    for ( MapEntry<String,About> me in abouts.entries )
    { if ( me.value.cat==cat)
      {  kids.add
        ( ElevatedButton
          ( onPressed: ()
            // { fc.addFood(me.key,cat,DateTime.now().toString()); },
            { fc.addMunch(me.key,me.value,dt); },
            child: Text(me.key),
          )
        );
      }
    }

    return Wrap( children: kids );
  }
}



class CatMenu extends StatelessWidget
{
  Widget build( BuildContext context )
  { ShowCubit sc = BlocProvider.of<ShowCubit>(context);
    ShowState ss = sc.state;
    String cat = ss.cat;

    return DropdownButton<String>
    ( value: cat, 
      items:
      [ DropdownMenuItem(value:"ate",child:Text("ate")),
        DropdownMenuItem(value:"did",child:Text("did")),
        DropdownMenuItem(value:"exp",child:Text("exp")),
      ],
      onChanged: (t) { sc.setCat( t! ); }
    );
  }
}

/*  Wing's calc code has a menu thingy ... work from this       

SizedBox(height: 20),
            DropdownButton<ConversionType>(
              value: selectedType,
              items: ConversionType.values.map((type) {
                return DropdownMenuItem(
                  value: type,
                  child: Text(type.toString().split('.').last.replaceAll('To', ' to ')),
                );
              }).toList(), 
              onChanged: (newType) {
                setState(() {
                  selectedType = newType!;
                });
              }
            ),
*/


