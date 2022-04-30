import 'dart:convert';

import 'package:bachhoaxanh/constant.dart';
import 'package:bachhoaxanh/models/user.dart';
import 'package:bachhoaxanh/providers/UserProvider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_braintree/flutter_braintree.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

import '../providers/CartProvider.dart';

class AddressScreen extends StatefulWidget {
  const AddressScreen({Key? key}) : super(key: key);

  @override
  State<AddressScreen> createState() => _AddressScreenState();
}

class _AddressScreenState extends State<AddressScreen> {
  String selectedAddress = "";

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
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: defaultPadding - 8, vertical: defaultPadding),
            child: Column(
              children: [
                ListView.builder(
                  physics: ScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: currentUser.address.length,
                  itemBuilder: (context, index) =>
                      _buildAddressCard(currentUser.address[index]),
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
                        var request = BraintreeDropInRequest(
                            tokenizationKey: sandboxKey,
                            collectDeviceData: true,
                            paypalRequest: BraintreePayPalRequest(
                                amount: '10.00', displayName: 'ABCD'),
                            cardEnabled: true);

                        var result = await BraintreeDropIn.start(request);
                        if (result != null) {
                          String url =
                              'http://10.0.2.2:5001/final-project-3176a/us-central1/paypalPayment';

                          var response = await http.post(Uri.parse(
                              '${url}?payment_method_nonce=${result.paymentMethodNonce.nonce}&device_data=${result.deviceData}'));

                          var payResult = jsonDecode(response.body);
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(payResult['result']),
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
