import 'package:bazaro_cs/src/features/auth/controller/auth_crl.dart';
import 'package:bazaro_cs/src/features/cart/view/cart_view.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:bazaro_cs/src/core/style/color.dart';
import 'package:get/get.dart';

class GreetingHeader extends StatefulWidget {
  const GreetingHeader({super.key});

  @override
  State<GreetingHeader> createState() => _GreetingHeaderState();
}

class _GreetingHeaderState extends State<GreetingHeader> {
  String? username;

  @override
  void initState() {
    super.initState();
    getUsername();
  }

  Future<void> getUsername() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      final doc =
          await FirebaseFirestore.instance
              .collection('users')
              .doc(user.uid)
              .get();
      setState(() {
        username = doc.data()?['username'] ?? 'Admin';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Hi ${username ?? ''}!",
            style: const TextStyle(
              color: AppColors.background,
              fontSize: 25,
              fontWeight: FontWeight.bold,
            ),
          ),
          Row(
            children: [
              IconButton(
                onPressed: () {
                  Get.to(() => CartView());
                },
                icon: const Icon(
                  Icons.card_travel,
                  color: AppColors.background,
                ),
              ),
              IconButton(
                onPressed: () async {
                  Get.find<AuthCrl>().signOut();
                },
                icon: const Icon(Icons.logout, color: AppColors.background),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
