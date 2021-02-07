import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:groceries_app/bloc/food_event.dart';
import 'package:groceries_app/bloc/food_state.dart';
import 'package:groceries_app/data/model/food.dart';
import 'package:groceries_app/data/repositories/food_repository.dart';

class FoodBloc extends Bloc<FoodEvent, FoodState> {
  FoodRepository repository;

  FoodBloc({@required this.repository}) : super(null);

  FoodState get initialState => FoodInitialState();
  @override
  Stream<FoodState> mapEventToState(FoodEvent event) async* {
    if (event is FetchFoodEvent) {
      yield FoodLoadingState();

      try {
        List<Recipe> recipes = await repository.getFoods();
        yield FoodLoadedState(recipes: recipes);
      } catch (e) {
        yield FoodErrorState(message: e.toString());
      }
    }
  }
}
