import 'package:get/get.dart';
import 'package:onax_app/app/data/models/api_response_model.dart';
import 'package:onax_app/app/data/models/project_model.dart';
import 'package:onax_app/app/data/models/ticket_model.dart';
import 'package:onax_app/app/data/repositories/projects_repository.dart';
import 'package:onax_app/app/data/repositories/tickets_repository.dart';

class ListTicketsController extends GetxController {
  final TicketsRepository ticketsRepository = Get.find();
  final ProjectsRepository projectsRepository = Get.find();

  final tickets = Rx<List<Ticket>>([]);
  final projects = RxList<Project>([]);

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
    getTickets();
  }

  @override
  void onClose() {
    super.onClose();
  }

  Future<void> getTickets() async {
    projects.value = await projectsRepository
        .getAllProjects()
        .then((ApiResponse response) => response.data);
    tickets.value = await ticketsRepository
        .getAllTickets()
        .then((ApiResponse response) => response.data);
    addProjectInfoToTickets();
  }

  void addProjectInfoToTickets() {
    tickets.value.forEach((ticket) {
      ticket.project = projects.firstWhere((project) {
        return project.id == ticket.projectId;
      }, orElse: () => Project(id: null, name: null));
    });
    tickets.refresh();
  }
}
