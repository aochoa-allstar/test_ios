import 'package:get/get.dart';
import 'package:onax_app/app/data/providers/local/customers_local_provider.dart';
import 'package:onax_app/app/data/providers/local/destinations_local_provider.dart';
import 'package:onax_app/app/data/providers/local/equipments_local_provider.dart';
import 'package:onax_app/app/data/providers/local/jsas_local_provider.dart';
import 'package:onax_app/app/data/providers/local/projects_local_provider.dart';
import 'package:onax_app/app/data/providers/local/shifts_local_provider.dart';
import 'package:onax_app/app/data/providers/local/workers_local_provider.dart';
import 'package:onax_app/app/data/providers/server/customers_server_provider.dart';
import 'package:onax_app/app/data/providers/server/destinations_server_provider.dart';
import 'package:onax_app/app/data/providers/server/equipments_server_provider.dart';
import 'package:onax_app/app/data/providers/server/jsas_server_provider.dart';
import 'package:onax_app/app/data/providers/server/projects_server_provider.dart';
import 'package:onax_app/app/data/providers/server/shifts_server_provider.dart';
import 'package:onax_app/app/data/providers/server/workers_server_provider.dart';
import 'package:onax_app/app/data/repositories/customers_repository.dart';
import 'package:onax_app/app/data/repositories/destinations_repository.dart';
import 'package:onax_app/app/data/repositories/equipments_repository.dart';
import 'package:onax_app/app/data/repositories/jsas_repository.dart';
import 'package:onax_app/app/data/repositories/projects_repository.dart';
import 'package:onax_app/app/data/repositories/shifts_repository.dart';
import 'package:onax_app/app/data/repositories/workers_repository.dart';
import 'package:onax_app/app/modules/inspection/controllers/create_inspection_controller.dart';

class CreateInspectionBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CreateInspectionController>(
      () => CreateInspectionController(),
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
    Get.put<ProjectsRepository>(
      ProjectsRepository(
        serverProvider: Get.put(ProjectsServerProvider()),
        localProvider: Get.put(ProjectsLocalProvider()),
      ),
    );
    Get.put<WorkersRepository>(
      WorkersRepository(
        serverProvider: Get.put(WorkersServerProvider()),
        localProvider: Get.put(WorkersLocalProvider()),
      ),
    );
    Get.put<EquipmentsRepository>(
      EquipmentsRepository(
        serverProvider: Get.put(EquipmentsServerProvider()),
        localProvider: Get.put(EquipmentsLocalProvider()),
      ),
    );
    Get.put<ShiftsRepository>(
      ShiftsRepository(
        serverProvider: Get.put(ShiftsServerProvider()),
        localProvider: Get.put(ShiftsLocalProvider()),
      ),
    );
    Get.put<DestinationsRepository>(
      DestinationsRepository(
        serverProvider: Get.put(DestinationsServerProvider()),
        localProvider: Get.put(DestinationsLocalProvider()),
      ),
    );
  }
}
