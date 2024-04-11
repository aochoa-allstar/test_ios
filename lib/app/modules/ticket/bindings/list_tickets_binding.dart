import 'package:get/get.dart';
import 'package:onax_app/app/data/providers/local/projects_local_provider.dart';
import 'package:onax_app/app/data/providers/local/tickets_local_provider.dart';
import 'package:onax_app/app/data/providers/server/projects_server_provider.dart';
import 'package:onax_app/app/data/providers/server/tickets_server_provider.dart';
import 'package:onax_app/app/data/repositories/projects_repository.dart';
import 'package:onax_app/app/data/repositories/tickets_repository.dart';

import '../controllers/list_tickets_controller.dart';

class ListTicketsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ListTicketsController>(
      () => ListTicketsController(),
    );
    Get.put<TicketsRepository>(
      TicketsRepository(
        serverProvider: Get.put(TicketsServerProvider()),
        localProvider: Get.put(TicketsLocalProvider()),
      ),
    );
    Get.put<ProjectsRepository>(
      ProjectsRepository(
        serverProvider: Get.put(ProjectsServerProvider()),
        localProvider: Get.put(ProjectsLocalProvider()),
      ),
    );
  }
}
