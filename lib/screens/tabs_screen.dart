import 'package:flutter/material.dart';

import 'package:meals_app/models/meal.dart';
import 'package:meals_app/screens/categories.dart';
import 'package:meals_app/screens/meals.dart';

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

  @override
  Widget build(BuildContext context) {
    Widget activePage = CategoryScreen(
      onToggleFavoriteMeal: _toggleFavoriteMeal,
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
