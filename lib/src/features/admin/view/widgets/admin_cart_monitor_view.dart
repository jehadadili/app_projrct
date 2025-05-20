import 'package:bazaro_cs/src/core/style/color.dart';
import 'package:bazaro_cs/src/features/admin/controller/admin_cart_monitor_crl.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AdminCartMonitorView extends StatelessWidget {
  const AdminCartMonitorView({super.key});

  @override
  Widget build(BuildContext context) {
    final AdminCartMonitorCrl controller = Get.put(AdminCartMonitorCrl());

    return Scaffold(
      backgroundColor: const Color(0xff00091e),
      appBar: AppBar(
        title: const Text(
          'مراقبة سلات المستخدمين',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: const Color(0xff00091e),
        iconTheme: const IconThemeData(color: Colors.white),
        elevation: 0,
      ),
      body: GetBuilder<AdminCartMonitorCrl>(
        builder: (controller) {
          if (controller.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (controller.userCarts.isEmpty) {
            return const Center(
              child: Text(
                'لا توجد سلات مشتريات حالياً.',
                style: TextStyle(color: Colors.white70, fontSize: 18),
              ),
            );
          }

          final userIds = controller.userCarts.keys.toList();

          return ListView.builder(
            itemCount: userIds.length,
            itemBuilder: (context, index) {
              final userId = userIds[index];
              final userCartItems = controller.userCarts[userId]!;
              final userName =
                  controller.userNames[userId] ?? 'مستخدم غير معروف';

              double userTotalPrice = 0.0;
              for (var item in userCartItems) {
                userTotalPrice += item.getTotalPrice();
              }

              return Card(
                color: AppColors.blackText,
                margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                child: ExpansionTile(
                  iconColor: Colors.white,
                  collapsedIconColor: Colors.white70,
                  title: Text(
                    ' $userName : المستخدم ',
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: Text(
                    '${userCartItems.length} منتجات | الإجمالي: ${userTotalPrice.toStringAsFixed(2)}',
                    style: const TextStyle(color: Colors.white70),
                  ),
                  children:
                      userCartItems.map((item) {
                        return ListTile(
                          leading:
                              item.image.isNotEmpty
                                  ? CircleAvatar(
                                    backgroundImage: NetworkImage(item.image),
                                    backgroundColor: Colors.transparent,
                                  )
                                  : const CircleAvatar(
                                    child: Icon(Icons.image_not_supported),
                                  ),
                          title: Text(
                            item.title,
                            style: const TextStyle(color: Colors.white),
                          ),
                          subtitle: Text(
                            'الكمية: ${item.quantity} | السعر: ${item.quintity}',
                            style: const TextStyle(color: Colors.white70),
                          ),
                          trailing: Text(
                            'الإجمالي: ${item.getTotalPrice().toStringAsFixed(2)}',
                            style: const TextStyle(
                              color: Colors.amber,
                            ), 
                          ),
                        );
                      }).toList(),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => controller.fetchAllUserCarts(),
        backgroundColor: Colors.deepPurpleAccent,
        tooltip: 'تحديث السلات',
        child: const Icon(Icons.refresh, color: Colors.white),
      ),
    );
  }
}
