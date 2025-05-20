import 'package:bazaro_cs/src/features/payment_details/controller/payment_method_controller.dart';
import 'package:bazaro_cs/src/features/admin/controller/admin_create_crl.dart';
import 'package:bazaro_cs/src/features/admin/controller/admin_crl.dart';
import 'package:bazaro_cs/src/features/auth/controller/auth_crl.dart';
import 'package:bazaro_cs/src/features/cart/controller/cart_crl.dart';
import 'package:bazaro_cs/src/features/home/controller/home_crl.dart';
import 'package:get/get.dart';

class MyBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(AuthCrl());

    Get.put(AdminCreateCrl());
    Get.put(PaymentMethodController());
    Get.put(AdminCrl());
    Get.put(HomeCrl());
    Get.put(CartCrl());
  }
}
