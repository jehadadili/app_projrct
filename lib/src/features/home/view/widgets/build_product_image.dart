import 'package:bazaro_cs/src/features/admin/model/item_model.dart';
import 'package:flutter/material.dart';

class BuildProductImage extends StatelessWidget {
  const BuildProductImage({super.key, required this.item});
  final ItemsModel item;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 180,
      width: double.infinity,
      decoration: const BoxDecoration(
        color: Color(0xFF2C3551),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(12),
          topRight: Radius.circular(12),
        ),
      ),
      child: ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(12),
          topRight: Radius.circular(12),
        ),
        child: Image.network(
          item.image,
          fit: BoxFit.fill,
          width: double.infinity,
          height: double.infinity,
          errorBuilder:
              (context, error, stackTrace) => const Center(
                child: Icon(Icons.broken_image, color: Colors.grey),
              ),
          loadingBuilder: (context, child, loadingProgress) {
            if (loadingProgress == null) return child;
            return const Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }
}
