import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:onax_app/app/data/enums/user_types_enum.dart';
import 'package:onax_app/app/data/models/session_model.dart';
import 'package:onax_app/app/modules/account/views/account_view.dart';
import 'package:onax_app/app/modules/home/views/company_man_home_view.dart';
import 'package:onax_app/app/modules/home/views/worker_home_view.dart';
import 'package:onax_app/app/modules/jsa/views/list_jsas_view.dart';
import 'package:onax_app/app/modules/project/views/list_projects_view.dart';
import 'package:onax_app/core/services/preferences_service.dart';
import 'package:onax_app/core/services/sqlite_service.dart';

class TabsController extends GetxController {
  PreferencesService preferences = Get.find();
  SQLiteService dataBaseSQLite = Get.find();

  final tabIndex = Rx<int>(0);
  final session = Rx<Session?>(null);

  // Previous Implementation of the user type specific tab items
  // Note: the labels won't get translated because they get generated on build,
  //       check if there's any workaround or keep writing the tab items on the view
  //
  // Map<UserTypes, List<BottomNavigationBarItem>> flowSpecificTabs = {
  //   UserTypes.worker: [
  //     ComposableNavItem(label: 'tabs_home'.tr, icon: Icons.home).build(),
  //     ComposableNavItem(label: 'tabs_jsas'.tr, icon: Icons.description).build(),
  //     ComposableNavItem(label: 'tabs_account'.tr, icon: Icons.account_circle)
  //         .build(),
  //   ],
  //   UserTypes.companyMan: [
  //     ComposableNavItem(label: 'tabs_home'.tr, icon: Icons.home).build(),
  //     ComposableNavItem(label: 'tabs_account'.tr, icon: Icons.account_circle)
  //         .build(),
  //   ],
  // };

  Map<UserTypes, List<Widget>> flowSpecificPages = {
    UserTypes.worker: [
      WorkerHomeView(),
      ListJSAsView(),
      ListProjectsView(),
    ],
    UserTypes.companyMan: [
      CompanyManHomeView(),
      AccountView(),
    ],
  };

  void changeTabIndex(int index) {
    tabIndex.value = index;
  }

  @override
  void onInit() {
    session.value = preferences.getSession();
    super.onInit();
  }

  @override
  void dispose() {
    super.dispose();
  }
}

// class ComposableNavItem {
//   String label;
//   IconData icon;

//   ComposableNavItem({
//     required this.label,
//     required this.icon,
//   });

//   BottomNavigationBarItem build() {
//     return BottomNavigationBarItem(
//       icon: Container(
//         margin: EdgeInsets.only(bottom: 4),
//         child: Icon(
//           this.icon,
//           size: 20,
//         ),
//       ),
//       label: this.label,
//       backgroundColor: Color.fromRGBO(36, 54, 101, 1.0),
//     );
//   }
// }
