import 'package:bachhoaxanh/components/order_detail_card.dart';
import 'package:bachhoaxanh/providers/OrderDetailProvider.dart';
import 'package:bachhoaxanh/providers/UserProvider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../constant.dart';
import '../models/cart.dart';
import '../models/order.dart';
import '../models/order_detail.dart';

class OrderDetailScreen extends StatelessWidget {
  Order order;

  OrderDetailScreen({Key? key, required this.order}) : super(key: key);

  int getItemsPrice(List<Cart> orderDetail) {
    int total = 0;
    orderDetail.forEach((e) {
      total = (total + (e.price * (100 - e.sale) / 100) * e.quantity).toInt();
    });
    return total;
  }

  @override
  Widget build(BuildContext context) {
    NumberFormat numberFormat = NumberFormat.decimalPattern('en');
    var currentUserId = Provider.of<UserProvider>(context).user.id;
    Provider.of<OrderDetailProvider>(context, listen: false).getDetailOrder(currentUserId, order.id);
    var orderDetail = Provider.of<OrderDetailProvider>(context).orderDetail;

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        iconTheme: IconThemeData(color: Colors.black),
        centerTitle: true,
        title: Text(
          'Chi tiết đơn hàng',
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
                        'Đóng gói',
                        style: TextStyle(
                            fontFamily: 'Spartan', color: textLightColor),
                      ),
                      Text(
                        'Giao hàng',
                        style: TextStyle(
                            fontFamily: 'Spartan', color: textLightColor),
                      ),
                      Text(
                        'Thành công',
                        style: TextStyle(
                            fontFamily: 'Spartan', color: textLightColor),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 24, bottom: 12),
                  child: Text(
                    'Sản phẩm',
                    style: TextStyle(
                        fontFamily: 'Spartan',
                        fontWeight: FontWeight.w600,
                        fontSize: 18),
                  ),
                ),
                ListView.builder(
                    physics: ScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: orderDetail.length,
                    itemBuilder: (context, index) => OrderDetailCard(
                          cart: orderDetail[index],
                        )),
                Padding(
                  padding: EdgeInsets.only(top: 12, bottom: 12),
                  child: Text(
                    'Thông tin giao hàng',
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
                              'Ngày giao hàng',
                              style: TextStyle(
                                  fontFamily: 'Spartan',
                                  color: textLightColor,
                                  fontSize: 16),
                            ),
                            Text(
                              DateFormat.yMMMd()
                                  .format(order.dateCreate)
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
                              'Mã hóa đơn',
                              style: TextStyle(
                                  fontFamily: 'Spartan',
                                  color: textLightColor,
                                  fontSize: 16),
                            ),
                            SizedBox(
                              width: 100,
                            ),
                            Expanded(
                              child: Text(order.id,
                                  textAlign: TextAlign.right,
                                  style: TextStyle(
                                      fontFamily: 'Spartan', fontSize: 16)),
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
                              'Địa chỉ',
                              style: TextStyle(
                                  fontFamily: 'Spartan',
                                  color: textLightColor,
                                  fontSize: 16),
                            ),
                            SizedBox(
                              width: 100,
                            ),
                            Expanded(
                                child: Text(order.address,
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
                    'Chi tiết thanh toán',
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
                              'Sản phẩm',
                              style: TextStyle(
                                  fontFamily: 'Spartan',
                                  color: textLightColor,
                                  fontSize: 16),
                            ),
                            Text(
                              '${numberFormat.format(getItemsPrice(orderDetail))}đ',
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
                            Text('${numberFormat.format(SHIPPING_COST)}đ',
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
                              'Giảm giá',
                              style: TextStyle(
                                  fontFamily: 'Spartan',
                                  color: textLightColor,
                                  fontSize: 16),
                            ),
                            Text(order.discount,
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
                              'Tổng cộng',
                              style: TextStyle(
                                  fontFamily: 'Spartan',
                                  color: textLightColor,
                                  fontSize: 16),
                            ),
                            Text('${numberFormat.format(order.totalPrice)}đ',
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
