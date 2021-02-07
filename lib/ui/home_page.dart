import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:groceries_app/bloc/food_bloc.dart';
import 'package:groceries_app/bloc/food_event.dart';
import 'package:groceries_app/bloc/food_state.dart';
import 'package:groceries_app/elements/error.dart';
import 'package:groceries_app/elements/list.dart';
import 'package:groceries_app/elements/loading.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  FoodBloc foodBloc;

  @override
  void initState() {
    foodBloc = BlocProvider.of<FoodBloc>(context);
    foodBloc.add(FetchFoodEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: BlocBuilder<FoodBloc, FoodState>(builder: (context, state) {
          if (state is FoodInitialState) {
            return buildLoading();
          } else if (state is FoodLoadingState) {
            return buildLoading();
          } else if (state is FoodLoadedState) {
            return buildHintsList(state.recipes);
          } else if (state is FoodErrorState) {
            return buildError(state.message);
          }
        }),
      ),
    );
  }
}
