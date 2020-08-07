import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hexcolor/hexcolor.dart';

class BottomNav extends StatelessWidget {
  final List<Map<String, Object>> navElements;
  final int currentIndex;
  final Function changePage;
  BottomNav({this.navElements, this.currentIndex, this.changePage});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.09,
      padding: const EdgeInsets.only(bottom: 15),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          top: BorderSide(color: Hexcolor('#EEEEEE')),
        ),
      ),
      child: SafeArea(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: navElements.asMap().entries.map((entry) {
            int index = entry.key;
            bool active = index == currentIndex;
            Map<String, Object> navEl = entry.value;
            return GestureDetector(
              onTap: () => changePage(index),
              child: Padding(
                padding: const EdgeInsets.all(5),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    SvgPicture.asset(navEl['icon'],
                        height: 20,
                        color:
                            active ? Hexcolor('#0567D0') : Hexcolor('#A2A2A2')),
                    Text(
                      navEl['title'],
                      style: TextStyle(
                        fontSize: 12,
                        color:
                            active ? Hexcolor('#0567D0') : Hexcolor('#828E9C'),
                      ),
                    )
                  ],
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
