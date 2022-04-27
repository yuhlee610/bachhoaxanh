import 'package:flutter/material.dart';

import '../components/register_form.dart';
import '../constant.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({Key? key}) : super(key: key);

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
                      'Đăng ký ${appName}',
                      style:
                      TextStyle(fontSize: 20, fontWeight: FontWeight.w600, fontFamily: 'Spartan'),
                    ),
                  ),
                  SizedBox(
                    height: 44,
                  ),
                  RegisterForm(),
                  Container(
                    alignment: Alignment.center,
                    margin: EdgeInsets.symmetric(vertical: defaultPadding),
                    child: TextButton(
                      style: TextButton.styleFrom(
                          textStyle: TextStyle(fontSize: 16)),
                      child: Text(
                        'Đã có tài khoản?',
                        style: TextStyle(color: textColor, fontFamily: 'Spartan'),
                      ),
                      onPressed: () {
                        Navigator.pushNamed(context, loginRoute);
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
