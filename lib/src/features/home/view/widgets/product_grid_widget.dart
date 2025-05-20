import 'package:bazaro_cs/src/features/admin/model/item_model.dart';
import 'package:bazaro_cs/src/features/details/view/details_view.dart';
import 'package:bazaro_cs/src/features/home/controller/home_crl.dart';
import 'package:bazaro_cs/src/features/home/view/widgets/product_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductGridWidget extends StatelessWidget {
  final HomeCrl controller;
  final String searchQuery;
  final String selectedCategory;

  const ProductGridWidget({
    super.key,
    required this.controller,
    required this.searchQuery,
    required this.selectedCategory,
  });

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<ItemsModel>>(
      stream: controller.itemsStream(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting || controller.isLoading) {
          return const Center(
            child: CircularProgressIndicator(color: Colors.white),
          );
        }

        if (snapshot.hasError) {
          return Center(
            child: Text(
              'حدث خطأ: ${snapshot.error}',
              style: const TextStyle(color: Colors.white70, fontSize: 16),
              textAlign: TextAlign.center,
            ),
          );
        }

        final allItems = snapshot.data ?? [];

        if (allItems.isEmpty) {
          return const Center(
            child: Text(
              'لا توجد منتجات متاحة حاليًا',
              style: TextStyle(color: Colors.white70, fontSize: 16),
            ),
          );
        }

        // Filter items based on search query and selected category
        List<ItemsModel> filteredItems = allItems.where((item) {
          final matchesSearch =
              searchQuery.isEmpty ||
              item.title.toLowerCase().contains(
                    searchQuery.toLowerCase(),
                  ) ||
              item.description.toLowerCase().contains(
                    searchQuery.toLowerCase(),
                  );

          final matchesCategory =
              selectedCategory == 'الكل' || item.type == selectedCategory;

          return matchesSearch && matchesCategory;
        }).toList();

        if (filteredItems.isEmpty) {
          return Center(
            child: Text(
              searchQuery.isNotEmpty
                  ? 'لا توجد نتائج للبحث: "$searchQuery"'
                  : 'لا توجد منتجات في قسم "$selectedCategory"',
              style: const TextStyle(color: Colors.white70, fontSize: 16),
              textAlign: TextAlign.center,
            ),
          );
        }

        return GridView.builder(
          padding: const EdgeInsets.all(16),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: .48,
            mainAxisSpacing: 10,
            crossAxisSpacing: 10,
          ),
          itemCount: filteredItems.length,
          itemBuilder: (context, index) {
            final item = filteredItems[index];
            return GestureDetector(
              onTap: () {
                Get.to(() => DetailsView(itemsModel: item));
              },
              child: ProductCard(item: item),
            );
          },
        );
      },
    );
  }
}