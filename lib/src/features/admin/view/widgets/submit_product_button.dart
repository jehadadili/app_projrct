import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:bazaro_cs/src/core/widgets/custom_widget_loading.dart';
import 'package:bazaro_cs/src/core/widgets/submit_button.dart';
import 'package:bazaro_cs/src/core/style/color.dart';
import 'package:bazaro_cs/src/features/admin/controller/admin_create_crl.dart';

class SubmitProductButton extends StatelessWidget {
  const SubmitProductButton({super.key});

  @override
  Widget build(BuildContext context) {
    final createCrl = Get.find<AdminCreateCrl>();

    return createCrl.isLoading
        ? const CustomWidgetLoading(color: AppColors.error, size: 18)
        : SubmitButton(
            text: 'حفظ المنتج',
            onPressed: () => createCrl.addItem(context),
          );
  }
}
