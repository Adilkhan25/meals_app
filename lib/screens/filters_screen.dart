import 'package:flutter/material.dart';

// import 'package:meals_app/screens/tabs_screen.dart';
// import 'package:meals_app/widgets/main_drawer.dart';
enum Filter { glutenFree, lactoseFree, vegeterian, vegan }

class FiltersScreen extends StatefulWidget {
  const FiltersScreen({
    super.key,
    required this.currentFilter,
  });
  final Map<Filter, bool> currentFilter;
  @override
  State<FiltersScreen> createState() {
    return _FilterScreensState();
  }
}

class _FilterScreensState extends State<FiltersScreen> {
  bool isGlutenFree = false;
  bool isLactoseFree = false;
  bool isVegeterian = false;
  bool isVegan = false;
  @override
  void initState() {
    super.initState();
    isGlutenFree = widget.currentFilter[Filter.glutenFree]!;
    isLactoseFree = widget.currentFilter[Filter.lactoseFree]!;
    isVegeterian = widget.currentFilter[Filter.vegeterian]!;
    isVegan = widget.currentFilter[Filter.vegan]!;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Filters'),
      ),
      // drawer: MainDrawer(onSelectScreen: (identifier) {
      //   Navigator.of(context).pop();
      //   if (identifier == 'Meals') {
      //     Navigator.of(context).push(
      //       MaterialPageRoute(
      //         builder: (ctx) => (const TabsScreen()),
      //       ),
      //     );
      //   }
      // }),
      body: PopScope(
        canPop: false,
        onPopInvoked: (didPop) {
          if (didPop) return;
          Navigator.of(context).pop({
            Filter.glutenFree: isGlutenFree,
            Filter.lactoseFree: isLactoseFree,
            Filter.vegeterian: isVegeterian,
            Filter.vegan: isVegan,
          });
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
