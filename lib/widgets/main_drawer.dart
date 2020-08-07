import 'package:Meals_app/screens/filters.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class MainDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          Container(
            height: 120,
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            color: Hexcolor('#0567D0'),
            alignment: Alignment.centerLeft,
            child: Text(
              'Cooking Up!',
              style: TextStyle(
                fontFamily: 'RobotoCondensed',
                fontSize: 30,
                color: Colors.white,
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          drawerListTitle(Icons.restaurant, 'Meals', () {
            Navigator.of(context).pushReplacementNamed('/');
          }),
          drawerListTitle(Icons.settings, 'Filters', () {
            Navigator.of(context).pushReplacementNamed(FiltersScreen.routeName);
          }),
        ],
      ),
    );
  }
}

Widget drawerListTitle(IconData icon, String title, Function tapHandler) {
  return ListTile(
    leading: Icon(
      icon,
      size: 26,
    ),
    title: Text(title,
        style: TextStyle(
          fontFamily: 'RobotoCondensed',
          fontSize: 24,
        )),
    onTap: tapHandler,
  );
}
