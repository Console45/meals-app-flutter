import 'package:flutter/material.dart';
import 'package:dotted_border/dotted_border.dart';
import '../widgets/meal_details_card.dart';
import '../widgets/meal_details_image.dart';
import '../dummy_data.dart';
import '../models/meal.dart';

class MealDetailScreen extends StatefulWidget {
  static const routeName = '/meal-detail';
  final Function toggleFav;
  final Function isFavourite;
  const MealDetailScreen({Key key, this.toggleFav, this.isFavourite})
      : super(key: key);

  @override
  _MealDetailScreenState createState() => _MealDetailScreenState();
}

class _MealDetailScreenState extends State<MealDetailScreen>
    with SingleTickerProviderStateMixin {
  void _goBack(context) {
    Navigator.of(context).pop();
  }

  TabController _tabController;
  @override
  void initState() {
    super.initState();
    _tabController = new TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final mealId = (ModalRoute.of(context).settings.arguments
        as Map<String, String>)['id'];
    final _selectedMeal = DUMMY_MEALS.firstWhere((meal) => meal.id == mealId);
    String _complexityText;
    String _affordabilityText;

    switch (_selectedMeal.complexity) {
      case Complexity.Simple:
        _complexityText = 'Simple';
        break;
      case Complexity.Challenging:
        _complexityText = 'Challenging';
        break;
      case Complexity.Hard:
        _complexityText = 'Hard';
        break;
      default:
        _complexityText = 'Unknown';
        break;
    }

    switch (_selectedMeal.affordability) {
      case Affordability.Affordable:
        _affordabilityText = 'Affordable';
        break;
      case Affordability.Pricey:
        _affordabilityText = 'Pricey';
        break;
      case Affordability.Luxurious:
        _affordabilityText = 'Expensive';
        break;
      default:
        _affordabilityText = 'Unknown';
        break;
    }

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.delete,
          color: Colors.red,
        ),
        onPressed: () {
          Navigator.of(context).pop(mealId);
        },
      ),
      body: Container(
        height: MediaQuery.of(context).size.height * 1,
        child: Column(
          children: <Widget>[
            Container(
              height: (MediaQuery.of(context).size.height) * .53,
              width: MediaQuery.of(context).size.width * 1,
              color: Colors.white,
              child: Stack(
                children: <Widget>[
                  MealDetailsImage(selectedMeal: _selectedMeal),
                  Positioned(
                    right: 30,
                    top: 40,
                    child: GestureDetector(
                      onTap: () => _goBack(context),
                      child: Container(
                        padding: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          color: Colors.white60,
                          borderRadius: BorderRadius.circular(100),
                        ),
                        child: Icon(
                          Icons.close,
                          color: Colors.black54,
                        ),
                      ),
                    ),
                  ),
                  MealDetailsCard(
                    selectedMeal: _selectedMeal,
                    complexityText: _complexityText,
                    affordabilityText: _affordabilityText,
                    isFavourite: widget.isFavourite(mealId),
                    toggleFav: () => widget.toggleFav(mealId),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            _mealDetailsTab(_tabController),
            Container(
              height: (MediaQuery.of(context).size.height -
                      MediaQuery.of(context).padding.top) *
                  .39,
              child:
                  _mealDetailsTabView(context, _selectedMeal, _tabController),
            )
          ],
        ),
      ),
    );
  }
}

Widget _mealDetailsTab(TabController tabController) {
  return TabBar(
    tabs: const <Widget>[
      Tab(
        text: 'Ingredients',
      ),
      Tab(
        text: 'Steps',
      )
    ],
    controller: tabController,
    isScrollable: true,
    indicatorSize: TabBarIndicatorSize.tab,
    indicatorColor: Colors.blue,
    labelColor: Colors.black,
    labelStyle: TextStyle(
      fontWeight: FontWeight.bold,
      fontFamily: 'RobotoCondensed',
      fontSize: 16,
    ),
    unselectedLabelStyle: TextStyle(
      fontWeight: FontWeight.w400,
      fontFamily: 'RobotoCondensed',
    ),
    unselectedLabelColor: Colors.black45,
  );
}

Widget _mealDetailsTabView(
    BuildContext context, Meal selectedMeal, TabController tabController) {
  return TabBarView(
    children: <Widget>[
      ListView.builder(
        itemBuilder: (ctx, index) {
          return Container(
            height: 45,
            margin: EdgeInsets.only(
              left: MediaQuery.of(context).size.width * .1,
              right: MediaQuery.of(context).size.width * .1,
              bottom: MediaQuery.of(context).size.width * .03,
            ),
            padding: EdgeInsets.all(14),
            decoration: BoxDecoration(
              border: Border.all(width: .2, color: Colors.grey),
            ),
            child: Text(selectedMeal.ingredients[index]),
          );
        },
        itemCount: selectedMeal.ingredients.length,
      ),
      ListView.builder(
        itemBuilder: (ctx, index) {
          return Container(
            width: MediaQuery.of(context).size.width * .8,
            margin: EdgeInsets.symmetric(horizontal: 30, vertical: 5),
            child: DottedBorder(
              child: Text(selectedMeal.steps[index]),
              padding: EdgeInsets.all(15),
              dashPattern: <double>[5, 3, 0],
              color: Colors.grey,
            ),
          );
        },
        itemCount: selectedMeal.steps.length,
      ),
    ],
    controller: tabController,
  );
}
