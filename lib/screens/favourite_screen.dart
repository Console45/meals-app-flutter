import 'package:Meals_app/models/meal.dart';
import 'package:Meals_app/widgets/meal_item.dart';
import 'package:flutter/material.dart';

class FavouriteScreen extends StatefulWidget {
  final List<Meal> favouriteMeals;
  FavouriteScreen(this.favouriteMeals);

  @override
  _FavouriteScreenState createState() => _FavouriteScreenState();
}

class _FavouriteScreenState extends State<FavouriteScreen> {
  void _removeMeal(String mealId) {
    setState(() {
      widget.favouriteMeals.removeWhere((meal) => meal.id == mealId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        child: widget.favouriteMeals.isNotEmpty
            ? Container(
                child: ListView.builder(
                  itemBuilder: (ctx, index) {
                    return MealItem(
                      title: widget.favouriteMeals[index].title,
                      imageUrl: widget.favouriteMeals[index].imageUrl,
                      id: widget.favouriteMeals[index].id,
                      removeItem: _removeMeal,
                    );
                  },
                  itemCount: widget.favouriteMeals.length,
                ),
              )
            : Text('You have no favourites yet - start adding some!'),
      ),
    );
  }
}
