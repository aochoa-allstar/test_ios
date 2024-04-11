import 'package:get/get.dart';
import 'package:onax_app/app/data/providers/local/auth_local_provider.dart';
import 'package:onax_app/app/data/providers/server/auth_server_provider.dart';
import 'package:onax_app/app/data/repositories/auth_repository.dart';

import '../controllers/login_controller.dart';

class LoginBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LoginController>(() => LoginController());
    Get.put<AuthRepository>(
      AuthRepository(
        serverProvider: Get.put(AuthServerProvider()),
        localProvider: Get.put(AuthLocalProvider()),
      ),
    );
  }
}
