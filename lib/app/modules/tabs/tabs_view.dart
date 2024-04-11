import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:onax_app/app/data/enums/user_types_enum.dart';
import 'package:onax_app/app/modules/tabs/tabs_controller.dart';
import 'package:onax_app/app/routes/app_pages.dart';

class Tabs extends StatelessWidget {
  final TabsController controller = Get.find();

  final TextStyle unselectedLabelStyle = TextStyle(
    color: Colors.white.withOpacity(0.5),
    fontWeight: FontWeight.w500,
    fontSize: 12,
  );

  final TextStyle selectedLabelStyle = TextStyle(
    color: Colors.white,
    fontWeight: FontWeight.w500,
    fontSize: 12,
  );

  buildBottomNavigationMenu(BuildContext context, TabsController controller) {
    return Obx(
      () => BottomNavigationBar(
        showUnselectedLabels: true,
        showSelectedLabels: true,
        onTap: controller.changeTabIndex,
        currentIndex: controller.tabIndex.value,
        backgroundColor: Color.fromRGBO(36, 54, 101, 1.0),
        unselectedItemColor: Colors.white.withOpacity(0.5),
        selectedItemColor: Colors.white,
        unselectedLabelStyle: unselectedLabelStyle,
        selectedLabelStyle: selectedLabelStyle,
        // View notes on about this bit on the controller
        // items: controller.flowSpecificTabs[controller.session.value!.userType]!,
        items: controller.session.value!.userType == UserTypes.worker
            ? [
                BottomNavigationBarItem(
                  icon: Container(
                    margin: EdgeInsets.only(bottom: 4),
                    child: Icon(Icons.home, size: 20),
                  ),
                  label: 'tabs_home'.tr,
                  backgroundColor: Color.fromRGBO(36, 54, 101, 1.0),
                ),
                BottomNavigationBarItem(
                  icon: Container(
                    margin: EdgeInsets.only(bottom: 4),
                    child: Icon(Icons.description, size: 20),
                  ),
                  label: 'tabs_jsas'.tr,
                  backgroundColor: Color.fromRGBO(36, 54, 101, 1.0),
                ),
                BottomNavigationBarItem(
                  icon: Container(
                    margin: EdgeInsets.only(bottom: 4),
                    child: Icon(Icons.construction, size: 20),
                  ),
                  label: 'tabs_projects'.tr,
                  backgroundColor: Color.fromRGBO(36, 54, 101, 1.0),
                )
              ]
            : [
                BottomNavigationBarItem(
                  icon: Container(
                    margin: EdgeInsets.only(bottom: 4),
                    child: Icon(Icons.home, size: 20),
                  ),
                  label: 'tabs_home'.tr,
                  backgroundColor: Color.fromRGBO(36, 54, 101, 1.0),
                ),
                BottomNavigationBarItem(
                  icon: Container(
                    margin: EdgeInsets.only(bottom: 4),
                    child: Icon(Icons.account_circle, size: 20),
                  ),
                  label: 'tabs_account'.tr,
                  backgroundColor: Color.fromRGBO(36, 54, 101, 1.0),
                )
              ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () => Get.toNamed(Routes.ACCOUNT),
            icon: Column(
              children: [
                Icon(
                  Icons.manage_accounts,
                  size: 30,
                  color: Color.fromRGBO(36, 54, 101, 1.0),
                ),
              ],
            ),
          )
        ],
        title: Container(
          margin: EdgeInsets.only(bottom: 16),
          child: Image.asset(
            'assets/img/logotype.png',
            scale: 1,
            width: 48,
            height: 48,
          ),
        ),
      ),
      bottomNavigationBar: buildBottomNavigationMenu(context, controller),
      body: Obx(
        () => IndexedStack(
          index: controller.tabIndex.value,
          children:
              controller.flowSpecificPages[controller.session.value!.userType]!,
        ),
      ),
    );
  }
}
