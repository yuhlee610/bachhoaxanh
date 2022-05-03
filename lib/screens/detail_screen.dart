import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../constant.dart';
import '../models/product.dart';
import '../providers/CartProvider.dart';
import '../providers/FavoriteProvider.dart';
import '../providers/UserProvider.dart';

class DetailScreen extends StatefulWidget {
  final Product product;

  const DetailScreen({Key? key, required this.product}) : super(key: key);

  @override
  _DetailScreenState createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  int numOfItems = 1;

  SizedBox _buildOutlineButton(IconData icon, VoidCallback press) {
    return SizedBox(
      width: 40,
      height: 32,
      child: OutlineButton(
        padding: EdgeInsets.zero,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(13)),
        onPressed: press,
        child: Icon(icon),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    var currentUser = Provider.of<UserProvider>(context).user;

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        iconTheme: IconThemeData(color: Colors.black),
        title: Text(
          'Chi tiết sản phẩm',
          style: TextStyle(fontFamily: 'Spartan', color: Colors.black),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                alignment: Alignment.center,
                margin: EdgeInsets.symmetric(
                    horizontal: defaultPadding - 4, vertical: defaultPadding),
                child: CarouselSlider(
                  options: CarouselOptions(
                    enlargeCenterPage: true,
                  ),
                  items: widget.product.image
                      .map((e) => Image.network(
                            e,
                            fit: BoxFit.cover,
                          ))
                      .toList(),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: defaultPadding - 4),
                child: Text(
                  widget.product.name,
                  style: TextStyle(
                      fontFamily: 'Spartan',
                      fontWeight: FontWeight.w600,
                      fontSize: 22),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: defaultPadding - 4,
                    right: defaultPadding - 4,
                    top: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Giá ${widget.product.price}đ',
                      style: TextStyle(
                        fontSize: 17,
                        fontFamily: 'Spartan',
                        color: Color(0xFF40BFFF),
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          Provider.of<FavoriteProvider>(context, listen: false)
                              .updateFavorite(currentUser.id, widget.product);
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Đã cập nhật'),
                            ),
                          );
                        });
                      },
                      child: Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(90),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.15),
                                  spreadRadius: 3,
                                  blurRadius: 5,
                                  offset: Offset(0, 2),
                                )
                              ],
                              color: Colors.white),
                          child: Icon(
                            Icons.favorite,
                            color: Colors.red,
                            size: 22,
                          )),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: defaultPadding - 4,
                    vertical: defaultPadding / 2),
                child: Row(
                  children: [
                    _buildOutlineButton(Icons.remove, () {
                      setState(() {
                        if (numOfItems <= 1) return;
                        numOfItems--;
                      });
                    }),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: defaultPadding / 2),
                      child: Text(
                        numOfItems.toString().padLeft(2, "0"),
                        style: TextStyle(fontFamily: 'Spartan', fontSize: 20),
                      ),
                    ),
                    _buildOutlineButton(Icons.add, () {
                      if (numOfItems < widget.product.amount) {
                        setState(() {
                          numOfItems++;
                        });
                      }
                    }),
                    Expanded(child: SizedBox()),
                    GestureDetector(
                      onTap: () {
                        Provider.of<CartProvider>(context, listen: false)
                            .addToCartFromDetail(
                            widget.product, currentUser.id, numOfItems);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Đã thêm sản phẩm vào giỏ hàng'),
                          ),
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: defaultPadding - 4, top: 12, bottom: 8),
                        child: Container(
                            padding: EdgeInsets.all(10),
                            width: 80,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.15),
                                    spreadRadius: 3,
                                    blurRadius: 5,
                                    offset: Offset(0, 2),
                                  )
                                ],
                                color: Colors.white),
                            child: Icon(
                              Icons.add_shopping_cart,
                              color: primaryColor,
                              size: 30,
                            )),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: defaultPadding - 4,
                    vertical: defaultPadding - 4),
                child: Text(
                  widget.product.description,
                  style: TextStyle(
                      fontSize: 18,
                      height: 1.4,
                      fontFamily: 'Spartan',
                      color: textLightColor),
                ),
              ),
              SizedBox(
                height: 20,
              )
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.pushNamed(context, cartRoute);
          },
          backgroundColor: primaryColor,
          child: Icon(Icons.shopping_bag_outlined)),
    );
  }
}
