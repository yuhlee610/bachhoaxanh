import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../components/cart_card.dart';
import '../constant.dart';
import '../models/cart.dart';
import '../models/order.dart';
import '../models/order_detail.dart';

class OrderDetailScreen extends StatelessWidget {
  Order order;
  OrderDetailScreen({Key? key, required this.order}) : super(key: key);

  OrderDetail _orderDetail = OrderDetail(
      order: Order(
          id: 'LQNSU346JK',
          address: '123 abc',
          orderStatus: 'Shipping',
          totalPrice: 22943,
          itemsQty: 3),
      cartList: <Cart>[
        Cart(
            name: 'Innisfree Green Tea Seed serum',
            image:
                'https://cdn.tgdd.vn/Products/Images/2443/88651/bhx/-202108021001475179.jpg',
            price: 75000,
            subcategory: 'abc',
            id: '123',
            amount: 10,
            quantity: 3),
        Cart(
            id: '123',
            name: 'Elsheskin Active  Redjuvenating',
            image:
                'https://cdn.tgdd.vn/Products/Images/2443/88651/bhx/-202108021001475179.jpg',
            price: 75000,
            subcategory: 'abc',
            amount: 10,
            quantity: 2),
        Cart(
            id: '123',
            name: 'Cosrx Aloe  Sun Crea SPF 30',
            image:
                'https://cdn.tgdd.vn/Products/Images/2443/88651/bhx/-202108021001475179.jpg',
            price: 75000,
            subcategory: 'abc',
            amount: 10,
            quantity: 1),
      ],
      address: '2727 Lakeshore Rd undefined Nampa, Tennessee 78410');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        iconTheme: IconThemeData(color: Colors.black),
        centerTitle: true,
        title: Text(
          'Order Details',
          style: TextStyle(fontFamily: 'Spartan', color: Colors.black),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: defaultPadding - 4, vertical: defaultPadding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Row(
                        children: [
                          Container(
                            width: 24,
                            height: 24,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle, color: primaryColor),
                            child: Icon(
                              Icons.check,
                              size: 12,
                              color: Colors.white,
                            ),
                          )
                        ],
                      ),
                    ),
                    Expanded(
                      child: Divider(
                        color: primaryColor,
                        thickness: 1,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Row(
                        children: [
                          Container(
                            width: 24,
                            height: 24,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle, color: primaryColor),
                            child: Icon(
                              Icons.check,
                              size: 12,
                              color: Colors.white,
                            ),
                          )
                        ],
                      ),
                    ),
                    Expanded(
                      child: Divider(
                        color: primaryColor,
                        thickness: 1,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Row(
                        children: [
                          Container(
                            width: 24,
                            height: 24,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: primaryColor.withOpacity(0.3)),
                            child: Icon(
                              Icons.check,
                              size: 12,
                              color: Colors.white,
                            ),
                          )
                        ],
                      ),
                    ),
                    Expanded(
                      child: Divider(
                        color: primaryColor,
                        thickness: 1,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Row(
                        children: [
                          Container(
                            width: 24,
                            height: 24,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: primaryColor.withOpacity(0.3)),
                            child: Icon(
                              Icons.check,
                              size: 12,
                              color: Colors.white,
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Packing',
                        style: TextStyle(
                            fontFamily: 'Spartan', color: textLightColor),
                      ),
                      Text(
                        'Shipping',
                        style: TextStyle(
                            fontFamily: 'Spartan', color: textLightColor),
                      ),
                      Text(
                        'Arriving',
                        style: TextStyle(
                            fontFamily: 'Spartan', color: textLightColor),
                      ),
                      Text(
                        'Success',
                        style: TextStyle(
                            fontFamily: 'Spartan', color: textLightColor),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 24, bottom: 12),
                  child: Text(
                    'Products',
                    style: TextStyle(
                        fontFamily: 'Spartan',
                        fontWeight: FontWeight.w600,
                        fontSize: 18),
                  ),
                ),
                ListView.builder(
                    physics: ScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: _orderDetail.cartList.length,
                    itemBuilder: (context, index) => CartCard(
                          cart: _orderDetail.cartList[index],
                          isDelete: false,
                        )),
                Padding(
                  padding: EdgeInsets.only(top: 12, bottom: 12),
                  child: Text(
                    'Shipping Details',
                    style: TextStyle(
                        fontFamily: 'Spartan',
                        fontWeight: FontWeight.w600,
                        fontSize: 18),
                  ),
                ),
                Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6)),
                  child: Padding(
                    padding: const EdgeInsets.all(14.0),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Date Shipping',
                              style: TextStyle(
                                  fontFamily: 'Spartan',
                                  color: textLightColor,
                                  fontSize: 16),
                            ),
                            Text(
                              DateFormat.yMMMd()
                                  .format(_orderDetail.order.dateCreate)
                                  .toString(),
                              style: TextStyle(
                                  fontFamily: 'Spartan', fontSize: 16),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 16,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'No. Resi',
                              style: TextStyle(
                                  fontFamily: 'Spartan',
                                  color: textLightColor,
                                  fontSize: 16),
                            ),
                            Text(_orderDetail.order.id,
                                style: TextStyle(
                                    fontFamily: 'Spartan', fontSize: 16))
                          ],
                        ),
                        SizedBox(
                          height: 16,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Address',
                              style: TextStyle(
                                  fontFamily: 'Spartan',
                                  color: textLightColor,
                                  fontSize: 16),
                            ),
                            SizedBox(
                              width: 100,
                            ),
                            Expanded(
                                child: Text(_orderDetail.address,
                                    textAlign: TextAlign.right,
                                    style: TextStyle(
                                        fontFamily: 'Spartan',
                                        fontSize: 16,
                                        height: 1.5))),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 12, bottom: 12),
                  child: Text(
                    'Payment Details',
                    style: TextStyle(
                        fontFamily: 'Spartan',
                        fontWeight: FontWeight.w600,
                        fontSize: 18),
                  ),
                ),
                Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6)),
                  child: Padding(
                    padding: const EdgeInsets.all(14.0),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Items',
                              style: TextStyle(
                                  fontFamily: 'Spartan',
                                  color: textLightColor,
                                  fontSize: 16),
                            ),
                            Text(
                              '\$${_orderDetail.order.totalPrice}',
                              style: TextStyle(
                                  fontFamily: 'Spartan', fontSize: 16),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 16,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Shipping',
                              style: TextStyle(
                                  fontFamily: 'Spartan',
                                  color: textLightColor,
                                  fontSize: 16),
                            ),
                            Text('\$5.00',
                                style: TextStyle(
                                    fontFamily: 'Spartan', fontSize: 16))
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          child: Divider(
                            color: primaryColor,
                            thickness: 1,
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Total Price',
                              style: TextStyle(
                                  fontFamily: 'Spartan',
                                  color: textLightColor,
                                  fontSize: 16),
                            ),
                            Text('\$${_orderDetail.order.totalPrice}',
                                style: TextStyle(
                                    fontFamily: 'Spartan',
                                    fontSize: 16,
                                    color: primaryColor,
                                    fontWeight: FontWeight.w600))
                          ],
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
