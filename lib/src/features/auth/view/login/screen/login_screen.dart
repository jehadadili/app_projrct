import 'package:bazaro_cs/src/features/auth/controller/auth_crl.dart';
import 'package:bazaro_cs/src/features/auth/view/login/widgets/email_field.dart';
import 'package:bazaro_cs/src/features/auth/view/login/widgets/forgot_password.dart';
import 'package:bazaro_cs/src/features/auth/view/login/widgets/login_button.dart';
import 'package:bazaro_cs/src/features/auth/view/login/widgets/password_field.dart';
import 'package:bazaro_cs/src/features/auth/view/login/widgets/sign_up_link.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AuthCrl>(
      init: AuthCrl(),
      builder: (crl) {
        return Scaffold(
          backgroundColor: Color(0xff00091e),
          body: Form(
            key: crl.loginFormKey, // لا تستخدم نفس الـ GlobalKey
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width * 0.05,
                  vertical: MediaQuery.of(context).size.height * 0.15,
                ),
                child: Column(
                  children: [
                    LayoutBuilder(
                      builder: (context, constraints) {
                        double logoSize = constraints.maxWidth * 0.7;
                        return Image.asset(
                          "assets/logo.png",
                          width: logoSize,
                          height: logoSize,
                        );
                      },
                    ),
                    SizedBox(height: 25),
                    EmailField(crl: crl), // حقل البريد الإلكتروني
                    SizedBox(height: 20),
                    PasswordField(crl: crl), // حقل كلمة المرور
                    SizedBox(height: 5),
                    ForgotPassword(), // رابط "نسيت كلمة المرور"
                    SizedBox(height: 20),
                    LoginButton(crl: crl), // زر "تسجيل الدخول"
                    SizedBox(height: 20),
                    const SignUpLink(), // رابط "التسجيل"
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
