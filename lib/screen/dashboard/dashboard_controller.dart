import 'package:get/get.dart';
import 'package:synkrama/firebase_services/auth_service.dart';
import 'package:synkrama/screen/auth_screen/auth_screen.dart';
import 'package:synkrama/screen/home_screen/home_screen.dart';
import 'package:synkrama/screen/profile_screen/profile_screen.dart';

import '../order_screen/order_screen.dart';

class DashboardController extends GetxController {

  final selectedIndex = 0.obs;

  final screens = const [
    HomeScreen(),
    OrderScreen(),
    ProfileScreen()
  ];

  void changeScreen(int index) {
    selectedIndex.value = index;
  }

  void logout() async {
    await AuthService.auth.signOut();
    Get.to(() => const AuthScreen());
  }
}