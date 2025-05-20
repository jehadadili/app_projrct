import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:bazaro_cs/src/features/admin/view/widgets/image_picker_section.dart';
import 'package:bazaro_cs/src/features/admin/view/widgets/product_info_fields.dart';
import 'package:bazaro_cs/src/features/admin/view/widgets/submit_product_button.dart';
import 'package:bazaro_cs/src/features/admin/controller/admin_create_crl.dart';
import 'package:bazaro_cs/src/core/style/color.dart';

class AdminAddItemView extends StatelessWidget {
  const AdminAddItemView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AdminCreateCrl>(
      init: AdminCreateCrl(),
      builder: (createCrl) {
        return Scaffold(
          backgroundColor: const Color(0xff00091e),
          appBar: AppBar(
            iconTheme: const IconThemeData(color: AppColors.background),
            centerTitle: true,
            title: const Text(
              'إضافة منتج جديد',
              style: TextStyle(
                color: AppColors.background,
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),
            backgroundColor: const Color(0xff00091e),
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Column(
              children: const [
                ImagePickerSection(),
                SizedBox(height: 24),
                ProductInfoFields(),
                SizedBox(height: 32),
                SubmitProductButton(),
              ],
            ),
          ),
        );
      },
    );
  }
}
