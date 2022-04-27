import 'package:flutter/material.dart';

import '../constant.dart';
import '../models/category.dart';

class CategoryWidget extends StatelessWidget {
  final Category category;
  final VoidCallback selectCategory;
  final int selectedIndex, index;

  const CategoryWidget(
      {Key? key,
      required this.category,
      required this.selectCategory,
      required this.selectedIndex,
      required this.index})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: selectCategory,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: defaultPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              category.name,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Spartan',
                  color: selectedIndex == index ? textColor : textLightColor),
            ),
            Container(
              margin: EdgeInsets.only(top: defaultPadding / 4), //top padding 5
              height: 2,
              width: 30,
              color: selectedIndex == index ? Colors.black : Colors.transparent,
            )
          ],
        ),
      ),
    );
  }
}
