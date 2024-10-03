import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals_app/providers/meals_provider.dart';

enum Filter {
  glutenFree,
  lactoseFree,
  vegeterian,
  vegan,
}

class FilterNotifier extends StateNotifier<Map<Filter, bool>> {
  FilterNotifier()
      : super({
          Filter.glutenFree: false,
          Filter.lactoseFree: false,
          Filter.vegeterian: false,
          Filter.vegan: false,
        });
  void setFiilters(Map<Filter, bool> currentFilter) {
    state = currentFilter;
  }

  void setFilter(Filter filter, bool isAcive) {
    state = {...state, filter: isAcive};
  }
}

final filterProvider = StateNotifierProvider<FilterNotifier, Map<Filter, bool>>(
  (ref) => FilterNotifier(),
);
final filterMealsProvider = Provider((ref) {
  // one provider depend on other providers
  final meals = ref.watch(mealsProvider);
  final selectedFilter = ref.watch(filterProvider);
  return meals.where((meal) {
    if (selectedFilter[Filter.glutenFree]! && !meal.isGlutenFree) {
      return false;
    }
    if (selectedFilter[Filter.lactoseFree]! && !meal.isLactoseFree) {
      return false;
    }
    if (selectedFilter[Filter.vegeterian]! && !meal.isVegetarian) {
      return false;
    }
    if (selectedFilter[Filter.vegan]! && !meal.isVegan) {
      return false;
    }
    return true;
  }).toList();
},
);
