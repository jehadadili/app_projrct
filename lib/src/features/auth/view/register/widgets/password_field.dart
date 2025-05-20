import 'package:bazaro_cs/src/core/validator/validater.dart';
import 'package:bazaro_cs/src/core/widgets/my_text_field.dart';
import 'package:bazaro_cs/src/features/auth/controller/auth_crl.dart';
import 'package:flutter/material.dart';

class PasswordField extends StatelessWidget {
  final AuthCrl crl;
  const PasswordField({super.key, required this.crl});

  @override
  Widget build(BuildContext context) {
    return MyTextField(
      keyboardType: TextInputType.visiblePassword,
      obscureText: crl.isVisable,
      hintText: "Password",
      onChanged: (newVal) {
        crl.setPassword(newVal);
      },
      validator: (password) {
        return MyValidator.passwordValidator(password);
      },
      onTapSuffixIcon: () {
        crl.setIsVisable();
      },
      suffixIcon: crl.isVisable ? Icons.visibility_off : Icons.visibility,
    );
  }
}
