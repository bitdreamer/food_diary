// daily.dart
// Barrett Koster 2025


import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";

import "food_state.dart";
import "munch.dart";

// the Daily layer sets up the Bloc stuff with the FoodCubit
// from the top.  
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

class Daily2 extends StatelessWidget 
{ final String title = "Daily - [date]";
  Daily2( {super.key} );

  @override
  Widget build(BuildContext context) 
  { FoodCubit fc = BlocProvider.of<FoodCubit>(context);
    FoodState fs = fc.state;
    TextEditingController tec = TextEditingController();

    // print("json=${fs.toJson()}"); // debugging

    return Scaffold
    ( appBar: AppBar(  title: Text(title),),
      body: Column
      ( children: 
        [ dayLog(context), // today so far
          SizedBox
          ( height:50, width:300,
            child: TextField(controller: tec ),
          ),
          ElevatedButton
          ( onPressed: (){ fc.addFood(tec.text); },
            child: Text("submit"),
          ),
          // ResetButton(),
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

