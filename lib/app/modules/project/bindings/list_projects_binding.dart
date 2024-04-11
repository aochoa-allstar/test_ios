import 'package:get/get.dart';
import 'package:onax_app/app/data/providers/local/projects_local_provider.dart';
import 'package:onax_app/app/data/providers/server/projects_server_provider.dart';
import 'package:onax_app/app/data/repositories/projects_repository.dart';

import 'package:onax_app/app/modules/project/controllers/list_projects_controller.dart';

class ListProjectsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ListProjectsController>(
      () => ListProjectsController(),
    );

    Get.put<ProjectsRepository>(
      ProjectsRepository(
        serverProvider: Get.put(ProjectsServerProvider()),
        localProvider: Get.put(ProjectsLocalProvider()),
      ),
    );
  }
}
