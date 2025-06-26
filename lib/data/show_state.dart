
import "package:flutter_bloc/flutter_bloc.dart";

class ShowState
{
  String cat;
  String datetime; //  the full format
  ShowState( this.cat, this.datetime );
  // {  print(" ++++++++ ss.datetime: $datetime "); } // debug

  String getDate(){ return datetime.split(" ")[0]; }
  String getHour(){ return datetime.split(" ")[1].split(":")[0]; }
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
  void setDatetime( String dt ) { emit( ShowState(state.cat, dt) ); }

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
}
