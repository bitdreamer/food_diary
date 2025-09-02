// food_diary.dart 
// Barrett Koster
// 

// import "dart:io";
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';

import 'data/food_state.dart';
// import 'munch.dart';
import 'pages/daily.dart';


void main() async
{ await hydratePrep();
  runApp(const FoodDiary());
}

// the stuff that make Hydrate work.
Future<void> hydratePrep() async
{ WidgetsFlutterBinding.ensureInitialized();
  HydratedBloc.storage = await HydratedStorage.build
  (  storageDirectory: HydratedStorageDirectory
    ( (await getApplicationDocumentsDirectory()).path,),
  );
  // debugging version with print...
  // Directory addx = await getApplicationDocumentsDirectory();
  // String add = addx.path; 
  // print("add=$add");
}

// This layer establishes the HydratedCubit that holds
// all of the data.
class FoodDiary extends StatelessWidget
{ static const String header = "Food Diary";

  const FoodDiary({super.key});

  @override
  Widget build(BuildContext context) 
  { return MaterialApp
    ( title: header,
      home: BlocProvider<FoodCubit>
      ( create: (context) => FoodCubit(),
        child: BlocBuilder<FoodCubit,FoodState>
        ( builder: (context,state)
          { return Splash( header );
          },
        ),
      ),
    );
  }
}

class Splash extends StatelessWidget
{ final String title;
  Splash( this.title );
 
  Widget build( BuildContext context )
  { FoodCubit fc = BlocProvider.of<FoodCubit>(context);
    FoodState fs = fc.state;

    return Scaffold
    ( appBar: AppBar( title: Text(title), ),
      body: Center
      ( child: Column
        ( children:
          [ Text("by Barrett Koster 2025"),
            foodsButton(context), // enter data
            analysisButton(context), // analyze it
            ResetButton(), // for debugging
          ],
        ),
      ),
    );
  }

  // foodsButton() is a button that sends you to
  // the page with the list of foods for today.
  // Lets you enter more foods or feelings or ... 
  Widget foodsButton( BuildContext context )
  { return ElevatedButton
    ( onPressed: ()
      { Navigator.of(context).push
        ( MaterialPageRoute
          ( builder: (context2)=> Daily(context),
          ) 
        );
      },
      child: Text("zappnin"),
    );
  }

  // returns a button that sends you to the analysis page
  Widget analysisButton( BuildContext context )
  { return ElevatedButton
    ( onPressed: (){},
      child: Text("analyze"),
    );
  }
}

// erases all of the data.  
// Remove this or make it hard to get to in the final project.
class ResetButton extends StatelessWidget
{ Widget build( BuildContext context )
  { FoodCubit fc = BlocProvider.of<FoodCubit>(context);
    return ElevatedButton
    ( onPressed: (){ fc.reset(); },
      child: Text("reset"),
    );
  }
}
