import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import 'package:onax_app/app/data/models/api_response_model.dart';
import 'package:onax_app/app/data/models/company_man_model.dart';
import 'package:onax_app/app/data/models/customer_model.dart';
import 'package:onax_app/app/data/models/equipment_model.dart';
import 'package:onax_app/app/data/models/project_model.dart';
import 'package:onax_app/app/data/models/session_model.dart';
import 'package:onax_app/app/data/models/shift_model.dart';
import 'package:onax_app/app/data/models/worker_model.dart';
import 'package:onax_app/app/data/repositories/company_men_repository.dart';
import 'package:onax_app/app/data/repositories/customers_repository.dart';
import 'package:onax_app/app/data/repositories/equipments_repository.dart';
import 'package:onax_app/app/data/repositories/projects_repository.dart';
import 'package:onax_app/app/data/repositories/shifts_repository.dart';
import 'package:onax_app/app/data/repositories/tickets_repository.dart';
import 'package:onax_app/app/data/repositories/workers_repository.dart';
import 'package:onax_app/app/routes/app_pages.dart';
import 'package:onax_app/core/services/preferences_service.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

class CreateTicketController extends GetxController {
  // Services & Repositories
  final PreferencesService preferences = Get.find();
  final TicketsRepository ticketsRepository = Get.find();
  final ShiftsRepository shiftsRepository = Get.find();
  final EquipmentsRepository equipmentsRepository = Get.find();
  final CustomersRepository customersRepository = Get.find();
  final ProjectsRepository projectsRepository = Get.find();
  final CompanyMenRepository companyMenRepository = Get.find();
  final WorkersRepository workersRepository = Get.find();

  // Form controllers and keys
  final createTicketFormBuilderKey = GlobalKey<FormBuilderState>().obs;
  final submitButton = RoundedLoadingButtonController();

  // Dropdown lists
  final currentShift = Rxn<Shift>();
  final customers = List<Customer>.empty(growable: true).obs;
  final projects = List<Project>.empty(growable: true).obs;
  final companyMen = List<CompanyMan>.empty(growable: true).obs;
  final equipments = List<Equipment>.empty(growable: true).obs;
  final helpers = List<UserWorker>.empty(growable: true).obs;
  final workerRoles = List<UserWorker>.empty(growable: true).obs;
  final workers = List<UserWorker>.empty(growable: true).obs;

  final filteredProjects = List<Project>.empty(growable: true).obs;
  final filteredCompanyMen = List<CompanyMan>.empty(growable: true).obs;
  final additionalHelpersList =
      List<Map<String, dynamic>>.empty(growable: true).obs;

  // UI State
  final customerSelected = Rx<bool>(false);
  final selectedCustomer = Rxn<int>();
  final loading = Rx<bool>(true);

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() async {
    currentShift.value = await shiftsRepository
        .getCurrentShift()
        .then((ApiResponse response) => response.data);
    equipments.addAll(await equipmentsRepository
        .getTrucks()
        .then((ApiResponse response) => response.data));
    customers.addAll(await customersRepository
        .getCustomers()
        .then((ApiResponse response) => response.data));
    projects.addAll(await projectsRepository
        .getAllProjects()
        .then((ApiResponse response) => response.data));
    companyMen.addAll(await companyMenRepository
        .getAllCompanyMen()
        .then((ApiResponse response) => response.data));
    helpers.addAll(await workersRepository
        .getHelpers()
        .then((ApiResponse response) => response.data));
    workerRoles.addAll(await workersRepository
        .getWorkerTypes()
        .then((ApiResponse response) => response.data));
    workers.addAll(await workersRepository
        .getSupervisors()
        .then((ApiResponse response) => response.data));
    //Remove all entries for workerRoles that arent helper
    workerRoles.removeWhere((element) {
      if (element.type == null) return true;
      return !element.type!.contains("Additional Helper");
    });
    loading.value = false;
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void setCustomer(dynamic customerId) {
    //Clear the selected project id
    if (createTicketFormBuilderKey.value.currentState?.fields["project_id"] !=
        null) {
      createTicketFormBuilderKey.value.currentState?.patchValue({
        "project_id": null,
      });
    }

    filteredProjects.value = projects.where((Project project) {
      return project.customerId == customerId;
    }).toList();
    customerSelected.value = true;
  }

  void handleSelectedCustomerChange(Object? value) {
    final selectedCustomerId = value as int;

    //We filtred the company men by the selected customer
    selectedCustomer.value = selectedCustomerId;

    //Clear the selected company men id
    if (createTicketFormBuilderKey
            .value.currentState?.fields["company_man_id"] !=
        null) {
      createTicketFormBuilderKey.value.currentState?.patchValue({
        "company_man_id": null,
      });
    }

    filteredCompanyMen.value = companyMen.where((companyMan) {
      return companyMan.customerId == selectedCustomerId;
    }).toList();

    //We filtred the projects by the selected customer
    setCustomer(selectedCustomerId);
  }

  Future<void> createTicket() async {
    //Validate form
    if (!createTicketFormBuilderKey.value.currentState!.saveAndValidate()) {
      submitButton.reset();
      return;
    }

    //Get form data values
    final ticketData =
        Map.from(createTicketFormBuilderKey.value.currentState!.value);

    //Get the current woker info
    final Session currentUser = preferences.getSession();

    // //Then we add the required fields to ticketData
    ticketData.addEntries([
      MapEntry('worker_id', currentUser.userId),
    ]);

    additionalHelpersList.addAll([
      {
        "workerTypeId": currentShift.value?.workerTypeId,
        "workerId": currentUser.userId,
        "workerHours": 0,
      },
      if (currentShift.value?.helperId != null)
        {
          "workerTypeId": currentShift.value?.workerTypeId,
          "workerId": currentShift.value?.helperId,
          "workerHours": 0,
        },
      if (currentShift.value?.helper2Id != null)
        {
          "workerTypeId": currentShift.value?.workerTypeId,
          "workerId": currentShift.value?.helper2Id,
          "workerHours": 0,
        },
      if (currentShift.value?.helper3Id != null)
        {
          "workerTypeId": currentShift.value?.workerTypeId,
          "workerId": currentShift.value?.helper3Id,
          "workerHours": 0,
        }
    ]);

    final response = await ticketsRepository.createTicket(
      ticketData['worker_id'],
      currentShift.value!.id,
      ticketData['customer_id'],
      ticketData['project_id'],
      ticketData['company_man_id'],
      ticketData['equipment_id'],
      currentShift.value?.helperId ?? null,
      currentShift.value?.helper2Id ?? null,
      currentShift.value?.helper3Id ?? null,
      currentShift.value?.workerTypeId ?? null,
      additionalHelpersList,
      createTicketFormBuilderKey
          .value.currentState!.fields["supervisor_id"]!.value,
    );

    if (response.success == true) {
      submitButton.success();
      Get.offAllNamed(Routes.TABS);
    } else {
      submitButton.error();
      submitButton.reset();
    }
  }

  void handleHelperDropDownListChange(dynamic value) {
    if (value == null) return;
    helpers.refresh();
  }

  void handleAddAditionalHelper(FormFieldState<Object?> field, int? value) {
    if (value == null) return;

    additionalHelpersList.add({
      "workerTypeId": workerRoles.first.id,
      "workerId": value,
      "workerHours": 0,
    });

    createTicketFormBuilderKey.value.currentState
        ?.patchValue({"add_aditional_helpers": null});

    field.didChange(additionalHelpersList);
    helpers.refresh();
  }

  void handleRemoveAditionalHelper(int index) {
    additionalHelpersList.removeAt(index);

    helpers.refresh();
  }
}
