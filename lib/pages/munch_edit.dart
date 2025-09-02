// munch_edit.dart
// Barrett Koster  2025

import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";

import "../data/munch.dart";
import "../data/food_state.dart";
import "../data/show_state.dart";
import "../widgets/hours_menu.dart";

/*
  This page should be able to edit the time of a munch or delete it.
*/

// the MunchEdit layer is just to establish the FoodState on this page.
// See MunchEdit2 for visible widget content.
class MunchEdit extends StatelessWidget
{
  final BuildContext bc; // context of calling page, use to make BLoC for THIS page.
  final Munch m; // the item being edited
  final String cat; // the associated category.  We could look this up in
                    // the map, but here it is. (??)
  MunchEdit( this.bc, this.m, this.cat );

  Widget build( BuildContext context )
  {
    FoodCubit fc = BlocProvider.of<FoodCubit>(bc);
    return BlocProvider<FoodCubit>.value
    ( value: fc,
      child: BlocBuilder<FoodCubit,FoodState>
      ( builder: (context,state) => BlocProvider<ShowCubit>
        ( create: (context) => ShowCubit.set(cat,m.when),
          child: BlocBuilder<ShowCubit,ShowState>
          ( builder: (context, state) => MunchEdit2(m, cat),
          ),
        ),
      ),
    );
  }
}

// MunchEdit2 page allow editing of the Munch as well as 
// implicit editing of the About as well.
class MunchEdit2 extends StatelessWidget
{
  final Munch m;
  final String cat;

  MunchEdit2( this.m, this.cat, {super.key} );

  @override
  Widget build( BuildContext context )
  {
    TextEditingController tec = TextEditingController();

    // return Text("hi there");
    return Scaffold
    ( appBar: AppBar( title: Text("edit ${m.show()}") ),
      body:Column
      ( children:
        [ Text("edit page for ${m.show()}"),
          Row
          ( children:
            [ Text("what"),
              SizedBox
              ( height:40, width: 200,
                child: TextField(controller:tec),
              ),
            ],
          ),
          Row
          ( children:
            [ Text("hour of the day  "),
              HoursMenu(),
            ],
          ),
        ]
      ),
    );

    // fields to edit
    // what
    // when
    // much  with checkbox if this is the default
    // cat
    // units
  }
}