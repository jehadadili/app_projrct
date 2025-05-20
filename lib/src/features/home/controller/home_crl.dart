import 'dart:developer';

import 'package:bazaro_cs/src/core/utils/app_strings.dart';
import 'package:bazaro_cs/src/features/cart/controller/cart_crl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../admin/model/item_model.dart';

class HomeCrl extends GetxController {
  List<ItemsModel> itemsList = [];
  bool isLoading = false;
  String? errorMessage;
  Stream<List<ItemsModel>> itemsStream() {
    return FirebaseFirestore.instance
        .collectionGroup(AppStrings.market)
        .snapshots()
        .map(
          (snapshot) =>
              snapshot.docs.map((doc) => ItemsModel.fromQuery(doc)).toList(),
        );
  }

  Future<void> deleteItem(String itemId) async {
    try {
      // محاولة الحذف من مجموعة market
      await FirebaseFirestore.instance
          .collection(AppStrings.market)
          .doc(itemId)
          .delete();
      update();

      // إذا كان المستخدم مسجل دخوله، نحاول الحذف من مجموعته الفرعية أيضاً
      User? currentUser = FirebaseAuth.instance.currentUser;
      if (currentUser != null) {
        await FirebaseFirestore.instance
            .collection(AppStrings.users)
            .doc(currentUser.uid)
            .collection(AppStrings.market)
            .doc(itemId)
            .delete();
        update();
      }

      // حذف العنصر من القائمة المحلية
      itemsList.removeWhere((item) => item.id == itemId);
      update();
    } catch (e) {
      log("خطأ في حذف المنتج: $e");
    }
  }

  Future<void> orderItem(BuildContext context, ItemsModel itemsModel) async {
    try {
      DocumentReference ref =
          FirebaseFirestore.instance.collection(AppStrings.orders).doc();

      User? currentUser = FirebaseAuth.instance.currentUser;
      if (currentUser == null) {
        throw Exception("المستخدم غير مسجل دخوله");
      }

      itemsModel.userId = currentUser.uid;

      // الحصول على الوقت والتاريخ الحاليين
      DateTime now = DateTime.now();

      // تنسيق التاريخ والوقت
      String formattedDate = DateFormat('dd-MM-yyyy').format(now);
      String formattedTime = DateFormat('HH:mm').format(now);

      // تعيين تاريخ ووقت الطلب
      itemsModel.orderData = formattedDate;
      itemsModel.orderTime = formattedTime;

      await ref.set(itemsModel.toMap());
      log('تم إضافة الطلب بنجاح');

      Get.find<CartCrl>().orederitem.add(itemsModel);
      Get.find<CartCrl>().update();

      Get.back();

      // Show success message
      Get.snackbar(
        'تم الإضافة',
        'تمت إضافة ${itemsModel.quantity} قطعة من ${itemsModel.title} إلى السلة',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
    } catch (e) {
      log("خطأ في إضافة الطلب: $e");
      Get.snackbar(
        'خطأ',
        'حدث خطأ أثناء إضافة الطلب: $e',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }
}
