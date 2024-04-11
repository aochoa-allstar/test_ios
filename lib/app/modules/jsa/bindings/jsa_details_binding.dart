import 'package:get/get.dart';
import 'package:onax_app/app/data/providers/local/jsas_local_provider.dart';
import 'package:onax_app/app/data/providers/server/jsas_server_provider.dart';
import 'package:onax_app/app/data/repositories/jsas_repository.dart';
import 'package:onax_app/app/modules/jsa/controllers/jsa_details_controller.dart';

class JSADetailsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<JSADetailsController>(
      () => JSADetailsController(),
    );
    Get.put<JSAsRepository>(
      JSAsRepository(
        serverProvider: Get.put(JSAsServerProvider()),
        localProvider: Get.put(JSAsLocalProvider()),
      ),
    );
  }
}
