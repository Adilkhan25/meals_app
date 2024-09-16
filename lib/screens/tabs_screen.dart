import 'package:flutter/material.dart';
import 'package:meals_app/data/dummy_data.dart';

import 'package:meals_app/models/meal.dart';
import 'package:meals_app/screens/categories.dart';
import 'package:meals_app/screens/filters_screen.dart';
import 'package:meals_app/screens/meals.dart';
import 'package:meals_app/widgets/main_drawer.dart';

const kSelectedFilter = {
  Filter.glutenFree: false,
  Filter.lactoseFree: false,
  Filter.vegan: false,
  Filter.vegeterian: false,
};

class TabsScreen extends StatefulWidget {
  const TabsScreen({super.key});

  @override
  State<TabsScreen> createState() {
    return _TabsScreenState();
  }
}

class _TabsScreenState extends State<TabsScreen> {
  int _selectedIndex = 0;
  final List<Meal> favoriteMeals = [];
  Map<Filter, bool> _selectedFilter = kSelectedFilter;
  void _toggleFavoriteMeal(Meal meal) {
    if (favoriteMeals.contains(meal)) {
      setState(() {
        favoriteMeals.remove(meal);
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text(
          'this meal removed from Favorite list',
        )),
      );
    } else {
      setState(() {
        favoriteMeals.add(meal);
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text(
          'this meal added to Favorite list',
        )),
      );
    }
  }

  void _selecetedPage(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _pnSelectScreenFromDrawer(String identfier) async {
    Navigator.of(context).pop();
    if (identfier == 'Filter') {
      var result = await Navigator.of(context).push<Map<Filter, bool>>(
        MaterialPageRoute(
          builder: (ctx) => (FiltersScreen(
            currentFilter: _selectedFilter,
          )),
        ),
      );
      _selectedFilter = result ?? kSelectedFilter;
    }
  }

  @override
  Widget build(BuildContext context) {
    var availableMeals = dummyMeals.where((meal) {
      if (_selectedFilter[Filter.glutenFree]! && !meal.isGlutenFree) {
        return false;
      }
      if (_selectedFilter[Filter.lactoseFree]! && !meal.isLactoseFree) {
        return false;
      }
      if (_selectedFilter[Filter.vegeterian]! && !meal.isVegetarian) {
        return false;
      }
      if (_selectedFilter[Filter.vegan]! && !meal.isVegan) {
        return false;
      }
      return true;
    }).toList();
    Widget activePage = CategoryScreen(
      onToggleFavoriteMeal: _toggleFavoriteMeal,
      availableMeals: availableMeals,
    );
    String activePageTitle = 'Categories';
    if (_selectedIndex == 1) {
      activePageTitle = 'Your Favorites';
      activePage = MealsScreen(
        meals: favoriteMeals,
        onToggleFavoriteMeal: _toggleFavoriteMeal,
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
