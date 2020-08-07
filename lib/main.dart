import 'package:Meals_app/dummy_data.dart';
import 'package:Meals_app/models/meal.dart';
import 'package:Meals_app/screens/filters.dart';
import 'package:Meals_app/screens/home.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import './screens/categories_meals.dart';
import './screens/meal_details.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Map<String, bool> _filters = {
    'gluten': false,
    'lactose': false,
    'vegan': false,
    'vegetarian': false
  };

  List<Meal> _availableMeals = DUMMY_MEALS;
  List<Meal> _favouriteMeals = [];

  void _setFilters(Map<String, bool> filterData) {
    setState(() {
      _filters = filterData;

      _availableMeals = DUMMY_MEALS.where((meal) {
        if (_filters['gluten'] && !meal.isGlutenFree) {
          return false;
        }
        if (_filters['lactose'] && !meal.isLactoseFree) {
          return false;
        }
        if (_filters['vegan'] && !meal.isVegan) {
          return false;
        }
        if (_filters['vegetarian'] && !meal.isVegetarian) {
          return false;
        }
        return true;
      }).toList();
    });
  }

  bool _isMealFavourite(String mealId) {
    return _favouriteMeals.any((meal) => meal.id == mealId);
  }

  void _toggleFavourite(String mealId) {
    final int existingIndex =
        _favouriteMeals.indexWhere((meal) => meal.id == mealId);
    if (existingIndex >= 0) {
      setState(() {
        _favouriteMeals.removeAt(existingIndex);
      });
    } else {
      setState(() {
        _favouriteMeals
            .add(DUMMY_MEALS.firstWhere((meal) => meal.id == mealId));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Foodox',
      theme: ThemeData(
        primaryColor: Colors.white,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        accentColor: Hexcolor('#Ffffff'),
        canvasColor: Colors.white,
        fontFamily: 'Raleway',
        textTheme: ThemeData.light().textTheme.copyWith(
              headline1: TextStyle(
                fontSize: 17,
                fontFamily: 'RobotoCondensed',
                color: Colors.black,
                fontWeight: FontWeight.w400,
              ),
              headline2: TextStyle(
                fontSize: 17,
                fontFamily: 'RobotoCondensed',
                color: Colors.white,
                fontWeight: FontWeight.w700,
              ),
            ),
      ),
      initialRoute: '/',
      routes: {
        '/': (ctx) => HomeScreen(_favouriteMeals),
        CategoriesMealScreen.routeName: (ctx) =>
            CategoriesMealScreen(_availableMeals),
        MealDetailScreen.routeName: (ctx) => MealDetailScreen(
            toggleFav: _toggleFavourite, isFavourite: _isMealFavourite),
        FiltersScreen.routeName: (ctx) => FiltersScreen(_setFilters, _filters),
      },
      // onGenerateRoute: (settings) {
      //   print(settings.arguments);
      //   return MaterialPageRoute(builder: (context) => CategoriesMealScreen());
      // },
      onUnknownRoute: (settings) {
        return MaterialPageRoute(
            builder: (context) => HomeScreen(_favouriteMeals));
      },
    );
  }
}
