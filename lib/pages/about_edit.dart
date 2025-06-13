// about_edit.dart
// Barrett Koster  2025

import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";

import "../data/munch.dart";
import "../data/food_state.dart";

/*

*/

class AboutEdit extends StatelessWidget
{
  final BuildContext bc;
  final Munch m;
  AboutEdit( this.bc, this.m );

  Widget build( BuildContext context )
  {
    FoodCubit fc = BlocProvider.of<FoodCubit>(bc);
    return BlocProvider<FoodCubit>.value
    ( value: fc,
      child: BlocBuilder<FoodCubit,FoodState>
      ( builder: (context,state) => Scaffold
        ( appBar: AppBar( title: Text("edit item") ),
          body: Text("edit page for ${m.show()}"),
        ),
      )
    );
  }
}