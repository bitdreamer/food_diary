
import "package:flutter_bloc/flutter_bloc.dart";

class ShowState
{
  String cat;
  String datetime; //  the full format
  ShowState( this.cat, this.datetime );
}

class ShowCubit extends Cubit<ShowState>
{
  // start off with stuff you ate today
  ShowCubit() 
  : super( ShowState( "ate",
                      DateTime.now().toString() //.split(" ")[0]
                    ) 
         );

  void setCat( String c ) { emit( ShowState(c,state.datetime) );  }
  void setDate( String d ) { emit( ShowState(state.cat, d) ); }
}
