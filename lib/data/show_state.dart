
import "package:flutter_bloc/flutter_bloc.dart";

class ShowState
{
  String cat;
  String datetime; //  the full format
  bool keeb;
  ShowState( this.cat, this.datetime, this.keeb );
  // {  print(" ++++++++ ss.datetime: $datetime "); } // debug

  String getDate(){ return datetime.split(" ")[0]; }
  String getHour(){ return datetime.split(" ")[1].split(":")[0]; }
}

class ShowCubit extends Cubit<ShowState>
{
  // start off with stuff you ate today
  ShowCubit() 
  : super( ShowState( "ate",
                      DateTime.now().toString(),
                      false
                    ) 
         );

  void setCat( String c ) { emit( ShowState(c,state.datetime, false) );  }
  void setDatetime( String dt ) { emit( ShowState(state.cat, dt, state.keeb) ); }

  void setHour(String h)
  {
    List<String> parts = state.datetime.split(" ");
    String date = parts[0];
    String time = parts[1];
    List<String> tparts = time.split(":");
    String hour = tparts[0];
    String newDT = "$date $h:30:00";
    setDatetime(newDT);
  }

  // change the date this many days
  void bumpDate( int much )
  { DateTime current = DateTime.parse(state.datetime);
    if (much<0) { current = current.subtract( Duration(days:-much) ); }
    else        { current = current.add     ( Duration(days: much) ); }
    setDatetime( current.toString() );
  }

  void setKeyboard( bool tf )
  { emit( ShowState(state.cat, state.datetime, tf) ); }
}
