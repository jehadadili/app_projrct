import 'package:bazaro_cs/src/features/home/view/widgets/build_product_details.dart';
import 'package:bazaro_cs/src/features/home/view/widgets/build_product_image.dart';
import 'package:flutter/material.dart';
import 'package:bazaro_cs/src/core/style/color.dart';
import 'package:bazaro_cs/src/features/admin/model/item_model.dart';

class ProductCard extends StatelessWidget {
  final ItemsModel item;

  const ProductCard({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          BuildProductImage(item: item),
          BuildProductDetails(item: item),
        ],
      ),
    );
  }
}
