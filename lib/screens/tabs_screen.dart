import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals_app/models/meal.dart';
import 'package:meals_app/providers/favorite_meals_provider.dart';
import 'package:meals_app/providers/filter_provider.dart';
import 'package:meals_app/providers/meals_provider.dart';
import 'package:meals_app/screens/categories.dart';
import 'package:meals_app/screens/filters_screen.dart';
import 'package:meals_app/screens/meals.dart';
import 'package:meals_app/widgets/main_drawer.dart';

class TabsScreen extends ConsumerStatefulWidget {
  const TabsScreen({super.key});

  @override
  ConsumerState<TabsScreen> createState() {
    return _TabsScreenState();
  }
}

class _TabsScreenState extends ConsumerState<TabsScreen> {
  int _selectedIndex = 0;
  void _selecetedPage(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _pnSelectScreenFromDrawer(String identfier) {
    Navigator.of(context).pop();
    if (identfier == 'Filter') {
      Navigator.of(context).push<Map<Filter, bool>>(
        MaterialPageRoute(
          builder: (ctx) => (const FiltersScreen()),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    var meals = ref.watch(mealsProvider);
    final selectedFilter = ref.watch(filterProvider);
    var availableMeals = meals.where((meal) {
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
    Widget activePage = CategoryScreen(
      availableMeals: availableMeals,
    );
    String activePageTitle = 'Categories';
    if (_selectedIndex == 1) {
      activePageTitle = 'Your Favorites';
      final List<Meal> favoriteMeals = ref.watch(favoriteMealsProvider);
      activePage = MealsScreen(
        meals: favoriteMeals,
      );
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(activePageTitle),
      ),
      drawer: MainDrawer(
        onSelectScreen: _pnSelectScreenFromDrawer,
      ),
      body: activePage,
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selecetedPage,
        currentIndex: _selectedIndex,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.set_meal), label: 'Categories'),
          BottomNavigationBarItem(icon: Icon(Icons.star), label: 'Favorties')
        ],
      ),
    );
  }
}
