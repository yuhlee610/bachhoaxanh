import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_braintree/flutter_braintree.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../components/bottom_navigation.dart';
import '../components/cart_card.dart';
import '../constant.dart';
import '../models/cart.dart';
import '../providers/CartProvider.dart';
import '../providers/UserProvider.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  void initState() {
    super.initState();

    String userId = Provider.of<UserProvider>(context, listen: false).user.id;
    Provider.of<CartProvider>(context, listen: false).fetchCart(userId);
  }

  int _calcSubtotal(List<Cart> cartList) {
    int subtotal = 0;
    cartList.forEach((element) {
      subtotal = (subtotal + element.price * (100 - element.sale) / 100 * element.quantity).toInt();
    });
    return subtotal;
  }

  @override
  Widget build(BuildContext context) {
    var cartList = Provider.of<CartProvider>(context).cartList;
    NumberFormat numberFormat = NumberFormat.decimalPattern('en');

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        centerTitle: true,
        title: Text(
          'Giỏ hàng',
          style: TextStyle(fontFamily: 'Spartan', color: Colors.black),
        ),
      ),
      body: SafeArea(
          child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: defaultPadding - 8, vertical: defaultPadding),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(0),
                child: cartList.length != 0
                    ? ListView.builder(
                        physics: ScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: cartList.length,
                        itemBuilder: (context, index) => CartCard(
                              cart: cartList[index],
                              isDelete: true,
                            ))
                    : Text('Không có sản phẩm trong giỏ hàng',
                        style: TextStyle(
                            fontFamily: 'Spartan',
                            fontSize: 16,
                            height: 1.6,
                            color: textLightColor)),
              ),
              SizedBox(
                height: 90,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Tổng:',
                    style: TextStyle(
                        fontSize: 16,
                        fontFamily: 'Spartan',
                        color: textLightColor),
                  ),
                  Text(
                    numberFormat.format(_calcSubtotal(cartList)) + 'đ',
                    style: TextStyle(
                        fontSize: 16,
                        fontFamily: 'Spartan',
                        color: textLightColor),
                  ),
                ],
              ),
              SizedBox(
                height: 24,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Tiền ship:',
                    style: TextStyle(
                        fontSize: 16,
                        fontFamily: 'Spartan',
                        color: textLightColor),
                  ),
                  Text(
                    numberFormat.format(SHIPPING_COST) + 'đ',
                    style: TextStyle(
                        fontSize: 16,
                        fontFamily: 'Spartan',
                        color: textLightColor),
                  ),
                ],
              ),
              SizedBox(
                height: 24,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Tổng cộng:',
                    style: TextStyle(fontSize: 16, fontFamily: 'Spartan'),
                  ),
                  Text(
                    numberFormat.format(_calcSubtotal(cartList) + SHIPPING_COST) + 'đ',
                    style: TextStyle(
                        fontSize: 16,
                        fontFamily: 'Spartan',
                        color: primaryColor,
                        fontWeight: FontWeight.w700),
                  ),
                ],
              ),
              Container(
                height: 64,
                width: double.infinity,
                margin: EdgeInsets.only(top: defaultPadding),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      primary: primaryColor,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5))),
                  child: Text(
                    'Thanh toán',
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 18,
                        fontFamily: 'Spartan'),
                  ),
                  onPressed: () async {
                    if (cartList.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Vui lòng thêm sản phẩm'),
                        ),
                      );
                    } else {
                      Navigator.pushNamed(context, addressRoute);
                    }
                  },
                ),
              )
            ],
          ),
        ),
      )),
      bottomNavigationBar: BottomNavigation(selectedItem: 'cart'),
    );
  }
}
