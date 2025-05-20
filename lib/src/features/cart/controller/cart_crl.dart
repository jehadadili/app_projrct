import 'dart:developer';
import 'package:bazaro_cs/src/core/utils/app_strings.dart';
import 'package:bazaro_cs/src/features/admin/model/item_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

class CartCrl extends GetxController {
  List<ItemsModel> orederitem = [];
  bool isLoading = false;
  final RxString _userId = ''.obs;

  String get userId => _userId.value;

  @override
  void onInit() {
    super.onInit();
    _setCurrentUserId();
    _setupAuthListener();
    fetchOrders();
  }

  void _setupAuthListener() {
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user != null) {
        _userId.value = user.uid;
        fetchOrders(); 
      } else {
        _userId.value = '';
        clearCart(); 
      }
    });
  }

  void _setCurrentUserId() {
    User? currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser != null) {
      _userId.value = currentUser.uid;
    }
  }

  Future<List<ItemsModel>> fetchOrders() async {
    orederitem.clear();
    try {
      isLoading = true;
      update();

      if (_userId.value.isEmpty) {
        isLoading = false;
        update();
        return orederitem;
      }

      QuerySnapshot<Map<String, dynamic>> getData =
          await FirebaseFirestore.instance
              .collection(AppStrings.orders)
              .where('user_id', isEqualTo: _userId.value)
              .get();

      for (var doc in getData.docs) {
        orederitem.add(ItemsModel.fromQuery(doc));
      }
    } catch (e) {
      log("Error fetching orders: $e");
      Get.snackbar(
        'خطأ',
        'فشل في تحميل سلة المشتريات: $e',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isLoading = false;
      update(); 
    }
    return orederitem;
  }

  Future<bool> addToCart(ItemsModel item) async {
    try {
      isLoading = true;
      update();

      if (_userId.value.isEmpty) {
        Get.snackbar(
          'تنبيه',
          'يرجى تسجيل الدخول أولاً لإضافة منتجات إلى السلة',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.orange,
          colorText: Colors.white,
        );
        return false;
      }

      item.userId = _userId.value;

      DocumentReference docRef = await FirebaseFirestore.instance
          .collection(AppStrings.orders)
          .add(item.toMap());

      await docRef.update({'id': docRef.id});

      item.id = docRef.id;
      orederitem.add(item);

      Get.snackbar(
        'نجاح',
        'تمت إضافة المنتج إلى السلة',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white,
        duration: const Duration(seconds: 2),
      );

      return true;
    } catch (e) {
      log("Error adding to cart: $e");
      Get.snackbar(
        'خطأ',
        'فشل في إضافة المنتج إلى السلة: $e',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return false;
    } finally {
      isLoading = false;
      update();
    }
  }

  Future<void> updateItemQuantity(String itemId, int newQuantity) async {
    try {
      isLoading = true;
      update();

      if (_userId.value.isEmpty) {
        return;
      }

      int itemIndex = orederitem.indexWhere((item) => item.id == itemId);
      if (itemIndex != -1) {
        orederitem[itemIndex].quantity = newQuantity;

       
        QuerySnapshot<Map<String, dynamic>> querySnapshot =
            await FirebaseFirestore.instance
                .collection(AppStrings.orders)
                .where('id', isEqualTo: itemId)
                .where(
                  'user_id',
                  isEqualTo: _userId.value,
                ) 
                .get();

        if (querySnapshot.docs.isNotEmpty) {
          for (var doc in querySnapshot.docs) {
            await doc.reference.update({'quantity': newQuantity});
          }
        }
      }
    } catch (e) {
      log("Error updating quantity: $e");
      Get.snackbar(
        'خطأ',
        'فشل في تحديث الكمية: $e',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isLoading = false;
      update();
    }
  }

  Future<void> deleteItem(String orderId) async {
    try {
      isLoading = true;
      update();

      if (_userId.value.isEmpty) {
        return;
      }

      QuerySnapshot<Map<String, dynamic>> querySnapshot =
          await FirebaseFirestore.instance
              .collection(AppStrings.orders)
              .where('id', isEqualTo: orderId)
              .where(
                'user_id',
                isEqualTo: _userId.value,
              ) 
              .get();

      if (querySnapshot.docs.isNotEmpty) {
        for (var doc in querySnapshot.docs) {
          await doc.reference.delete();
        }
        orederitem.removeWhere((order) => order.id == orderId);

        Get.snackbar(
          'نجاح',
          'تم حذف المنتج من السلة',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green,
          colorText: Colors.white,
          duration: const Duration(seconds: 2),
        );
      } else {
        Get.snackbar(
          'خطأ',
          'لم يتم العثور على المنتج لحذفه',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      log("Error deleting order: $e");
      Get.snackbar(
        'خطأ',
        'فشل في حذف المنتج: $e',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isLoading = false;
      update();
    }
  }

  double getTotalPrice() {
    double total = 0.0;
    for (var item in orederitem) {
      try {
        double price = double.parse(item.quintity);
        total += price * item.quantity;
      } catch (e) {
        log("Error parsing price: ${item.quintity}");
      }
    }
    return total;
  }

 
  void clearCart() {
    orederitem.clear();
    update();
  }
}
