import 'package:bachhoaxanh/providers/OrderProvider.dart';
import 'package:bachhoaxanh/providers/UserProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../constant.dart';
import '../models/order.dart';
import '../models/user.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({Key? key}) : super(key: key);
  TextEditingController nameController = new TextEditingController();
  TextEditingController phoneController = new TextEditingController();
  TextEditingController currentPasswordController = new TextEditingController();
  TextEditingController newPasswordController = new TextEditingController();

  String? validatePhone(String phone) {
    String pattern = r'(^(?:[+0]9)?[0-9]{10,12}$)';
    RegExp regExp = new RegExp(pattern);

    // at any time, we can get the text from _controller.value.text
    final phone = phoneController.text;
    // Note: you can do your own custom validation here
    // Move this logic this outside the widget for more testable code
    if (phone.isEmpty) {
      return 'Hãy nhập số điện thoại';
    }
    if (!regExp.hasMatch(phone)) {
      return 'Hãy nhập số điện thoại hợp lệ';
    }
    // return null if the text is valid
    return null;
  }

  String getLevel(List<Order> orders) {
    int purchasedAmount = 0;
    orders.forEach((element) {
      purchasedAmount = purchasedAmount + element.totalPrice;
    });

    if(purchasedAmount <= 2000000)
      return bronzeLevel;

    if(purchasedAmount <= 5000000)
      return silverLevel;

    if(purchasedAmount <= 10000000)
      return goldLevel;

    return diamondLevel;
  }

  @override
  Widget build(BuildContext context) {
    UserModel user = Provider.of<UserProvider>(context).user;
    nameController.text = user.name;
    phoneController.text = user.phoneNumber;

    var orders = Provider.of<OrderProvider>(context).orders;
    String level = getLevel(orders);

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        iconTheme: IconThemeData(color: Colors.black),
        centerTitle: true,
        title: Text(
          'Thông tin tài khoản',
          style: TextStyle(fontFamily: 'Spartan', color: Colors.black),
        ),
      ),
      body: SafeArea(
          child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(defaultPadding - 4),
          child: Column(
            children: [
              Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(90),
                    child: Image.network(
                      'https://ui-avatars.com/api/?name=${user.name}&&background=40BFFF&&color=ffffff',
                      fit: BoxFit.cover,
                      width: 72,
                      height: 72,
                    ),
                  ),
                  SizedBox(
                    width: 16,
                  ),
                  Expanded(
                      child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        user.name,
                        style: TextStyle(
                            fontFamily: 'Spartan',
                            fontWeight: FontWeight.w600,
                            fontSize: 18),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Text(
                        user.email,
                        style: TextStyle(
                            fontFamily: 'Spartan',
                            fontWeight: FontWeight.w600,
                            color: textLightColor,
                            fontSize: 14),
                      ),
                    ],
                  ))
                ],
              ),
              SizedBox(
                height: 32,
              ),
              GestureDetector(
                onTap: () {
                  print('tap Email');
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  child: Row(
                    children: [
                      Icon(
                        Icons.star,
                        color: primaryColor,
                        size: 30,
                      ),
                      SizedBox(
                        width: 16,
                      ),
                      Text(
                        'Cấp độ',
                        style: TextStyle(
                            fontFamily: 'Spartan', fontWeight: FontWeight.w600),
                      ),
                      Expanded(
                        child: Text(
                          level,
                          textAlign: TextAlign.right,
                          style: TextStyle(
                              fontFamily: 'Spartan',
                              fontWeight: FontWeight.w600,
                              color: textColor),
                        ),
                      ),
                      SizedBox(
                        width: 16,
                      ),
                      Icon(
                        Icons.arrow_forward_ios_outlined,
                        color: primaryColor,
                        size: 20,
                      )
                    ],
                  ),
                ),
              ),
              GestureDetector(
                onTap: () => showDialog(
                    context: context,
                    builder: (BuildContext context) => AlertDialog(
                          title: Text("Cập nhật tên"),
                          content: TextField(
                            controller: nameController,
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
                                    .updateName(user.id, nameController.text);
                                Navigator.pop(context, 'Add');
                              },
                              child: const Text('Lưu'),
                            ),
                          ],
                        )),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  child: Row(
                    children: [
                      Icon(
                        Icons.person,
                        color: primaryColor,
                        size: 30,
                      ),
                      SizedBox(
                        width: 16,
                      ),
                      Text(
                        'Tên họ',
                        style: TextStyle(
                            fontFamily: 'Spartan', fontWeight: FontWeight.w600),
                      ),
                      Expanded(
                        child: Text(
                          user.name,
                          textAlign: TextAlign.right,
                          style: TextStyle(
                              fontFamily: 'Spartan',
                              fontWeight: FontWeight.w600,
                              color: textLightColor),
                        ),
                      ),
                      SizedBox(
                        width: 16,
                      ),
                      Icon(
                        Icons.arrow_forward_ios_outlined,
                        color: primaryColor,
                        size: 20,
                      )
                    ],
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, updateAddressRoute);
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  child: Row(
                    children: [
                      Icon(
                        Icons.home,
                        color: primaryColor,
                        size: 30,
                      ),
                      SizedBox(
                        width: 16,
                      ),
                      Expanded(
                        child: Text(
                          'Địa chỉ',
                          style: TextStyle(
                              fontFamily: 'Spartan',
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                      SizedBox(
                        width: 16,
                      ),
                      Icon(
                        Icons.arrow_forward_ios_outlined,
                        color: primaryColor,
                        size: 20,
                      )
                    ],
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  print('tap Email');
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  child: Row(
                    children: [
                      Icon(
                        Icons.mail_outline_outlined,
                        color: primaryColor,
                        size: 30,
                      ),
                      SizedBox(
                        width: 16,
                      ),
                      Text(
                        'Email',
                        style: TextStyle(
                            fontFamily: 'Spartan', fontWeight: FontWeight.w600),
                      ),
                      Expanded(
                        child: Text(
                          user.email,
                          textAlign: TextAlign.right,
                          style: TextStyle(
                              fontFamily: 'Spartan',
                              fontWeight: FontWeight.w600,
                              color: textLightColor),
                        ),
                      ),
                      SizedBox(
                        width: 16,
                      ),
                      Icon(
                        Icons.arrow_forward_ios_outlined,
                        color: primaryColor,
                        size: 20,
                      )
                    ],
                  ),
                ),
              ),
              GestureDetector(
                onTap: () => showDialog(
                    context: context,
                    builder: (BuildContext context) => AlertDialog(
                          title: Text("Cập nhật SĐT"),
                          content: TextField(
                            controller: phoneController,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Số điện thoại',
                            ),
                          ),
                          actions: <Widget>[
                            TextButton(
                              onPressed: () => Navigator.pop(context, 'Cancel'),
                              child: const Text('Hủy'),
                            ),
                            TextButton(
                              onPressed: () {
                                String? message =
                                validatePhone(phoneController.text);
                                if (message != null) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(message),
                                    ),
                                  );
                                } else {
                                  Provider.of<UserProvider>(context,
                                      listen: false)
                                      .updatePhone(
                                      user.id, phoneController.text);
                                  Navigator.pop(context, 'Save');
                                }
                              },
                              child: const Text('Lưu'),
                            ),
                          ],
                        )),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  child: Row(
                    children: [
                      Icon(
                        Icons.phone_android_outlined,
                        color: primaryColor,
                        size: 30,
                      ),
                      SizedBox(
                        width: 16,
                      ),
                      Text(
                        'Phone Number',
                        style: TextStyle(
                            fontFamily: 'Spartan', fontWeight: FontWeight.w600),
                      ),
                      Expanded(
                        child: Text(
                          user.phoneNumber,
                          textAlign: TextAlign.right,
                          style: TextStyle(
                              fontFamily: 'Spartan',
                              fontWeight: FontWeight.w600,
                              color: textLightColor),
                        ),
                      ),
                      SizedBox(
                        width: 16,
                      ),
                      Icon(
                        Icons.arrow_forward_ios_outlined,
                        color: primaryColor,
                        size: 20,
                      )
                    ],
                  ),
                ),
              ),
              GestureDetector(
                onTap: () => showDialog(
                    context: context,
                    builder: (BuildContext context) => AlertDialog(
                          title: Text("Cập nhật mật khẩu"),
                          content: SizedBox(
                            height: 160,
                            child: Column(
                              children: [
                                TextField(
                                  controller: currentPasswordController,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText: 'Mật khẩu hiện tại',
                                  ),
                                ),
                                SizedBox(height: 10,),
                                TextField(
                                  controller: newPasswordController,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText: 'Mật khẩu mới',
                                  ),
                                )
                              ],
                            ),
                          ),
                          actions: <Widget>[
                            TextButton(
                              onPressed: () => Navigator.pop(context, 'Cancel'),
                              child: const Text('Hủy'),
                            ),
                            TextButton(
                              onPressed: ()  {
                                Provider.of<UserProvider>(context,
                                    listen: false)
                                    .changePassword(currentPasswordController.text, newPasswordController.text);
                                Navigator.pop(context, 'Save');
                              },
                              child: const Text('Lưu'),
                            ),
                          ],
                        )),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  child: Row(
                    children: [
                      Icon(
                        Icons.lock_outline,
                        color: primaryColor,
                        size: 30,
                      ),
                      SizedBox(
                        width: 16,
                      ),
                      Text(
                        'Change Password',
                        style: TextStyle(
                            fontFamily: 'Spartan', fontWeight: FontWeight.w600),
                      ),
                      Expanded(
                        child: Text(
                          '*********',
                          textAlign: TextAlign.right,
                          style: TextStyle(
                              fontFamily: 'Spartan',
                              fontWeight: FontWeight.w600,
                              color: textLightColor),
                        ),
                      ),
                      SizedBox(
                        width: 16,
                      ),
                      Icon(
                        Icons.arrow_forward_ios_outlined,
                        color: primaryColor,
                        size: 20,
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      )),
    );
  }
}
