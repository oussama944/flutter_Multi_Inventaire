import 'package:flutter/material.dart';
import 'package:inventaire_exo_muscu/models/meal.dart';
import 'package:inventaire_exo_muscu/screens/categories.dart';
import 'package:inventaire_exo_muscu/screens/meals.dart';
import 'package:inventaire_exo_muscu/widgets/appbar.dart';
import 'package:inventaire_exo_muscu/widgets/drawer.dart';
import 'package:inventaire_exo_muscu/widgets/responsive_body.dart';

class TabsScreen extends StatefulWidget {
  const TabsScreen({super.key});

  @override
  State<TabsScreen> createState() => _TabsScreensState();
}

class _TabsScreensState extends State<TabsScreen> {
  int _selectedPageIndex = 0;
  final List<Meal> _favoriteMeal = [];

  void _toggleMealFavoriteStatus(Meal meal) {
    final isExisting = _favoriteMeal.contains(meal);

    if (isExisting) {
      _favoriteMeal.remove(meal);
    } else {
      _favoriteMeal.add(meal);
    }
  }

  void _selectePage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget activeBar = CategoriesScreen(
      onToggleFavotite: _toggleMealFavoriteStatus,
    );
    var activePageTitle = 'Categorie ';

    if (_selectedPageIndex == 1) {
      activeBar = MealsScreen(
        meals: [],
        onToggleFavotite: _toggleMealFavoriteStatus,
      );
      activePageTitle = 'Vos Favories';
    }

    return Scaffold(
      // appBar: AppBar(title: Text(S.of(context).title)),
      appBar: CustomAppBar(title: activePageTitle),

      body: ResponsiveBody(
        child: activeBar,
      ),
      drawer: const CustomDrawer(),
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectePage,
        currentIndex: _selectedPageIndex,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'home'),
          BottomNavigationBarItem(icon: Icon(Icons.sports), label: 'categorie'),
        ],
      ),
    );
  }
}
