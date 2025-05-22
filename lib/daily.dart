// daily.dart
// Barrett Koster 2025


import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";

import "food_state.dart";

// the Daily layer passed the FoodCubit to this page.
class Daily extends StatelessWidget
{
  final BuildContext bc;
  Daily( this.bc );

  Widget build( BuildContext context )
  { FoodCubit fc = BlocProvider.of<FoodCubit>(bc);
    // return Text("1 day's food goes here");
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

class Daily2 extends StatelessWidget
{
  Widget build( BuildContext context )
  { return Scaffold
    ( appBar: AppBar( title: Text("food entry page - date") ) ,
      body: Column
      ( children:
        [ Text("container with list of foods"),
          Text("bar with 'food' 'feel', 'action' "),
          Text("foods or feelings ... you can add"),
        ],
      ),
    );
  }
}

/*

class Core extends StatelessWidget 
{ final String title;
  // final FDCubit fdc;
  const Core({super.key, required this.title } );

  @override
  Widget build(BuildContext context) 
  { FoodCubit fc = BlocProvider.of<FoodCubit>(context);
    FoodState fs = fc.state;
    TextEditingController tec = TextEditingController();

    print("json=${fs.toJson()}"); // debugging

    return Scaffold
    ( appBar: AppBar(  title: Text(title),),
      body: Column
      ( children: 
        [ Container
          ( height:300, width:400,
            decoration: BoxDecoration( border:Border.all(width:1)),
            child: makeListView(context),
          ),
          SizedBox
          ( height:50, width:300,
            child: TextField(controller: tec ),
          ),
          ElevatedButton
          ( onPressed: (){ fc.addFood(tec.text); },
            child: Text("submit"),
          ),
          ResetButton(),
        ],
      ),
    );
  }     

  Widget makeListView( BuildContext context )
  { FoodCubit fc = BlocProvider.of<FoodCubit>(context);
    FoodState fs = fc.state;
    List<Munch> theList = fs.munchies;

    List<Widget> kids = [];
    for ( Munch m in theList )
    { // String t = DateTime.parse(m.when).hour.toString();
      String t = m.when;
      String label = "$t ${m.what}";
      kids.add
      ( ElevatedButton
        ( onPressed: (){},
          child:  Text( label ),
        )
      );
    }

    Wrap wr = Wrap
    ( children:kids,
    );
    ListView lv = ListView
    ( scrollDirection: Axis.vertical,
      // itemExtent: 30,
      children: [wr],
    );
    return lv;
  }
}

*/