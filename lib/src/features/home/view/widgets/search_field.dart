import 'package:flutter/material.dart';
import 'package:bazaro_cs/src/core/widgets/my_text_field.dart';

class SearchWidget extends StatelessWidget {
  final Function(String)? onSearch;
  
  const SearchWidget({
    super.key,
    this.onSearch,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: MyTextField(
        onChanged: onSearch,
        validator: (p0) => null,
        hintText: 'ابحث عن منتجات...',
        prefixIcon: const Icon(Icons.search, color: Colors.grey),
      ),
    );
  }
}