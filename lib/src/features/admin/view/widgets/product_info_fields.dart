import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:bazaro_cs/src/core/widgets/my_text_field.dart';
import 'package:bazaro_cs/src/features/admin/controller/admin_create_crl.dart';
import 'package:bazaro_cs/src/features/admin/view/widgets/admin_category_selector.dart';

class ProductInfoFields extends StatelessWidget {
  const ProductInfoFields({super.key});

  @override
  Widget build(BuildContext context) {
    final whatsappController = TextEditingController();
    final createCrl = Get.find<AdminCreateCrl>();

    return GetBuilder<AdminCreateCrl>(
      builder: (controller) => Directionality(
        textDirection: TextDirection.rtl,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const _FieldTitle('اسم المنتج'),
            MyTextField(
              hintText: 'ادخل اسم المنتج',
              onChanged: createCrl.setTitle,
              validator: (_) => null,
            ),
            const SizedBox(height: 16),
            const _FieldTitle('وصف المنتج'),
            MyTextField(
              hintText: 'أدخل وصف المنتج',
              onChanged: createCrl.setDescription,
              validator: (_) => null,
            ),
            const SizedBox(height: 16),
            const _FieldTitle('السعر'),
            MyTextField(
              hintText: 'أدخل سعر المنتج',
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
              onChanged: createCrl.setQuintity,
              validator: (_) => null,
            ),
            const SizedBox(height: 16),
            AdminCategorySelector(
              selectedCategory: controller.type,
              onCategorySelected: (category) {
                controller.setType(category);
              },
            ),
            const SizedBox(height: 16),
            const _FieldTitle('اسم البائع'),
            MyTextField(
              hintText: 'أدخل اسم البائع',
              onChanged: createCrl.setSellerName,
              validator: (_) => null,
            ),
            const SizedBox(height: 16),
            const _FieldTitle('رقم الواتساب'),
            MyTextField(
              controller: whatsappController,
              hintText: 'أدخل الرقم بدون 962',
              keyboardType: TextInputType.phone,
              prefixText: '+962 ',
              onChanged: (value) {
                // بشيل أي صفر من البداية (إذا المستخدم كتبه بالغلط)
                final fullNumber = '962${value.replaceAll(RegExp(r'^0+'), '')}';
                createCrl.setWhatsappNumber(
                  fullNumber,
                ); // هي القيمة اللي بترفع على Firebase
              },
              validator: (_) => null,
            ),
          ],
        ),
      ),
    );
  }
}

class _FieldTitle extends StatelessWidget {
  final String text;
  const _FieldTitle(this.text);

  @override
  Widget build(BuildContext context) {
    return Text(text, style: const TextStyle(color: Colors.white70));
  }
}