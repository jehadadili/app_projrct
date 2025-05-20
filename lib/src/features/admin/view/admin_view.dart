import 'package:bazaro_cs/src/core/style/color.dart';
import 'package:bazaro_cs/src/features/admin/controller/admin_crl.dart';
import 'package:bazaro_cs/src/features/admin/view/widgets/admin_add_item_view.dart';
import 'package:bazaro_cs/src/features/admin/view/widgets/custom_design.dart';
import 'package:bazaro_cs/src/features/admin/view/widgets/custom_my_container.dart';
import 'package:bazaro_cs/src/features/admin/view/widgets/admin_cart_monitor_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AdminView extends StatelessWidget {
  const AdminView({super.key});

  @override
  Widget build(BuildContext context) {
    // Use Get.put here if AdminCrl is not initialized elsewhere, otherwise Get.find is fine.
    // If AdminCrl is initialized higher up the widget tree, Get.find is correct.
    final adminCrl = Get.put(AdminCrl()); // Ensure controller is initialized

    return FutureBuilder(
      future:
          adminCrl.fetchUserItems(), // Load data when the page opens
      builder: (context, snapshot) {
        // Show loading indicator while fetching initial data
        if (snapshot.connectionState == ConnectionState.waiting && adminCrl.itemsList.isEmpty) {
          return const Scaffold(
             backgroundColor: Color(0xff00091e),
             body: Center(child: CircularProgressIndicator()),
          );
        }

        // Show error if initial fetch fails
        if (snapshot.hasError) {
          return Scaffold(
             backgroundColor: const Color(0xff00091e),
             body: Center(child: Text("Error loading items: ${snapshot.error}", style: const TextStyle(color: Colors.white))),
          );
        }

        // Use GetBuilder to react to updates in AdminCrl
        return GetBuilder<AdminCrl>(
          builder: (admincrl) {
            return Scaffold(
              backgroundColor: const Color(0xff00091e),
              appBar: AppBar(
                 backgroundColor: const Color(0xff00091e),
                 elevation: 0,
                 title: const Text('لوحة تحكم الأدمن', style: TextStyle(color: Colors.white)),
                 centerTitle: true,
                 iconTheme: const IconThemeData(color: Colors.white), // Ensure back button is white if needed
                 actions: [
                   // Add the cart monitoring icon button here
                   IconButton(
                     icon: const Icon(Icons.shopping_cart_checkout, color: Colors.white),
                     tooltip: 'مراقبة سلات المستخدمين',
                     onPressed: () {
                       // Navigate to the cart monitor view
                       Get.to(() => const AdminCartMonitorView());
                     },
                   ),
                 ],
              ),
              body: Column(
                children: [
                  // const SizedBox(height: 60), // Removed, AppBar provides spacing
                  const CustomDesign(), // Consider if this is still needed with AppBar
                  Expanded(
                    child:
                        admincrl.itemsList.isEmpty
                            ? const Center(
                              child: Text(
                                "لا يوجد عناصر حالياً",
                                style: TextStyle(color: AppColors.white),
                              ),
                            )
                            : RefreshIndicator( // Add RefreshIndicator for pull-to-refresh
                                onRefresh: () => admincrl.fetchUserItems(),
                                child: ListView.builder(
                                  itemCount: admincrl.itemsList.length,
                                  itemBuilder: (context, index) {
                                    final item = admincrl.itemsList[index];
                                    return Padding(
                                      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                                      child: CustomMyContainer(
                                        image: item.image,
                                        titel: item.title,
                                        description: item.description,
                                        quintity: item.quintity,
                                        onPressedelet:
                                            () => admincrl.deleteItem(item.id),
                                      ),
                                    );
                                  },
                                ),
                              ),
                  ),
                ],
              ),
              floatingActionButton: FloatingActionButton(
                onPressed: () async {
                  // Navigate to add item view
                  await Get.to(() => const AdminAddItemView());
                  // After returning from add item view, refresh the list
                  await admincrl.fetchUserItems();
                },
                backgroundColor: AppColors.error,
                tooltip: 'إضافة منتج جديد', // Consider a different color like deepPurpleAccent
                child: const Icon(Icons.add, color: Colors.white, size: 30),
              ),
            );
          },
        );
      },
    );
  }
}

