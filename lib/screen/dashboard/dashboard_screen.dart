import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:synkrama/screen/dashboard/dashboard_controller.dart';
import 'package:synkrama/string_constant.dart';


class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final dashC = Get.put(DashboardController());
    return Scaffold(
      appBar: AppBar(title: Text(KStrings.appName),actions: [IconButton(onPressed: dashC.logout, icon: const Icon(Icons.logout))],),
      body: Obx(()=> dashC.screens.elementAt(dashC.selectedIndex.value)),
      bottomNavigationBar: Obx(()=> BottomNavigationBar(
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home_filled),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.cube_box_fill),
              label: 'Orders',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Profile',
            ),
          ],
          type: BottomNavigationBarType.fixed,
          currentIndex: dashC.selectedIndex.value,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          onTap: dashC.changeScreen,
          unselectedIconTheme: const IconThemeData(
            color: Colors.grey
          ),
          selectedIconTheme: const IconThemeData(
            color: Colors.black
          ),
        ),
      ),
    );
  }
}
