import 'package:flutter/material.dart';
import '../models/meal.dart';

class MealDetailsCard extends StatelessWidget {
  const MealDetailsCard({
    Key key,
    @required this.selectedMeal,
    @required this.complexityText,
    @required this.affordabilityText,
    this.isFavourite,
    this.toggleFav,
  }) : super(key: key);

  final Meal selectedMeal;
  final String complexityText;
  final String affordabilityText;
  final bool isFavourite;
  final Function toggleFav;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return Container(
        child: Stack(
          children: <Widget>[
            Container(
              padding: EdgeInsets.symmetric(
                  horizontal: constraints.maxWidth * .07, vertical: 10),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      child: Text(
                        selectedMeal.title,
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          fontFamily: 'RobotoCondensed',
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            const Icon(
                              Icons.schedule,
                              size: 30,
                            ),
                            Text(' ${selectedMeal.duration} min')
                          ],
                        ),
                        Row(
                          children: <Widget>[
                            const Icon(
                              Icons.work,
                              size: 30,
                            ),
                            Text(' $complexityText')
                          ],
                        ),
                        Row(
                          children: <Widget>[
                            const Icon(
                              Icons.attach_money,
                              size: 30,
                            ),
                            Text('$affordabilityText')
                          ],
                        )
                      ],
                    ),
                  ]),
            ),
            Positioned(
              left: constraints.maxWidth * .8,
              bottom: 90,
              child: isFavourite
                  ? IconButton(
                      icon: Icon(
                        Icons.star,
                        color: Colors.yellow,
                      ),
                      onPressed: toggleFav,
                    )
                  : IconButton(
                      icon: Icon(
                        Icons.star_border,
                        color: Colors.black54,
                      ),
                      onPressed: toggleFav,
                    ),
            ),
          ],
        ),
        height: 130,
        margin: EdgeInsets.only(
          top: (MediaQuery.of(context).size.height) * .35,
          left: MediaQuery.of(context).size.width * .05,
          right: MediaQuery.of(context).size.width * .05,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: const [
            BoxShadow(
              color: Color.fromRGBO(0, 0, 0, .08),
              offset: Offset(0, 8),
              blurRadius: 50,
            ),
          ],
        ),
      );
    });
  }
}
