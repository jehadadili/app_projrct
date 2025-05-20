import 'package:bazaro_cs/src/core/style/color.dart';
import 'package:bazaro_cs/src/core/widgets/submit_button.dart';
import 'package:bazaro_cs/src/features/admin/controller/admin_create_crl.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';

class ImagePickerSection extends StatelessWidget {
  const ImagePickerSection({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AdminCreateCrl>(
      builder: (createCrl) {
        return SizedBox(
          width: double.infinity,
          height: 180,
          child: InkWell(
            onTap: () {
              createCrl.selectImage();
            },
            child: Visibility(
              visible: createCrl.itemImage.path.isEmpty,
              replacement: Stack(
                fit: StackFit.expand,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.file(createCrl.itemImage, fit: BoxFit.cover),
                  ),
                  Positioned(
                    top: 8,
                    right: 8,
                    child: Container(
                      decoration: BoxDecoration(
                        color: AppColors.primary,
                        shape: BoxShape.circle,
                      ),
                      child: IconButton(
                        icon: const Icon(
                          Icons.clear,
                          color: Colors.white,
                          size: 24,
                        ),
                        onPressed: () {
                          createCrl.clearData();
                        },
                      ),
                    ),
                  ),
                ],
              ),
              child: Container(
                decoration: BoxDecoration(
                  color: const Color(0xFF172139),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.cloud_upload,
                        size: 48,
                        color: AppColors.primary,
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'صورة المنتج',
                        style: TextStyle(
                          color: AppColors.background,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 120),
                        child: SubmitButton(
                          onPressed: () {
                            createCrl.selectImage();
                          },
                          text: 'رفع صورة',
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
