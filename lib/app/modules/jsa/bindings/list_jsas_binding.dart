import 'package:get/get.dart';
import 'package:onax_app/app/data/providers/local/customers_local_provider.dart';
import 'package:onax_app/app/data/providers/local/jsas_local_provider.dart';
import 'package:onax_app/app/data/providers/server/customers_server_provider.dart';
import 'package:onax_app/app/data/providers/server/jsas_server_provider.dart';
import 'package:onax_app/app/data/repositories/customers_repository.dart';
import 'package:onax_app/app/data/repositories/jsas_repository.dart';

import '../controllers/list_jsas_controller.dart';

class ListJSAsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ListJSAsController>(
      () => ListJSAsController(),
    );
    Get.put<JSAsRepository>(
      JSAsRepository(
        serverProvider: Get.put(JSAsServerProvider()),
        localProvider: Get.put(JSAsLocalProvider()),
      ),
    );
    Get.put<CustomersRepository>(
      CustomersRepository(
        serverProvider: Get.put(CustomersServerProvider()),
        localProvider: Get.put(CustomersLocalProvider()),
      ),
    );
  }
}
