import 'package:bazaro_cs/src/core/style/color.dart';
import 'package:bazaro_cs/src/features/admin/model/item_model.dart';
import 'package:bazaro_cs/src/features/home/view/widgets/whats_app_button.dart';
import 'package:flutter/material.dart';

class BuildProductDetails extends StatelessWidget {
  const BuildProductDetails({super.key, required this.item});
  final ItemsModel item;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            item.title,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
              color: AppColors.blackText,
            ),
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
          ),

          const SizedBox(height: 5),
          Text(
            item.description,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 17,
              color: AppColors.blackText,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          Text(
            '${item.quintity} JOD',
            style: const TextStyle(
              color: AppColors.blackText,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 8),
          WhatsAppButton(
            phoneNumber: item.whatsappNumber,
            productTitle: item.title,
            productPrice: item.quintity,
            imageUrl: item.image,
          ),
          SizedBox(height: 8),
          const SizedBox(width: 4),
          Text(
            item.sellerName,
            style: const TextStyle(
              color: Color.fromRGBO(158, 158, 158, 1),
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
