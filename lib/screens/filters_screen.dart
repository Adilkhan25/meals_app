import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals_app/providers/filter_provider.dart';

// import 'package:meals_app/screens/tabs_screen.dart';
// import 'package:meals_app/widgets/main_drawer.dart';

class FiltersScreen extends ConsumerStatefulWidget {
  const FiltersScreen({
    super.key,
  });

  @override
  ConsumerState<FiltersScreen> createState() {
    return _FilterScreensState();
  }
}

class _FilterScreensState extends ConsumerState<FiltersScreen> {
  bool isGlutenFree = false;
  bool isLactoseFree = false;
  bool isVegeterian = false;
  bool isVegan = false;
  @override
  void initState() {
    super.initState();
    final activeFilter = ref.read(filterProvider);
    isGlutenFree = activeFilter[Filter.glutenFree]!;
    isLactoseFree = activeFilter[Filter.lactoseFree]!;
    isVegeterian = activeFilter[Filter.vegeterian]!;
    isVegan = activeFilter[Filter.vegan]!;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Filters'),
      ),
      body: PopScope(
        canPop: false,
        onPopInvoked: (didPop) {
          if (didPop) return;
          ref.read(filterProvider.notifier).setFiilters({
            Filter.glutenFree: isGlutenFree,
            Filter.lactoseFree: isLactoseFree,
            Filter.vegeterian: isVegeterian,
            Filter.vegan: isVegan,
          });
          Navigator.of(context).pop();
        },
        child: Column(
          children: [
            SwitchListTile(
              value: isGlutenFree,
              onChanged: (isCheked) {
                setState(() {
                  isGlutenFree = isCheked;
                });
              },
              title: Text(
                'Gluten-Free',
                style: Theme.of(context)
                    .textTheme
                    .titleLarge!
                    .copyWith(color: Theme.of(context).colorScheme.onSurface),
              ),
              subtitle: Text(
                'Only include gluten free meals',
                style: Theme.of(context).textTheme.labelMedium!.copyWith(
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
              ),
              activeColor: Theme.of(context).colorScheme.tertiary,
              contentPadding: const EdgeInsets.only(left: 34, right: 24),
            ),
            SwitchListTile(
              value: isLactoseFree,
              onChanged: (isCheked) {
                setState(() {
                  isLactoseFree = isCheked;
                });
              },
              title: Text(
                'Lactose-Free',
                style: Theme.of(context)
                    .textTheme
                    .titleLarge!
                    .copyWith(color: Theme.of(context).colorScheme.onSurface),
              ),
              subtitle: Text(
                'Only include Lactose free meals',
                style: Theme.of(context).textTheme.labelMedium!.copyWith(
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
              ),
              activeColor: Theme.of(context).colorScheme.tertiary,
              contentPadding: const EdgeInsets.only(left: 34, right: 24),
            ),
            SwitchListTile(
              value: isVegeterian,
              onChanged: (isCheked) {
                setState(() {
                  isVegeterian = isCheked;
                });
              },
              title: Text(
                'Vegeterian',
                style: Theme.of(context)
                    .textTheme
                    .titleLarge!
                    .copyWith(color: Theme.of(context).colorScheme.onSurface),
              ),
              subtitle: Text(
                'Only include Vegeterian meals',
                style: Theme.of(context).textTheme.labelMedium!.copyWith(
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
              ),
              activeColor: Theme.of(context).colorScheme.tertiary,
              contentPadding: const EdgeInsets.only(left: 34, right: 24),
            ),
            SwitchListTile(
              value: isVegan,
              onChanged: (isCheked) {
                setState(() {
                  isVegan = isCheked;
                });
              },
              title: Text(
                'Vegan',
                style: Theme.of(context)
                    .textTheme
                    .titleLarge!
                    .copyWith(color: Theme.of(context).colorScheme.onSurface),
              ),
              subtitle: Text(
                'Only include Vegan meals',
                style: Theme.of(context).textTheme.labelMedium!.copyWith(
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
              ),
              activeColor: Theme.of(context).colorScheme.tertiary,
              contentPadding: const EdgeInsets.only(left: 34, right: 24),
            ),
          ],
        ),
      ),
    );
  }
}
