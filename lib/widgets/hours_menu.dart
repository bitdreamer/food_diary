// hours_menu.dart
// Barrett Koster 2025

import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "../data/show_state.dart";

  // shows a little pull down menu of hours of the day.  
  // Current datetime is held in ShowState.
class HoursMenu extends StatelessWidget
{   
  Widget build( BuildContext context)
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