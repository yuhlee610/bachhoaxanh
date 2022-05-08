import 'dart:convert';

import 'package:bachhoaxanh/constant.dart';
import 'package:bachhoaxanh/models/user.dart';
import 'package:bachhoaxanh/providers/OrderProvider.dart';
import 'package:bachhoaxanh/providers/UserProvider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_braintree/flutter_braintree.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

import '../models/cart.dart';
import '../providers/CartProvider.dart';

class AddressScreen extends StatefulWidget {
  const AddressScreen({Key? key}) : super(key: key);

  @override
  State<AddressScreen> createState() => _AddressScreenState();
}

class _AddressScreenState extends State<AddressScreen> {
  String selectedAddress = "";
  TextEditingController newAddressController = new TextEditingController();

  Widget _buildAddressCard(String address) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedAddress = address;
        });
      },
      child: Card(
        shape: selectedAddress == address
            ? RoundedRectangleBorder(
                side: BorderSide(color: primaryColor, width: 2.0),
                borderRadius: BorderRadius.circular(4.0))
            : RoundedRectangleBorder(
                side: BorderSide(color: borderColor, width: 2.0),
                borderRadius: BorderRadius.circular(4.0)),
        margin: EdgeInsets.only(bottom: 16),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
          child: Text(
            address,
            style: TextStyle(fontFamily: 'Spartan', fontSize: 15, height: 1.6),
          ),
        ),
      ),
    );
  }

  int calcTotal(List<Cart> cartList) {
    int total = 0;
    cartList.forEach((element) {
      total = (total + element.price * (100 - element.sale) / 100 * element.quantity).toInt();
    });
    return total + SHIPPING_COST;
  }

  @override
  Widget build(BuildContext context) {
    UserModel currentUser = Provider.of<UserProvider>(context).user;
    var cartList = Provider.of<CartProvider>(context).cartList;

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        iconTheme: IconThemeData(color: Colors.black),
        title: Text(
          'Chọn địa chỉ',
          style: TextStyle(fontFamily: 'Spartan', color: Colors.black),
        ),
        centerTitle: true,
        actions: [
          Padding(
              padding: EdgeInsets.only(right: 20.0),
              child: GestureDetector(
                onTap: () => showDialog(
                    context: context,
                    builder: (BuildContext context) => AlertDialog(
                          title: Text('Thêm địa chỉ'),
                          content: TextField(
                            controller: newAddressController,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Địa chỉ',
                            ),
                          ),
                          actions: <Widget>[
                            TextButton(
                              onPressed: () => Navigator.pop(context, 'Cancel'),
                              child: const Text('Hủy'),
                            ),
                            TextButton(
                              onPressed: () {
                                Provider.of<UserProvider>(context,
                                        listen: false)
                                    .addAddress(currentUser.id,
                                        newAddressController.text);
                                Navigator.pop(context, 'Add');
                              },
                              child: const Text('Thêm'),
                            ),
                          ],
                        )),
                child: Icon(Icons.add),
              )),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: defaultPadding - 8, vertical: defaultPadding),
            child: Column(
              children: [
                Container(
                  child: currentUser.address.length != 0
                      ? ListView.builder(
                          physics: ScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: currentUser.address.length,
                          itemBuilder: (context, index) =>
                              _buildAddressCard(currentUser.address[index]),
                        )
                      : Text(
                          'Hãy thêm mới địa chỉ',
                          style: TextStyle(
                              fontFamily: 'Spartan', fontSize: 15, height: 1.6),
                        ),
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
                      onPressed: () async {
                        if (selectedAddress != "") {
                          int total = calcTotal(cartList);
                          String bucks = (total / 23000).toStringAsFixed(2);

                          var request = BraintreeDropInRequest(
                              tokenizationKey: sandboxKey,
                              collectDeviceData: true,
                              paypalRequest: BraintreePayPalRequest(
                                  amount: bucks, displayName: 'Bachhoaxanh'),
                              cardEnabled: true);

                          var result = await BraintreeDropIn.start(request);
                          if (result != null) {
                            String url =
                                'http://10.0.2.2:5001/final-project-3176a/us-central1/paypalPayment';

                            var response = await http.post(Uri.parse(
                                '${url}?payment_method_nonce=${result.paymentMethodNonce.nonce}&device_data=${result.deviceData}&amount=${bucks}'));

                            var payResult = jsonDecode(response.body);

                            if (payResult['result'] == 'success') {
                              Provider.of<OrderProvider>(context, listen: false)
                                  .createOrder(cartList, currentUser.id, total,
                                      selectedAddress);
                              Provider.of<CartProvider>(context, listen: false)
                                  .clearCart(cartList, currentUser.id);

                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('Thanh toán thành công'),
                                ),
                              );
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('Thanh toán thất bại'),
                                ),
                              );
                            }
                          }
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Vui lòng chọn địa chỉ'),
                            ),
                          );
                        }
                      },
                      child: Text(
                        'Tiếp tục',
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 18,
                            fontFamily: 'Spartan'),
                      ),
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
