import 'package:bachhoaxanh/constant.dart';
import 'package:bachhoaxanh/models/cart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class OrderDetailCard extends StatelessWidget {
  Cart cart;

  OrderDetailCard({Key? key, required this.cart}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    NumberFormat numberFormat = NumberFormat.decimalPattern('en');

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
                Text('x${cart.quantity.toString()}',
                    style: TextStyle(
                      fontFamily: 'Spartan',
                      fontSize: 14,
                      height: 1.6,
                    )),
                SizedBox(
                  height: 10,
                ),
                Text('${numberFormat.format(cart.price)}đ',
                    style: TextStyle(
                        fontFamily: 'Spartan',
                        fontSize: 14,
                        height: 1.6,
                        color: primaryColor,
                        fontWeight: FontWeight.w700)),
              ],
            )),
          ],
        ),
      ),
    );
  }
}
