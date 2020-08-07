import 'package:flutter/material.dart';
import '../models/meal.dart';

class MealDetailsImage extends StatelessWidget {
  const MealDetailsImage({
    Key key,
    @required this.selectedMeal,
  }) : super(key: key);

  final Meal selectedMeal;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Image.network(
        selectedMeal.imageUrl,
        fit: BoxFit.cover,
        width: MediaQuery.of(context).size.width * 1,
        height: (MediaQuery.of(context).size.height) * .45,
      ),
      decoration: BoxDecoration(),
    );
  }
}
