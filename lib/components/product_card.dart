import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../constant.dart';
import '../models/favorite.dart';

class ProductCard extends StatefulWidget {
  Favorite product;
  VoidCallback delete;
  VoidCallback select;
  bool isSelect;

  ProductCard(
      {Key? key,
      required this.product,
      required this.delete,
      required this.select,
      required this.isSelect})
      : super(key: key);

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  @override
  Widget build(BuildContext context) {
    NumberFormat numberFormat = NumberFormat.decimalPattern('en');

    return GestureDetector(
      onTap: widget.select,
      child: Card(
        shape: widget.isSelect
            ? new RoundedRectangleBorder(
                side: new BorderSide(color: primaryColor, width: 2.0),
                borderRadius: BorderRadius.circular(4.0))
            : new RoundedRectangleBorder(
                side: new BorderSide(color: borderColor, width: 2.0),
                borderRadius: BorderRadius.circular(4.0)),
        margin: EdgeInsets.only(bottom: 16),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            children: [
              SizedBox(
                width: 100,
                height: 100,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(5),
                  child: Image.network(
                    widget.product.image,
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
                    padding: EdgeInsets.only(bottom: 5),
                    child: Text(
                      widget.product.name,
                      style: TextStyle(
                          fontFamily: 'Spartan', fontSize: 14, height: 1.6),
                    ),
                  ),
                  Text(widget.product.subcategory,
                      style: TextStyle(
                        fontFamily: 'Spartan',
                        fontSize: 14,
                        height: 1.6,
                      )),
                  SizedBox(
                    height: 5,
                  ),
                  Text('${numberFormat.format(widget.product.price)}đ',
                      style: TextStyle(
                          fontFamily: 'Spartan',
                          fontSize: 14,
                          height: 1.6,
                          color: primaryColor,
                          fontWeight: FontWeight.w700)),
                ],
              )),
              IconButton(
                  onPressed: widget.delete,
                  icon: Icon(
                    Icons.delete_outline,
                    color: textLightColor,
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
