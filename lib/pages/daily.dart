// daily.dart
// Barrett Koster 2025

// The tree with Daily at the top shows what you have
// eaten today (or chosen day) and lets you add foods
// with one touch (each).  
// We can also pick a few other categories from a menu
// (besides 'ate'), and set a different time.

import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";

import "../data/food_state.dart";
import "../data/show_state.dart";
import "../data/munch.dart";
import "../data/about.dart";
import "about_edit.dart";

// the Daily layer sets up the Bloc stuff with the FoodCubit
// already open from the top of the program.  
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

  // returns a widget (container) that has all of the foods
  // you ate or stuff you felt etc..  
  Widget dayLog( BuildContext context )
  { FoodCubit fc = BlocProvider.of<FoodCubit>(context);
    FoodState fs = fc.state;
    ShowCubit sc = BlocProvider.of<ShowCubit>(context);
    ShowState ss = sc.state;
    List<Munch> theList = fs.munchies;

    List<Widget> kids = [];
    for ( Munch m in theList )
    { kids.add( aboutEditButton(context,m)); }
    return Container
    ( height:300, width:400,
      decoration: BoxDecoration( border:Border.all(width:1)),
      child: Wrap ( children: kids, ),
    );
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
}

// for the given category, this 
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
          ( onPressed: ()
            // { fc.addFood(me.key,cat,DateTime.now().toString()); },
            { fc.addMunch(me.key,me.value,DateTime.now().toString()); },
// to do: the 'now' should be replaced with a reference to the time on the
// time button.  It defaults to 'now', but you should be able to set it to 
// earlier in the day or yesterday or whatever.
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
      [ // Text("ate"), // to do: menu of ate, did, exp(ienced)
        CatMenu(),
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


