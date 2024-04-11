import 'package:get/get.dart';
import 'package:onax_app/app/data/providers/local/company_men_local_provider.dart';
import 'package:onax_app/app/data/providers/local/customers_local_provider.dart';
import 'package:onax_app/app/data/providers/local/equipments_local_provider.dart';
import 'package:onax_app/app/data/providers/local/projects_local_provider.dart';
import 'package:onax_app/app/data/providers/local/shifts_local_provider.dart';
import 'package:onax_app/app/data/providers/local/tickets_local_provider.dart';
import 'package:onax_app/app/data/providers/local/workers_local_provider.dart';
import 'package:onax_app/app/data/providers/server/company_men_server_provider.dart';
import 'package:onax_app/app/data/providers/server/customers_server_provider.dart';
import 'package:onax_app/app/data/providers/server/equipments_server_provider.dart';
import 'package:onax_app/app/data/providers/server/projects_server_provider.dart';
import 'package:onax_app/app/data/providers/server/shifts_server_provider.dart';
import 'package:onax_app/app/data/providers/server/tickets_server_provider.dart';
import 'package:onax_app/app/data/providers/server/workers_server_provider.dart';
import 'package:onax_app/app/data/repositories/company_men_repository.dart';
import 'package:onax_app/app/data/repositories/customers_repository.dart';
import 'package:onax_app/app/data/repositories/equipments_repository.dart';
import 'package:onax_app/app/data/repositories/projects_repository.dart';
import 'package:onax_app/app/data/repositories/shifts_repository.dart';
import 'package:onax_app/app/data/repositories/tickets_repository.dart';
import 'package:onax_app/app/data/repositories/workers_repository.dart';
import 'package:onax_app/app/modules/home/controllers/home_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(() => HomeController());
    Get.put<ShiftsRepository>(
      ShiftsRepository(
        serverProvider: Get.put(ShiftsServerProvider()),
        localProvider: Get.put(ShiftsLocalProvider()),
      ),
    );
    Get.put<TicketsRepository>(
      TicketsRepository(
        serverProvider: Get.put(TicketsServerProvider()),
        localProvider: Get.put(TicketsLocalProvider()),
      ),
    );
    Get.put<ProjectsRepository>(ProjectsRepository(
      serverProvider: Get.put(ProjectsServerProvider()),
      localProvider: Get.put(ProjectsLocalProvider()),
    ));
    Get.put<WorkersRepository>(WorkersRepository(
      serverProvider: Get.put(WorkersServerProvider()),
      localProvider: Get.put(WorkersLocalProvider()),
    ));
    Get.put<CustomersRepository>(CustomersRepository(
      serverProvider: Get.put(CustomersServerProvider()),
      localProvider: Get.put(CustomersLocalProvider()),
    ));
    Get.put<EquipmentsRepository>(EquipmentsRepository(
      serverProvider: Get.put(EquipmentsServerProvider()),
      localProvider: Get.put(EquipmentsLocalProvider()),
    ));
    Get.put<CompanyMenRepository>(CompanyMenRepository(
      serverProvider: Get.put(CompanyMenServerProvider()),
      localProvider: Get.put(CompanyMenLocalProvider()),
    ));
  }
}
