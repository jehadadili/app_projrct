import 'package:bazaro_cs/src/core/style/color.dart';
import 'package:bazaro_cs/src/core/widgets/custom_widget_loading.dart';
import 'package:bazaro_cs/src/core/widgets/submit_button.dart';
import 'package:bazaro_cs/src/features/auth/controller/auth_crl.dart';
import 'package:flutter/material.dart';

class LoginButton extends StatelessWidget {
  final AuthCrl crl;
  const LoginButton({required this.crl, super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child:
          crl.isLoading
              ? Center(
                child: CustomWidgetLoading(color: AppColors.white, size: 50),
              )
              : SubmitButton(
                text: "Log in",
                onPressed: () {
                  crl.logIn(context);
                },
              ),
    );
  }
}
