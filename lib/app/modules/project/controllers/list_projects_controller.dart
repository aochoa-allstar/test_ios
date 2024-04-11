import 'package:get/get.dart';
import 'package:onax_app/app/data/models/api_response_model.dart';
import 'package:onax_app/app/data/models/project_model.dart';
import 'package:onax_app/app/data/repositories/projects_repository.dart';

class ListProjectsController extends GetxController {
  final ProjectsRepository projectsRepository = Get.find();

  final projects = Rx<List<Project>>([]);

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() async {
    super.onReady();
    await fetchProjects();
  }

  @override
  void onClose() {
    super.onClose();
  }

  Future<void> fetchProjects() async {
    projects.value = await projectsRepository
        .getAllProjects()
        .then((ApiResponse response) => response.data);
  }
}
