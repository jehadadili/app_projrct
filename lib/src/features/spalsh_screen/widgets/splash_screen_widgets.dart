import 'package:bazaro_cs/src/core/style/color.dart';
import 'package:bazaro_cs/src/core/widgets/custom_widget_loading.dart';
import 'package:flutter/material.dart';

class SplashScreenWidgets extends StatelessWidget {
  const SplashScreenWidgets({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff00091e),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset("assets/logo.png"),
            const SizedBox(height: 50),

            const Text(
              "Plan your day, shop easily!",
              style: TextStyle(
                color: AppColors.white,
                fontSize: 18,
                fontWeight: FontWeight.w400,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 30),
            const CustomWidgetLoading(color: AppColors.white, size: 150),
          ],
        ),
      ),
    );
  }
}
