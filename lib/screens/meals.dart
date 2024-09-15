import 'package:flutter/material.dart';
import 'package:meals_app/models/meal.dart';
import 'package:meals_app/widgets/meal_item.dart';

class MealsScreen extends StatelessWidget {
  const MealsScreen({super.key, required this.title, required this.meals});
  final String title;
  final List<Meal> meals;
  @override
  Widget build(BuildContext context) {
    Widget content;
    if (meals.isEmpty) {
      content = Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Uh No.. meals',
              style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground,
                  ),
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              'Try to choose other available categories',
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: Theme.of(context).colorScheme.primary,
                  ),
            ),
          ],
        ),
      );
    } else {
      content = ListView.builder(
          itemCount: meals.length,
          itemBuilder: (ctx, index) => MealItem(meal: meals[index]));
    }
    return Scaffold(
        appBar: AppBar(
          title: Text(title),
        ),
        body: content);
  }
}
