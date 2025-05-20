import 'package:bazaro_cs/src/core/style/color.dart';
import 'package:bazaro_cs/src/features/admin/model/item_model.dart';
import 'package:bazaro_cs/src/features/details/widgets/custom_design_details.dart';
import 'package:bazaro_cs/src/features/home/controller/home_crl.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DetailsView extends StatelessWidget {
  const DetailsView({super.key, required this.itemsModel});
  final ItemsModel itemsModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff00091e),

      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Details",
          style: TextStyle(
            color: AppColors.white,
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
        ),
        elevation: 0,
        iconTheme: IconThemeData(color: AppColors.white, size: 30),
        backgroundColor: const Color(0xff00091e),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width * 0.03,
          vertical: MediaQuery.of(context).size.height * 0.03,
        ),
        child: GetBuilder<HomeCrl>(
          init: HomeCrl(),
          builder: (crl) {
            return CustomDesignDetails(
              title: itemsModel.title,
              image: itemsModel.image,
              description: itemsModel.description,
              quintity: itemsModel.quintity,
              onAddToCart: (quantity) {
                // Create a copy of the item with the selected quantity
                ItemsModel itemToAdd = ItemsModel(
                  id: itemsModel.id,
                  title: itemsModel.title,
                  description: itemsModel.description,
                  image: itemsModel.image,
                  quintity: itemsModel.quintity,
                  quantity: quantity,
                  userId: '',
                  orderTime: '',
                  orderData: '',
                  type: '', // Set the quantity
                );

                // Add to cart
                crl.orderItem(context, itemToAdd);
              },
            );
          },
        ),
      ),
    );
  }
}
