import 'package:Meals_app/models/meal.dart';
import 'package:Meals_app/screens/categories.dart';
import 'package:Meals_app/screens/favourite_screen.dart';
import 'package:Meals_app/widgets/bottom_nav.dart';
import 'package:Meals_app/widgets/main_drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomeScreen extends StatefulWidget {
  final List<Meal> favouriteMeals;
  HomeScreen(this.favouriteMeals);
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _navElements = [
    {"icon": 'assets/icons/home.svg', "title": 'Home'},
    {"icon": 'assets/icons/starred.svg', "title": 'Favourites'}
  ];
  List<Map> _screens;
  @override
  void initState() {
    _screens = [
      {
        'title': 'Categories',
        'widget': CategoriesScreen(),
      },
      {
        'title': 'Favourites',
        'widget': FavouriteScreen(widget.favouriteMeals),
      }
    ];
    super.initState();
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  int _currentIndex = 0;
  void _changeScreen(int pageIndex) {
    setState(() {
      _currentIndex = pageIndex;
    });
  }

  void _openDrawer() {
    _scaffoldKey.currentState.openDrawer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Padding(
          padding:
              EdgeInsets.only(left: MediaQuery.of(context).size.width * .03),
          child: Text(
            _screens[_currentIndex]['title'],
            style: TextStyle(
              fontFamily: 'RobotoCondensed',
            ),
          ),
        ),
        elevation: 0,
        leading: GestureDetector(
          child: Container(
            padding: const EdgeInsets.only(left: 25, right: 5),
            child: SvgPicture.asset(
              'assets/icons/menu.svg',
              height: 12,
              width: 12,
            ),
          ),
          onTap: _openDrawer,
        ),
      ),
      drawer: MainDrawer(),
      body: _screens[_currentIndex]['widget'],
      bottomNavigationBar: BottomNav(
        navElements: _navElements,
        currentIndex: _currentIndex,
        changePage: _changeScreen,
      ),
    );
  }
}
