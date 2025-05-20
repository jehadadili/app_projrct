// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:bazaro_cs/src/core/style/color.dart';

class CategorySelector extends StatefulWidget {
  final Function(String) onCategorySelected;
  final String selectedCategory;

  const CategorySelector({
    super.key,
    required this.onCategorySelected,
    required this.selectedCategory,
  });

  @override
  State<CategorySelector> createState() => _CategorySelectorState();
}

class _CategorySelectorState extends State<CategorySelector> {
final List<String> categories = [
    'الكل',
    'إلكترونيات',
    'حلويات',
    'ملابس',
    'عطور',
    'اكسسوارات',
  ];
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      color: const Color(0xff00091e), // Match background
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        itemBuilder: (context, index) {
          final category = categories[index];
          final isSelected = category == widget.selectedCategory;
          return GestureDetector(
            onTap: () => widget.onCategorySelected(category),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
              decoration: BoxDecoration(
                color: isSelected ? Colors.deepPurpleAccent : AppColors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Center(
                child: Text(
                  category,
                  style: TextStyle(
                    color: isSelected ? AppColors.white : AppColors.black,
                    fontWeight:
                        isSelected ? FontWeight.bold : FontWeight.normal,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
