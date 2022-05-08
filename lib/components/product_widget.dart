import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../constant.dart';
import '../models/product.dart';

class ProductWidget extends StatelessWidget {
  final VoidCallback tap;
  final Product product;
  final bool isMargin;

  const ProductWidget(
      {Key? key,
      required this.tap,
      required this.product,
      required this.isMargin})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    NumberFormat numberFormat = NumberFormat.decimalPattern('en');
    int finalPrice = (product.price - (product.price * product.sale / 100)).toInt();

    return Stack(
      children: [
        Container(
          padding: EdgeInsets.symmetric(vertical: 8, horizontal: 4),
          margin: EdgeInsets.only(right: this.isMargin ? 15 : 0),
          constraints: BoxConstraints(maxWidth: 155),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              border: Border.all(
                color: borderColor,
                width: 1,
              )),
          child: GestureDetector(
            onTap: tap,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Image.network(
                    product.image[0],
                  ),
                ),
                Container(
                  width: 175,
                  margin:
                      EdgeInsets.only(top: 10, bottom: 15, left: 5, right: 5),
                  child: Text(
                    product.name,
                    style: TextStyle(
                      fontSize: 12,
                      fontFamily: 'Spartan',
                      fontWeight: FontWeight.w700,
                      color: textPrimaryColor,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 5, bottom: 10),
                  child: Text(
                    '${numberFormat.format(finalPrice)}đ',
                    style: TextStyle(
                      fontSize: 12,
                      fontFamily: 'Spartan',
                      color: Color(0xFF40BFFF),
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
        Container(
          child: product.sale > 0
              ? Positioned(
                  child: Container(
                    alignment: Alignment.center,
                    height: 20,
                    width: 40,
                    color: hotdealColor,
                    child: Text(
                      '-${product.sale}%',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  top: 0,
                  right: 15,
                )
              : null,
        )
      ],
    );
  }
}
