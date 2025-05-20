import 'package:bazaro_cs/src/core/validator/validater.dart';
import 'package:bazaro_cs/src/core/widgets/my_text_field.dart';
import 'package:bazaro_cs/src/features/auth/controller/auth_crl.dart';
import 'package:flutter/material.dart';

class EmailField extends StatelessWidget {
  final AuthCrl crl;
  const EmailField({super.key, required this.crl});

  @override
  Widget build(BuildContext context) {
    return MyTextField(
      keyboardType: TextInputType.emailAddress,
      hintText: "Email Address",
      onChanged: (newVal) {
        crl.setEmail(newVal);
      },
      validator: (email) {
        return MyValidator.emailValidator(email);
      },
    );
  }
}
