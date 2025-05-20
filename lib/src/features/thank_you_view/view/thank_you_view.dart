import 'package:bazaro_cs/src/core/style/color.dart';
import 'package:bazaro_cs/src/features/thank_you_view/widgets/thank_you_view_body.dart';
import 'package:flutter/material.dart';

class ThankYouView extends StatelessWidget {
  const ThankYouView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff00091e),

      appBar: AppBar(
        title: Text(
          "Order Success",
          style: TextStyle(
            color: AppColors.white,
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
        ),
        iconTheme: IconThemeData(color: AppColors.white),
        centerTitle: true,
        backgroundColor: Color(0xff00091e),
      ),
      body: const ThankYouViewBody(),
    );
  }
}
