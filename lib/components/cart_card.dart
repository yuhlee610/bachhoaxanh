import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../constant.dart';
import '../models/cart.dart';
import '../providers/CartProvider.dart';
import '../providers/UserProvider.dart';

class CartCard extends StatelessWidget {
  Cart cart;
  bool isDelete = true;

  CartCard({Key? key, required this.cart, required this.isDelete})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    String userId = Provider.of<UserProvider>(context, listen: false).user.id;

    return Card(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4),
          side: new BorderSide(color: borderColor)),
      margin: EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12),
        child: Row(
          children: [
            SizedBox(
              width: 100,
              height: 100,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(4),
                child: Image.network(
                  cart.image,
                ),
              ),
            ),
            SizedBox(
              width: 12,
            ),
            Expanded(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: Text(
                    cart.name,
                    style: TextStyle(
                        fontFamily: 'Spartan', fontSize: 15, height: 1.6),
                  ),
                ),
                Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Provider.of<CartProvider>(context, listen: false)
                            .decreaseQty(cart.id, userId);
                      },
                      child: Container(
                          width: 35,
                          height: 35,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
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
                            Icons.remove,
                            size: 22,
                          )),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12.0),
                      child: Text(cart.quantity.toString(),
                          style: TextStyle(
                            fontFamily: 'Spartan',
                            fontSize: 14,
                            height: 1.6,
                          )),
                    ),
                    GestureDetector(
                      onTap: () {
                        Provider.of<CartProvider>(context, listen: false)
                            .increaseQty(cart.id, userId);
                      },
                      child: Container(
                          width: 35,
                          height: 35,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
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
                            Icons.add,
                            size: 22,
                          )),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Text('${cart.price}đ',
                    style: TextStyle(
                        fontFamily: 'Spartan',
                        fontSize: 14,
                        height: 1.6,
                        color: primaryColor,
                        fontWeight: FontWeight.w700)),
              ],
            )),
            if (this.isDelete)
              IconButton(
                  onPressed: () {
                    Provider.of<CartProvider>(context, listen: false).removeCartItem(cart.id, userId);
                  },
                  icon: Icon(
                    Icons.delete_outline,
                    color: textLightColor,
                  ))
          ],
        ),
      ),
    );
  }
}
