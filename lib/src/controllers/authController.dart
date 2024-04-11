import 'dart:async';

import 'package:get/get.dart';
import 'package:onax_app/src/controllers/connectionManagerController.dart';
import 'package:onax_app/src/services/sqlite/sqlite_db.dart';
import 'package:onax_app/src/utils/sharePrefs/accountPrefs.dart';

class AuthController extends GetxController {
  late ConnectionManagerController connectionManagerController;
  @override
  void onInit() {
    // TODO: implement onInit
    initDB().then((res) {});
    connectionManagerController = Get.find<ConnectionManagerController>();
    super.onInit();
  }

  @override
  void onReady() async {
    // TODO: implement onReady
    await userIsAuth();
    super.onReady();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    Get.delete<AuthController>();
    super.onClose();
  }

  userIsAuth() async {
    //print('Token User --> ${AccountPrefs.token}');
    /*AccountPrefs.token = '';
    update();*/
    Timer(const Duration(seconds: 4), () {
      if (AccountPrefs.token != '') {
        Get.offNamed('/pages');
      } else {
        Get.offNamed('/login');
      }
    });
  }

  initDB() async {
    await DataBaseSQLite().init();
  }
}
