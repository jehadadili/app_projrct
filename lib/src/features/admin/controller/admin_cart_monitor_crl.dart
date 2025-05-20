import 'dart:developer';
import 'package:bazaro_cs/src/core/utils/app_strings.dart';
import 'package:bazaro_cs/src/features/admin/model/item_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class AdminCartMonitorCrl extends GetxController {
  bool isLoading = false;
  Map<String, List<ItemsModel>> userCarts = {};
  Map<String, String> userNames = {};

  @override
  void onInit() {
    super.onInit();
    fetchAllUserCarts();
  }

  Future<void> fetchAllUserCarts() async {
    try {
      isLoading = true;
      update();
      userCarts.clear();
      userNames.clear();

      QuerySnapshot<Map<String, dynamic>> cartSnapshot =
          await FirebaseFirestore.instance.collection(AppStrings.orders).get();

      if (cartSnapshot.docs.isEmpty) {
        log('No cart items found in the orders collection.');
        isLoading = false;
        update();
        return;
      }

      Set<String> userIds = {};
      for (var doc in cartSnapshot.docs) {
        try {
          ItemsModel item = ItemsModel.fromQuery(doc);
          if (item.userId.isNotEmpty) {
            userIds.add(item.userId);
            if (userCarts.containsKey(item.userId)) {
              userCarts[item.userId]!.add(item);
            } else {
              userCarts[item.userId] = [item];
            }
          } else {
            log('Cart item found with empty user_id: ${doc.id}');
          }
        } catch (e) {
          log('Error processing cart item ${doc.id}: $e');
        }
      }

      if (userIds.isNotEmpty) {
        QuerySnapshot<Map<String, dynamic>> usersSnapshot =
            await FirebaseFirestore.instance
                .collection(AppStrings.users)
                .where(FieldPath.documentId, whereIn: userIds.toList())
                .get();

        for (var userDoc in usersSnapshot.docs) {
          userNames[userDoc.id] =
              userDoc.data()['username'] ??
              'Unknown User'; 
        }
      }

      log('Fetched carts for users: ${userCarts.keys.join(', ')}');
      log('Fetched usernames: $userNames');
    } catch (e) {
      log("Error fetching all user carts: $e");
      Get.snackbar('Error', 'Failed to load user carts: $e');
    } finally {
      isLoading = false;
      update();
    }
  }
}
