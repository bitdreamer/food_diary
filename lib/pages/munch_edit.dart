// about_edit.dart
// Barrett Koster  2025

import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";

import "../data/munch.dart";
import "../data/food_state.dart";

/*
  This page should be able to edit the 
*/

class MunchEdit extends StatelessWidget
{
  final BuildContext bc;
  final Munch m;
  final String cat;
  MunchEdit( this.bc, this.m, this.cat );

  Widget build( BuildContext context )
  {
    FoodCubit fc = BlocProvider.of<FoodCubit>(bc);
    return BlocProvider<FoodCubit>.value
    ( value: fc,
      child: BlocBuilder<FoodCubit,FoodState>
      ( builder: (context,state) => Scaffold
        ( appBar: AppBar( title: Text("edit item") ),
          body: MunchEdit2(m, cat), // Text("edit page for ${m.show()}"),
        ),
      )
    );
  }
}

//  this page allow editing of the Munch as well as 
// implicit editing of the About as well.
class MunchEdit2 extends StatelessWidget
{
  final Munch m;
  final String cat;

  MunchEdit2( this.m, this.cat, {super.key} );

  @override
  Widget build( BuildContext context )
  {
    return Text("edit page for ${m.show()}");

    // fields to edit
    // what
    // when
    // much  with checkbox if this is the default
    // cat
    // units
  }
}