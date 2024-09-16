import 'package:flutter/material.dart';
import 'package:meals_app/models/meal.dart';

class MealDetailsScreen extends StatelessWidget {
  const MealDetailsScreen(
      {super.key, required this.meal, required this.onToggleFavoriteMeal});
  final Meal meal;
  final void Function(Meal meal) onToggleFavoriteMeal;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(meal.title),
          actions: [
            IconButton(
                onPressed: () {
                  onToggleFavoriteMeal(meal);
                },
                icon: const Icon(Icons.star)),
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Image.network(
                meal.imageUrl,
                fit: BoxFit.cover,
                height: 300,
                width: double.infinity,
              ),
              const SizedBox(
                height: 14,
              ),
              Text(
                'Ingredients',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: Theme.of(context).colorScheme.primary,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 12,
              ),
              for (String ingradient in meal.ingredients) ...[
                const SizedBox(
                  height: 6,
                ),
                Text(
                  ingradient,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                )
              ],
              const SizedBox(
                height: 14,
              ),
              Text(
                'Steps',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: Theme.of(context).colorScheme.primary,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 12,
              ),
              for (String step in meal.steps) ...[
                const SizedBox(
                  height: 6,
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 6, horizontal: 14),
                  child: Text(
                    step,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          color: Theme.of(context).colorScheme.secondary,
                        ),
                  ),
                )
              ],
            ],
          ),
        ));
  }
}
