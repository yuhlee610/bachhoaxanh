import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../constant.dart';
import '../models/order.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({Key? key}) : super(key: key);

  @override
  _OrderScreenState createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  List<Order> orderList = <Order>[
    Order(
        transId: 'LQNSU346JK',
        orderStatus: 'Shipping',
        totalPrice: 229.43,
        itemsQty: 3),
    Order(
        transId: 'SDG1345KJD',
        orderStatus: 'Shipping',
        totalPrice: 229.43,
        itemsQty: 3),
    Order(
        transId: 'LQNSU346JK',
        orderStatus: 'Shipping',
        totalPrice: 229.43,
        itemsQty: 2),
    Order(
        transId: 'SDG1345KJD',
        orderStatus: 'Shipping',
        totalPrice: 229.43,
        itemsQty: 4),
  ];

  Widget _buildOrder(int index) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, orderDetailRoute);
      },
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
        margin: EdgeInsets.only(bottom: defaultPadding / 2),
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: Text(
                  orderList[index].transId,
                  style: TextStyle(
                      fontFamily: 'Spartan',
                      fontSize: 14,
                      fontWeight: FontWeight.w600),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Text(
                  DateFormat.yMMMd()
                      .format(orderList[index].dateCreate)
                      .toString(),
                  style: TextStyle(
                      fontFamily: 'Spartan',
                      fontSize: 14,
                      color: textLightColor),
                ),
              ),
              Divider(
                color: primaryColor,
                thickness: 1,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Order Status',
                      style: TextStyle(
                          fontFamily: 'Spartan',
                          fontSize: 14,
                          color: textLightColor),
                    ),
                    Text(
                      orderList[index].orderStatus,
                      style: TextStyle(fontFamily: 'Spartan', fontSize: 14),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Items',
                      style: TextStyle(
                          fontFamily: 'Spartan',
                          fontSize: 14,
                          color: textLightColor),
                    ),
                    Text(
                      '${orderList[index].itemsQty} Items purchased',
                      style: TextStyle(fontFamily: 'Spartan', fontSize: 14),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Price',
                      style: TextStyle(
                          fontFamily: 'Spartan',
                          fontSize: 14,
                          color: textLightColor),
                    ),
                    Text(
                      '\$${orderList[index].totalPrice}',
                      style: TextStyle(
                          fontFamily: 'Spartan',
                          fontSize: 14,
                          color: primaryColor,
                          fontWeight: FontWeight.w600),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        iconTheme: IconThemeData(color: Colors.black),
        centerTitle: true,
        title: Text(
          'Orders',
          style: TextStyle(fontFamily: 'Spartan', color: Colors.black),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(defaultPadding - 4),
            child: ListView.builder(
                itemCount: orderList.length,
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                physics: ScrollPhysics(),
                itemBuilder: (context, index) => _buildOrder(index)),
          ),
        ),
      ),
    );
  }
}
