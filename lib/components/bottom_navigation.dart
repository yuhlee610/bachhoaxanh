import 'package:flutter/material.dart';

import '../constant.dart';

class BottomNavigation extends StatelessWidget {
  String? selectedItem = '';
  BottomNavigation({Key? key, required this.selectedItem}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      alignment: Alignment.center,
      padding:
      EdgeInsets.only(left: defaultPadding * 2, right: defaultPadding * 2),
      decoration: BoxDecoration(color: Colors.white, boxShadow: [
        BoxShadow(
            offset: Offset(0, -10),
            blurRadius: 35,
            color: primaryColor.withOpacity(0.38))
      ]),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            onPressed: () {
              print('tap Home');
              Navigator.pushReplacementNamed(context, homeRoute);
            },
            icon: Icon(
              Icons.home,
              color: selectedItem == 'home' ? primaryColor : Color(0xFFCCCCCC),
              size: 34,
            ),
          ),
          IconButton(
            onPressed: () {
              print('tap Favor');
              Navigator.pushReplacementNamed(context, favorRoute);
            },
            icon: Icon(Icons.favorite,
                size: 34,
                color:
                selectedItem == 'favor' ? primaryColor : Color(0xFFCCCCCC)),
          ),
          IconButton(
            onPressed: () {
              print('tap Cart');
              Navigator.pushReplacementNamed(context, cartRoute);
            },
            icon: Icon(IconData(0xe59c, fontFamily: 'MaterialIcons'),
                size: 34,
                color:
                selectedItem == 'cart' ? primaryColor : Color(0xFFCCCCCC)),
          ),
        ],
      ),
    );
  }
}
