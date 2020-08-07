import 'package:Meals_app/models/meal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../widgets/meal_item.dart';

class CategoriesMealScreen extends StatefulWidget {
  static const routeName = '/category-meals';

  final List<Meal> availableMeals;

  CategoriesMealScreen(this.availableMeals);

  @override
  _CategoriesMealScreenState createState() => _CategoriesMealScreenState();
}

class _CategoriesMealScreenState extends State<CategoriesMealScreen> {
  void goBack(BuildContext context) {
    Navigator.of(context).pop();
  }

  bool _loadedInitData = false;

  String categoryTitle;
  List<Meal> categoryMeals;

  @override
  void didChangeDependencies() {
    if (!_loadedInitData) {
      final routeArgs =
          ModalRoute.of(context).settings.arguments as Map<String, Object>;
      categoryTitle = routeArgs['title'];
      final categoryId = routeArgs['id'];
      categoryMeals = widget.availableMeals.where((meal) {
        return meal.categories.contains(categoryId);
      }).toList();
      _loadedInitData = true;
    }
    super.didChangeDependencies();
  }

  void _removeMeal(String mealId) {
    setState(() {
      categoryMeals.removeWhere((meal) => meal.id == mealId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () => goBack(context),
          child: Container(
            width: 20,
            height: 20,
            padding: const EdgeInsets.only(left: 25, right: 5),
            child: SvgPicture.asset(
              'assets/images/backarrow.svg',
              color: Colors.black,
            ),
          ),
        ),
        centerTitle: true,
        title: Container(
          child: Text(
            categoryTitle,
            style: TextStyle(
              color: Colors.black,
              fontFamily: "Raleway",
              fontSize: 20,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
        elevation: 0,
        backgroundColor: Colors.white,
      ),
      body: Container(
        child: ListView.builder(
          itemBuilder: (ctx, index) {
            return MealItem(
              title: categoryMeals[index].title,
              imageUrl: categoryMeals[index].imageUrl,
              id: categoryMeals[index].id,
              removeItem: _removeMeal,
            );
          },
          itemCount: categoryMeals.length,
        ),
      ),
    );
  }
}
