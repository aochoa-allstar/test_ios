import 'package:get/get.dart';
import 'package:onax_app/app/data/providers/local/workers_local_provider.dart';
import 'package:onax_app/app/data/providers/server/workers_server_provider.dart';
import 'package:onax_app/app/data/repositories/workers_repository.dart';
import 'package:onax_app/app/modules/shift/controllers/create_shift_controller.dart';

class CreateShiftBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CreateShiftController>(
      () => CreateShiftController(),
    );
    Get.lazyPut<WorkersRepository>(
      () => WorkersRepository(
        serverProvider: Get.put(WorkersServerProvider()),
        localProvider: Get.put(WorkersLocalProvider()),
      ),
    );
  }
}
