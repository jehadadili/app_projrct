import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class WhatsAppButton extends StatelessWidget {
  final String phoneNumber;
  final String productTitle;
  final String productPrice;
  final String imageUrl;

  const WhatsAppButton({
    super.key,
    required this.phoneNumber,
    required this.productTitle,
    required this.productPrice,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: _openWatsAppChat,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: const Color(0xFF25D366),
          borderRadius: BorderRadius.circular(4),
        ),
        child: const Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.chat, size: 16, color: Colors.white),
            SizedBox(width: 4),
            Text('تواصل واتساب', style: TextStyle(color: Colors.white)),
          ],
        ),
      ),
    );
  }

  void _openWatsAppChat() async {
    final phone = phoneNumber.replaceAll(RegExp(r'^00'), '');

    final message = Uri.encodeComponent('''
مرحبًا، أود الاستفسار عن المنتج:
📦 الاسم: $productTitle
💰 السعر: JOD $productPrice 
🖼️ صورة المنتج: $imageUrl
    ''');

    final url = Uri.parse("https://wa.me/$phone?text=$message");

    if (await canLaunchUrl(url)) {
      await launchUrl(url, mode: LaunchMode.externalApplication);
    } else {
      Get.snackbar(
        'خطأ',
        'تعذر فتح واتساب',
        backgroundColor: Colors.red,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
        duration: const Duration(seconds: 2),
      );
    }
  }
}
