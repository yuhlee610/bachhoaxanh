import 'package:bachhoaxanh/providers/OrderProvider.dart';
import 'package:bachhoaxanh/providers/UserProvider.dart';
import 'package:bachhoaxanh/screens/order_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../constant.dart';
import '../models/order.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({Key? key}) : super(key: key);

  @override
  _OrderScreenState createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  // @override
  // void initState() {
  //   super.initState();
  //
  //   String userId = Provider.of<UserProvider>(context, listen: false).user.id;
  //   Provider.of<OrderProvider>(context, listen: false).getOrders(userId);
  // }

  Widget _buildOrder(Order order) {
    NumberFormat numberFormat = NumberFormat.decimalPattern('en');

    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => OrderDetailScreen(order: order)));
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
                  order.id,
                  style: TextStyle(
                      fontFamily: 'Spartan',
                      fontSize: 14,
                      fontWeight: FontWeight.w600),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Text(
                  DateFormat.yMMMd().format(order.dateCreate).toString(),
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
                      'Trạng thái',
                      style: TextStyle(
                          fontFamily: 'Spartan',
                          fontSize: 14,
                          color: textLightColor),
                    ),
                    Text(
                      order.orderStatus,
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
                      'Số lượng sản phẩm',
                      style: TextStyle(
                          fontFamily: 'Spartan',
                          fontSize: 14,
                          color: textLightColor),
                    ),
                    Text(
                      '${order.itemsQty} sản phẩm',
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
                      'Tổng tiền',
                      style: TextStyle(
                          fontFamily: 'Spartan',
                          fontSize: 14,
                          color: textLightColor),
                    ),
                    Text(
                      numberFormat.format(order.totalPrice) + 'đ',
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
    List<Order> orderList = Provider.of<OrderProvider>(context).orders;

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        iconTheme: IconThemeData(color: Colors.black),
        centerTitle: true,
        title: Text(
          'Đơn hàng',
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
                itemBuilder: (context, index) => _buildOrder(orderList[index])),
          ),
        ),
      ),
    );
  }
}
