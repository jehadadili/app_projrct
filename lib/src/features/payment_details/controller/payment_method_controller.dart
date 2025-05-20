import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../thank_you_view/view/thank_you_view.dart';

class PaymentMethodController extends GetxController {
  final List<String> paymentMethodItem = const [
    "assets/cart.png",
    "assets/images.png",
  ];
  var activeIndex = 0;
  final formKey = GlobalKey<FormState>().obs;
  var autovalidateMode = AutovalidateMode.disabled.obs;

  void setActiveIndex(int index) {
    activeIndex = index;
    update();
  }

  void validateAndSave(BuildContext context) {
    if (formKey.value.currentState!.validate()) {
      formKey.value.currentState!.save();
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) {
            return const ThankYouView();
          },
        ),
      );
      autovalidateMode.value = AutovalidateMode.always;

      update();
    }
  }
}
