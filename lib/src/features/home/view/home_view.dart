import 'package:bazaro_cs/src/features/home/controller/home_crl.dart';
import 'package:bazaro_cs/src/features/home/view/widgets/category_selector.dart'; // Import the new widget
import 'package:bazaro_cs/src/features/home/view/widgets/greeting_header.dart';
import 'package:bazaro_cs/src/features/home/view/widgets/product_grid_widget.dart';
import 'package:bazaro_cs/src/features/home/view/widgets/search_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final HomeCrl homeCrl = Get.put(HomeCrl());
  String searchQuery = '';
  String selectedCategory = 'الكل';

  void _launchWhatsApp() async {
    const String phoneNumber = '+962781070361'; 
    const String messageText =
        'مرحبًا، أود طلب إضافة منتج جديد إلى التطبيق.'; 
    final String encodedMessage = Uri.encodeComponent(messageText);
    final Uri whatsappUrl = Uri.parse(
      "https://wa.me/$phoneNumber?text=$encodedMessage",
    );

    if (await canLaunchUrl(whatsappUrl)) {
      await launchUrl(whatsappUrl, mode: LaunchMode.externalApplication);
    } else {
     
      if (mounted) {
      
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('تعذر فتح واتساب. يرجى التأكد من تثبيته.'),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff00091e),
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 20),
            const GreetingHeader(),
            SearchWidget(
              onSearch: (query) {
                setState(() {
                  searchQuery = query;
                });
              },
            ),
            const SizedBox(height: 10), // Add some spacing
            // Add the CategorySelector widget here
            CategorySelector(
              selectedCategory: selectedCategory,
              onCategorySelected: (category) {
                setState(() {
                  selectedCategory = category;
                });
              },
            ),
            const SizedBox(height: 10), // Add some spacing
            // Pass the selected category to the ProductGridWidget
            Expanded(
              // Ensure ProductGridWidget is within an Expanded
              child: ProductGridWidget(
                controller: homeCrl,
                searchQuery: searchQuery,
                selectedCategory:
                    selectedCategory, // Pass the selected category
              ),
            ),
          ],
        ),
      ),
      // Add the FloatingActionButton for adding product via WhatsApp
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _launchWhatsApp,
        backgroundColor: Colors.green, // WhatsApp color
        icon: const Icon(
          FontAwesomeIcons.whatsapp,
          color: Colors.white,
        ), // WhatsApp icon
        label: const Text('إضافة منتج', style: TextStyle(color: Colors.white)),
        tooltip: 'تواصل لإضافة منتج جديد',
      ),
    );
  }
}
