import 'package:get/get.dart';
import 'package:onax_app/app/data/providers/local/auth_local_provider.dart';
import 'package:onax_app/app/data/providers/server/auth_server_provider.dart';
import 'package:onax_app/app/data/repositories/auth_repository.dart';

import '../controllers/recover_password_controller.dart';

class RecoverPasswordBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RecoverPasswordController>(() => RecoverPasswordController());
    Get.lazyPut<AuthRepository>(() => AuthRepository(
      serverProvider: Get.put(AuthServerProvider()),
      localProvider: Get.put(AuthLocalProvider()),
    ));
  }
}
