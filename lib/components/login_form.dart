import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../constant.dart';
import '../providers/UserProvider.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({Key? key}) : super(key: key);

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: Column(
          children: [
            Container(
                alignment: Alignment.center,
                height: 64,
                margin: EdgeInsets.symmetric(horizontal: defaultPadding),
                padding: EdgeInsets.symmetric(horizontal: defaultPadding / 2),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(5),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.15),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: Offset(0, 3),
                      )
                    ]),
                child: Row(
                  children: [
                    Image.asset('assets/images/username.png'),
                    SizedBox(
                      width: 17,
                    ),
                    Expanded(
                      child: TextFormField(
                        controller: emailController,
                        validator: (String? value) {
                          if (value == null || value.isEmpty) {
                            return 'Hãy nhập email';
                          }
                          if (!(RegExp(
                              r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                              .hasMatch(value))) {
                            return 'Hãy nhập email hợp lệ';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          hintText: 'Email',
                          hintStyle: TextStyle(
                              color: textColor.withOpacity(0.5),
                              fontSize: 16,
                              fontFamily: 'Spartan'),
                          enabledBorder: InputBorder.none,
                          focusedBorder: InputBorder.none,
                        ),
                        style: TextStyle(fontSize: 16, fontFamily: 'Spartan'),
                      ),
                    ),
                  ],
                )),
            SizedBox(
              height: defaultPadding,
            ),
            Container(
                alignment: Alignment.center,
                height: 64,
                margin: EdgeInsets.symmetric(horizontal: defaultPadding),
                padding: EdgeInsets.symmetric(horizontal: defaultPadding / 2),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(5),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.15),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: Offset(0, 3),
                      )
                    ]),
                child: Row(
                  children: [
                    Image.asset('assets/images/pass.png'),
                    SizedBox(
                      width: 17,
                    ),
                    Expanded(
                      child: TextFormField(
                        controller: passwordController,
                        obscureText: true,
                        enableSuggestions: false,
                        autocorrect: false,
                        validator: (String? value) {
                          if (value == null || value.isEmpty) {
                            return 'Hãy nhập mật khẩu';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          hintText: 'Mật khẩu',
                          hintStyle: TextStyle(
                              color: textColor.withOpacity(0.5), fontSize: 16),
                          enabledBorder: InputBorder.none,
                          focusedBorder: InputBorder.none,
                        ),
                        style: TextStyle(fontSize: 16, fontFamily: 'Spartan'),
                      ),
                    ),
                  ],
                )),
            Container(
              alignment: Alignment.center,
              margin: EdgeInsets.symmetric(vertical: defaultPadding),
              child: TextButton(
                style: TextButton.styleFrom(textStyle: TextStyle(fontSize: 16)),
                child: Text(
                  'Quên mật khẩu?',
                  style: TextStyle(color: textColor, fontFamily: 'Spartan'),
                ),
                onPressed: () {},
              ),
            ),
            Container(
              height: 64,
              width: double.infinity,
              margin: EdgeInsets.symmetric(horizontal: defaultPadding),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    primary: primaryColor,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5))),
                child: Text(
                  'Đăng nhập',
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 18,
                      fontFamily: 'Spartan'),
                ),
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    bool shouldNavigate = await Provider.of<UserProvider>(context, listen: false).signIn(emailController.text, passwordController.text);
                    if (shouldNavigate) {
                      Navigator.pushNamed(context, homeRoute);
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text('Login failed!'),
                      ),);
                    }
                  }
                },
              ),
            ),
          ],
        ));
  }
}
