import 'dart:developer';
import 'package:bazaro_cs/src/core/utils/app_strings.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../model/item_model.dart';

class AdminCrl extends GetxController {
  String? get _currentUserId => FirebaseAuth.instance.currentUser?.uid;

  // جلب العناصر الخاصة بالمستخدم
  CollectionReference<Map<String, dynamic>> get _userItemsRef {
    if (_currentUserId == null) {
      throw Exception('المستخدم غير مسجل دخوله');
    }
    return FirebaseFirestore.instance
        .collection(AppStrings.users)  // استخدم مجموعة المستخدمين
        .doc(_currentUserId)  // استخدم الـ userId كمفتاح للوصول
        .collection(AppStrings.market);  // مجموعة المنتجات الخاصة بالمستخدم
  }

  List<ItemsModel> itemsList = [];

  // تحميل العناصر الخاصة بالمستخدم
  Future<List<ItemsModel>> fetchUserItems() async {
    itemsList.clear();
    try {
      final snapshot = await _userItemsRef.get();

      for (var doc in snapshot.docs) {
        itemsList.add(ItemsModel.fromQuery(doc));
      }
    } catch (e) {
      log("Error fetching items: $e");
    }
    update();
    return itemsList;
  }

  // حذف العنصر من Firestore و Supabase
  Future<void> deleteItem(String itemId) async {
    try {
      final docRef = _userItemsRef.doc(itemId);
      final doc = await docRef.get();

      if (doc.exists) {
        String imageUrl = doc['image'];
        String fileName = imageUrl.split('/').last;

        await Supabase.instance.client.storage.from('market').remove([fileName]);

        await docRef.delete();

        itemsList.removeWhere((item) => item.id == itemId);
        update();
      }
    } catch (e) {
      log("Error deleting item: $e");
    }
  }
}
