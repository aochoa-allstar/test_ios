import "package:flutter/material.dart";
import "package:get/get.dart";
import "package:onax_app/app/data/models/api_response_model.dart";
import "package:onax_app/app/data/models/customer_model.dart";
import "package:onax_app/app/data/models/project_model.dart";
import "package:onax_app/app/data/models/session_model.dart";
import "package:onax_app/app/data/models/shift_model.dart";
import "package:onax_app/app/data/models/ticket_model.dart";
import "package:onax_app/app/data/models/worker_model.dart";
import "package:onax_app/app/data/repositories/company_men_repository.dart";
import "package:onax_app/app/data/repositories/customers_repository.dart";
import "package:onax_app/app/data/repositories/equipments_repository.dart";
import "package:onax_app/app/data/repositories/projects_repository.dart";
import "package:onax_app/app/data/repositories/shifts_repository.dart";
import "package:onax_app/app/data/repositories/tickets_repository.dart";
import "package:onax_app/app/data/repositories/workers_repository.dart";
import "package:onax_app/app/modules/driverLocations/controllers/create_driver_location_controller.dart";
import "package:onax_app/app/routes/app_pages.dart";
import "package:onax_app/core/services/preferences_service.dart";

class HomeController extends GetxController {
  final ShiftsRepository shiftsRepository = Get.find();
  final TicketsRepository ticketsRepository = Get.find();
  final ProjectsRepository projectsRepository = Get.find();
  final WorkersRepository workersRepository = Get.find();
  final CustomersRepository customersRepository = Get.find();

  //Aditional repositories for offline mode
  final EquipmentsRepository equipmentRepository = Get.find();
  final CompanyMenRepository companyMenRepository = Get.find();

  final PreferencesService preferences = Get.find();

  final shift = Rx<Shift?>(null);
  final tickets = Rx<List<Ticket>>([]);
  final activeTicket = Rx<Ticket?>(null);
  final projects = RxList<Project>([]);
  final activeTicketStep = Rx<int>(0);

  final currentWorker = Rxn<UserWorker>();
  final currentCustomer = Rxn<Customer>();

  final loading = false.obs;

  final CreateDriverLocationController locationController = Get.put(CreateDriverLocationController());

  @override
  void onInit() {
    locationController.startLocationUpdates();
    super.onInit();
  }

  @override
  void onReady() async {
    await fetchInfo();
    super.onReady();
    fetchAditionalInfoForOffline();
  }

  @override
  void onClose() {
    super.onClose();
  }

  Future<void> fetchInfo() async {
    loading.value = true;
    getWorker();
    shift.value = await shiftsRepository
        .getCurrentShift()
        .then((ApiResponse response) => response.data);
    activeTicket.value = await ticketsRepository
        .getActiveTicket()
        .then((ApiResponse response) => response.data);
    projects.value = await projectsRepository
        .getAllProjects()
        .then((ApiResponse response) => response.data);
    addProjectInfoToCurrentTicket();
    getActiveTicketStep();
    tickets.value = await ticketsRepository
        .getTicketHistory()
        .then((ApiResponse response) => response.data);
    addProjectInfoToTickets();

    loading.value = false;
  }

  //Is used for the offline mode population
  Future<void> fetchAditionalInfoForOffline() async {
    await equipmentRepository.getTrucks();
    await equipmentRepository.getAllEquipments();
    await workersRepository.getHelpers();
    await workersRepository.getSupervisors();
    await workersRepository.getWorkerTypes();
    await companyMenRepository.getAllCompanyMen();
  }

  //TODO: add translation to the alert messages
  void finishShift() {
    if (activeTicket.value == null) {
      Get.defaultDialog(
        backgroundColor: Colors.white,
        titlePadding: EdgeInsets.only(top: 32),
        title: "Finish Shift",
        barrierDismissible: false,
        titleStyle: TextStyle(fontWeight: FontWeight.bold),
        contentPadding:
            EdgeInsets.only(top: 16, bottom: 24, left: 24, right: 24),
        radius: 8,
        middleText: "Are you sure you want to finish your current shift?",
        cancel: FilledButton(
          onPressed: () => Get.back(),
          child: Text("Close"),
          style: ButtonStyle(
            backgroundColor: MaterialStatePropertyAll(Colors.red.shade400),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(8)),
              ),
            ),
          ),
        ),
        confirm: FilledButton(
          onPressed: () async => await shiftsRepository.finishShift().then(
              (ApiResponse response) => response.success == true
                  ? Get.offAllNamed(Routes.TABS)
                  : null),
          child: Text("Finish Shift"),
          style: ButtonStyle(
            backgroundColor: MaterialStatePropertyAll(Colors.green.shade300),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(8)),
              ),
            ),
          ),
        ),
      );
    } else {
      Get.defaultDialog(
        backgroundColor: Colors.white,
        titlePadding: EdgeInsets.only(top: 32),
        barrierDismissible: false,
        title: "Alert",
        titleStyle: TextStyle(fontWeight: FontWeight.bold),
        contentPadding:
            EdgeInsets.only(top: 16, bottom: 24, left: 24, right: 24),
        radius: 8,
        middleText: "Can't finish your shift while having an active ticket.",
        cancel: FilledButton(
          onPressed: () => Get.back(),
          child: Text("Close"),
          style: ButtonStyle(
            backgroundColor: MaterialStatePropertyAll(Colors.red.shade400),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(8)),
              ),
            ),
          ),
        ),
      );
    }
  }

  void addProjectInfoToTickets() {
    tickets.value.forEach((ticket) {
      ticket.project = projects.firstWhere((project) {
        return project.id == ticket.projectId;
      }, orElse: () => Project(id: null, name: null));
    });
    tickets.refresh();
  }

  void addProjectInfoToCurrentTicket() {
    activeTicket.value?.project = projects.firstWhere((project) {
      return project.id == activeTicket.value?.projectId;
    }, orElse: () => Project(id: null, name: null));
    activeTicket.refresh();
  }

  void getWorker() async {
    final Session session = preferences.getSession();
    final int id = session.userId;
    currentWorker.value = await workersRepository
        .getWorkerById(id)
        .then((ApiResponse response) => response.data);

    //TODO: Check if the endpoint is working properly
    //If we dont send the customer id, it will return the customer that the worker is assigned to ???
    List<Customer> listOfCustomers = await customersRepository
        .getCustomers()
        .then((ApiResponse response) => response.data);

    currentCustomer.value = listOfCustomers.first;
  }

  void getActiveTicketStep() {
    if (activeTicket.value == null) return;
    if (activeTicket.value!.departTimestamp != null) {
      activeTicketStep.value = 1;
    }
    if (activeTicket.value!.arrivedTimestamp != null) {
      activeTicketStep.value = 2;
    }
    if (activeTicket.value!.finishedTimestamp != null) {
      activeTicketStep.value = 3;
    }
    activeTicketStep.refresh();
  }
}
