import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import '../widgets/category_item.dart';
import '../dummy_data.dart';

class CategoriesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Container(
          height: (MediaQuery.of(context).size.height -
                  MediaQuery.of(context).padding.top) *
              1,
          // child: GridView(
          //   padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 25),
          //   children: DUMMY_CATEGORIES
          //       .map((categoryData) => CategoryItem(
          //           categoryData.title, categoryData.color, categoryData.id))
          //       .toList(),
          //   gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
          //     maxCrossAxisExtent: 200,
          //     childAspectRatio: 1.3,
          //     crossAxisSpacing: 15,
          //     mainAxisSpacing: 20,
          //   ),
          // ),
          child: StaggeredGridView.countBuilder(
            crossAxisCount: 4,
            itemCount: DUMMY_CATEGORIES.length,
            itemBuilder: (BuildContext context, int index) {
              return CategoryItem(DUMMY_CATEGORIES[index].title,
                  DUMMY_CATEGORIES[index].color, DUMMY_CATEGORIES[index].id);
            },
            staggeredTileBuilder: (int index) =>  StaggeredTile.count(2, !index.isEven ? 2: 2.5),
              mainAxisSpacing: 20,
              crossAxisSpacing: 20,
              padding: const EdgeInsets.symmetric(horizontal: 20),
          )),
    );
  }
}
