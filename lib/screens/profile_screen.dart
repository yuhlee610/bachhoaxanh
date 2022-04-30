import 'package:bachhoaxanh/providers/UserProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../constant.dart';
import '../models/user.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    UserModel user = Provider.of<UserProvider>(context).user;

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        iconTheme: IconThemeData(color: Colors.black),
        centerTitle: true,
        title: Text(
          'Profile',
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
                  print('tap full name');
                },
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
                        'Full Name',
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
                              fontFamily: 'Spartan', fontWeight: FontWeight.w600),
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
                onTap: () {
                  print('tap phone');
                },
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
                onTap: () {
                  print('tap change password');
                },
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
