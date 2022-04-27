import 'package:flutter/material.dart';

import '../components/login_form.dart';
import '../constant.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Column(
                children: [
                  SizedBox(height: 36),
                  Container(
                    alignment: Alignment.center,
                    child: Image.asset('assets/images/logo.png'),
                  ),
                  SizedBox(
                    height: 128,
                  ),
                  Container(
                    alignment: Alignment.center,
                    child: Text(
                      'Đăng nhập ${appName}',
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600, fontFamily: 'Spartan'),
                    ),
                  ),
                  SizedBox(
                    height: 44,
                  ),
                  LoginForm(),
                  SizedBox(
                    height: defaultPadding,
                  ),
                  Divider(
                    indent: defaultPadding,
                    endIndent: defaultPadding,
                  ),
                  SizedBox(
                    height: defaultPadding,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Image.asset('assets/images/fb.png'),
                      SizedBox(
                        width: defaultPadding / 2,
                      ),
                      Image.asset('assets/images/gg.png')
                    ],
                  ),
                  Container(
                    alignment: Alignment.center,
                    margin: EdgeInsets.symmetric(vertical: defaultPadding),
                    child: TextButton(
                      style: TextButton.styleFrom(
                          textStyle: TextStyle(fontSize: 16, fontFamily: 'Spartan')),
                      child: Text(
                        'Tạo tài khoản',
                        style: TextStyle(color: textColor, fontFamily: 'Spartan'),
                      ),
                      onPressed: () {
                        Navigator.pushNamed(context, registerRoute);
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
