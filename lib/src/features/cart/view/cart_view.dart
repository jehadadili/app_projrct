import 'package:bazaro_cs/src/core/style/color.dart';
import 'package:bazaro_cs/src/features/cart/controller/cart_crl.dart';
import 'package:bazaro_cs/src/features/cart/view/widgets/custom_body_design.dart';
import 'package:bazaro_cs/src/features/cart/view/widgets/my_container.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CartView extends StatelessWidget {
  const CartView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CartCrl>(
      init: CartCrl()..fetchOrders(), // مباشرة نجيب الأوردرز هنا
      builder: (crl) {
        return Scaffold(
          backgroundColor: const Color(0xff00091e),
          appBar: AppBar(
            backgroundColor: const Color(0xff00091e),
            iconTheme: IconThemeData(color: AppColors.white),
            elevation: 0,
            title: Text(
              "سلة المشتريات",
              style: TextStyle(color: AppColors.white),
            ),
            centerTitle: true,
          ),
          body: crl.isLoading
              ? const Center(child: CircularProgressIndicator()) // لو في تحميل
              : Column(
                  children: [
                    Expanded(
                      child: crl.orederitem.isEmpty
                          ? const Center(
                              child: Text(
                                'لا يوجد منتجات في السلة',
                                style: TextStyle(color: Colors.white),
                              ),
                            )
                          : ListView.builder(
                              itemCount: crl.orederitem.length,
                              itemBuilder: (context, index) {
                                final item = crl.orederitem[index];
                                return Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: MyContainer(
                                    image: item.image,
                                    titel: item.title,
                                    pries: item.quintity,
                                    orderTime: item.orderTime,
                                    orderData: item.orderData,
                                    item: item,
                                    onQuantityChanged: (newQuantity) {
                                      // Update quantity in database
                                      crl.updateItemQuantity(item.id, newQuantity);
                                    },
                                    onPressed: () async {
                                      await crl.deleteItem(item.id);
                                    },
                                  ),
                                );
                              },
                            ),
                    ),
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: CustomBodyDesign(),
                    ),
                  ],
                ),
        );
      },
    );
  }
}