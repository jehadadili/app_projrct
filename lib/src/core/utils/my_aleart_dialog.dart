import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:bazaro_cs/src/core/widgets/submit_button.dart';

void myAlertDialog({String text = ''}) {
  Get.defaultDialog(
    title: '',
    content: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          text,
          style: const TextStyle(
            fontSize: 25,
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    ),
    confirm: SubmitButton(
      text: 'ok',
      onPressed: () {
        Get.back(); // يغلق الـ dialog
      },
    ),
  );
}
