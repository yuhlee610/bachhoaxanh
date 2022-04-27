import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../components/bottom_navigation.dart';
import '../components/product_card.dart';
import '../constant.dart';
import '../models/favorite.dart';
import '../providers/CartProvider.dart';
import '../providers/FavoriteProvider.dart';
import '../providers/UserProvider.dart';

class FavorScreen extends StatefulWidget {
  const FavorScreen({Key? key}) : super(key: key);

  @override
  _FavorScreenState createState() => _FavorScreenState();
}

class _FavorScreenState extends State<FavorScreen> {
  List<Favorite> selectedFavorite = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    String userId = Provider.of<UserProvider>(context, listen: false).user.id;

    Provider.of<FavoriteProvider>(context, listen: false).fetchFavorite(userId);
  }

  @override
  Widget build(BuildContext context) {
    var favoriteList = Provider.of<FavoriteProvider>(context).favoriteList;
    var currentUser = Provider.of<UserProvider>(context).user;

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Text(
          'Yêu thích',
          style: TextStyle(fontFamily: 'Spartan', color: Colors.black),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: defaultPadding - 4, vertical: defaultPadding),
            child: favoriteList.length != 0
                ? ListView.builder(
                    physics: ScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: favoriteList.length,
                    itemBuilder: (context, index) => ProductCard(
                          product: favoriteList[index],
                          delete: () {
                            Provider.of<FavoriteProvider>(context,
                                    listen: false)
                                .deleteFavorite(
                                    currentUser.id, favoriteList[index].id);
                            Provider.of<FavoriteProvider>(context,
                                    listen: false)
                                .fetchFavorite(currentUser.id);
                          },
                          select: () {
                            int i =
                                selectedFavorite.indexOf(favoriteList[index]);
                            if (i != -1) {
                              setState(() {
                                selectedFavorite.removeAt(i);
                              });
                            } else {
                              setState(() {
                                selectedFavorite.add(favoriteList[index]);
                              });
                            }
                          },
                          isSelect: selectedFavorite.indexOf(favoriteList[index]) != -1
                        ))
                : Text('Không có sản phẩm yêu thích',
                    style: TextStyle(
                        fontFamily: 'Spartan',
                        fontSize: 16,
                        height: 1.6,
                        color: textLightColor)),
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigation(selectedItem: 'favor'),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            if (selectedFavorite.isEmpty) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Vui lòng chọn sản phẩm'),
                ),
              );
            } else {
              Provider.of<CartProvider>(context, listen: false)
                  .addToCartFromFavor(selectedFavorite, currentUser.id, 1);
            }
          },
          backgroundColor: primaryColor,
          child: Icon(Icons.add)),
    );
  }
}
