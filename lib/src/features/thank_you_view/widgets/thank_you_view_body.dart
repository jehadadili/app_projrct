import 'package:bazaro_cs/src/core/style/color.dart';
import 'package:bazaro_cs/src/core/widgets/submit_button.dart';
import 'package:bazaro_cs/src/features/cart/view/cart_view.dart';
import 'package:flutter/material.dart';

class ThankYouViewBody extends StatelessWidget {
  const ThankYouViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Center(
        child: Column(
          children: [
            const SizedBox(height: 90),
            Image.asset("assets/logo.png"),
            const SizedBox(height: 20),
            Text(
              "Your order was \n    succesfull!",
              style: TextStyle(
                color: AppColors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              "You will get a response within \n              a few minutes.",
              style: TextStyle(
                color: AppColors.white,
                fontSize: 18,
                fontWeight: FontWeight.w400,
              ),
            ),
            SizedBox(height: 80),
            SubmitButton(
              text: "Track order",
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return const CartView();
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
