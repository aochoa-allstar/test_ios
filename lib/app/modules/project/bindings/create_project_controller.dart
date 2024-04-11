import 'package:get/get.dart';
import 'package:onax_app/app/data/providers/local/company_men_local_provider.dart';
import 'package:onax_app/app/data/providers/local/customers_local_provider.dart';
import 'package:onax_app/app/data/providers/local/workers_local_provider.dart';
import 'package:onax_app/app/data/providers/server/company_men_server_provider.dart';
import 'package:onax_app/app/data/providers/server/customers_server_provider.dart';
import 'package:onax_app/app/data/providers/server/workers_server_provider.dart';
import 'package:onax_app/app/data/repositories/company_men_repository.dart';
import 'package:onax_app/app/data/repositories/customers_repository.dart';
import 'package:onax_app/app/data/repositories/workers_repository.dart';
import 'package:onax_app/app/modules/project/controllers/create_project_controller.dart';

class CreateProjectBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CreateProjectController>(
      () => CreateProjectController(),
    );
    Get.put<WorkersRepository>(
      WorkersRepository(
        serverProvider: Get.put(WorkersServerProvider()),
        localProvider: Get.put(WorkersLocalProvider()),
      ),
    );
    Get.put<CustomersRepository>(
      CustomersRepository(
        serverProvider: Get.put(CustomersServerProvider()),
        localProvider: Get.put(CustomersLocalProvider()),
      ),
    );
    Get.put<CompanyMenRepository>(
      CompanyMenRepository(
        serverProvider: Get.put(CompanyMenServerProvider()),
        localProvider: Get.put(CompanyMenLocalProvider()),
      ),
    );
  }
}
