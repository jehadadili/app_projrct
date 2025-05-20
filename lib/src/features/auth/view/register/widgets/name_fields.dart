import 'package:bazaro_cs/src/core/validator/validater.dart';
import 'package:bazaro_cs/src/core/widgets/my_text_field.dart';
import 'package:bazaro_cs/src/features/auth/controller/auth_crl.dart';
import 'package:flutter/material.dart';

class NameFields extends StatelessWidget {
  final AuthCrl crl;
  const NameFields({super.key, required this.crl});

  @override
  Widget build(BuildContext context) {
    return MyTextField(
        keyboardType: TextInputType.name,
      hintText: "User Nmae",
      onChanged: (newVal) {
        crl.setName(newVal);
      },
      validator: (name) {
             return MyValidator.nameValidator(name);
      },
    );
  }
}
