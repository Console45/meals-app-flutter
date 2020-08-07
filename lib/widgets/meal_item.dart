import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import '../models/meal.dart';
import '../screens/meal_details.dart';

class MealItem extends StatelessWidget {
  final String id;
  final String title;
  final String imageUrl;
  final int duration;
  final Complexity complexity;
  final Affordability affordability;
  final Function removeItem;

  MealItem({
    this.id,
    this.title,
    this.imageUrl,
    this.duration,
    this.complexity,
    this.affordability,
    this.removeItem,
  });

  void seletectMeal(BuildContext context) async {
    final result = await Navigator.of(context).pushNamed(
      MealDetailScreen.routeName,
      arguments: {'id': id},
    );
    if (result != null) removeItem(result);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => seletectMeal(context),
      child: Container(
        margin: EdgeInsets.only(
          top: 10,
          left: MediaQuery.of(context).size.width * .08,
          right: MediaQuery.of(context).size.width * .08,
          bottom: 15,
        ),
        height: 400,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Color.fromRGBO(0, 0, 0, .05),
              blurRadius: 30,
              offset: Offset(0, 15),
            ),
          ],
        ),
        child: Stack(
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.network(
                imageUrl,
                width: MediaQuery.of(context).size.width * .84,
                height: double.infinity,
                fit: BoxFit.fill,
                filterQuality: FilterQuality.high,
              ),
            ),
            Positioned(
              bottom: 0,
              child: ClipRRect(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
                child: BackdropFilter(
                  filter: ui.ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                  child: Container(
                    width: MediaQuery.of(context).size.width * .84,
                    height: 100,
                    padding: EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(.2),
                    ),
                    child: Text(
                      title,
                      style: TextStyle(
                        fontSize: 26,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'RobotoCondensed',
                      ),
                      softWrap: true,
                      overflow: TextOverflow.fade,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
