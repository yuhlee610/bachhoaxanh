import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_braintree/flutter_braintree.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

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
      subtotal = subtotal + element.price * element.quantity;
    });
    return subtotal;
  }

  @override
  Widget build(BuildContext context) {
    var cartList = Provider.of<CartProvider>(context).cartList;

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
                    _calcSubtotal(cartList).toString() + 'đ',
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
                    '15000đ',
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
                    (_calcSubtotal(cartList) + 15000).toString() + 'đ',
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
                      var request = BraintreeDropInRequest(
                          tokenizationKey: sandboxKey,
                          collectDeviceData: true,
                          paypalRequest: BraintreePayPalRequest(
                              amount: '10.00', displayName: 'ABCD'),
                          cardEnabled: true);

                      var result = await BraintreeDropIn.start(request);
                      if (result != null) {
                        print(result.paymentMethodNonce.description);
                        print(result.paymentMethodNonce.nonce);

                        String url = 'http://10.0.2.2:5001/final-project-3176a/us-central1/paypalPayment';

                        var response = await http.post(Uri.parse(
                            '${url}?payment_method_nonce=${result.paymentMethodNonce.nonce}&device_data=${result.deviceData}'));

                        var payResult = jsonDecode(response.body);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(payResult['result']),
                          ),
                        );
                        print(payResult['result']);
                      }
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
