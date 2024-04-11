import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:onax_app/app/data/models/api_response_model.dart';
import 'package:onax_app/app/data/models/company_man_model.dart';
import 'package:onax_app/app/data/models/customer_model.dart';
import 'package:onax_app/app/data/models/equipment_model.dart';
import 'package:onax_app/app/data/models/jsa_model.dart';
import 'package:onax_app/app/data/models/project_model.dart';
import 'package:onax_app/app/data/models/shift_model.dart';
import 'package:onax_app/app/data/models/ticket_model.dart';
import 'package:onax_app/app/data/models/worker_model.dart';
import 'package:onax_app/app/data/repositories/company_men_repository.dart';
import 'package:onax_app/app/data/repositories/customers_repository.dart';
import 'package:onax_app/app/data/repositories/equipments_repository.dart';
import 'package:onax_app/app/data/repositories/jsas_repository.dart';
import 'package:onax_app/app/data/repositories/projects_repository.dart';
import 'package:onax_app/app/data/repositories/shifts_repository.dart';
import 'package:onax_app/app/data/repositories/tickets_repository.dart';
import 'package:onax_app/app/data/repositories/workers_repository.dart';
import 'package:onax_app/app/routes/app_pages.dart';
import 'package:onax_app/core/services/preferences_service.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

class UpdateTicketController extends GetxController {
  // Services & Repositories
  final PreferencesService preferences = Get.find();
  final TicketsRepository ticketsRepository = Get.find();
  final ShiftsRepository shiftsRepository = Get.find();
  final EquipmentsRepository equipmentsRepository = Get.find();
  final CustomersRepository customersRepository = Get.find();
  final ProjectsRepository projectsRepository = Get.find();
  final CompanyMenRepository companyMenRepository = Get.find();
  final JSAsRepository jsasRepository = Get.find();
  final WorkersRepository workersRepository = Get.find();

  // Form controllers and keys
  final updateTicketFormBuilderKey = GlobalKey<FormBuilderState>().obs;
  final stepsFormKeys =
      List.generate(4, (index) => GlobalKey<FormBuilderState>()).obs;
  final departButton = RoundedLoadingButtonController();
  final arriveButton = RoundedLoadingButtonController();
  final finishButton = RoundedLoadingButtonController();
  final uploadPhotoButton = RoundedLoadingButtonController();

  // Dropdown lists
  final currentShift = Rxn<Shift>();
  final equipments = List<Equipment>.empty(growable: true).obs;
  final allEquipment = List<Equipment>.empty(growable: true).obs;
  final customers = List<Customer>.empty(growable: true).obs;
  final projects = List<Project>.empty(growable: true).obs;
  final companyMen = List<CompanyMan>.empty(growable: true).obs;
  final workers = List<UserWorker>.empty(growable: true).obs;
  final workerTypes = List<UserWorker>.empty(growable: true).obs;
  final helpers = List<UserWorker>.empty(growable: true).obs;

  final ticketId = Rx<int?>(null);
  final ticket = Rx<Ticket?>(null);
  final jsas = Rx<List<JSA?>>([]);
  final jsa = Rx<JSA?>(null);
  final jsaCreated = Rx<bool>(false);
  final aditionalWorkers = List<Map<String, dynamic>>.empty(growable: true).obs;
  final aditionalWorkersEditList =
      List<Map<String, dynamic>>.empty(growable: true).obs;
  final PreferencesService preferencesService = Get.find();

  // UI State
  final currentStepIndex = Rx<int>(0);
  final arrivedPhotoPath = Rxn<String>();
  final arrivedPhotoURL = Rxn<String>();
  final finishedPhotoPath = Rxn<String>();
  final finishedPhotoBytesEncoded = Rxn<String>();

  @override
  void onInit() {
    ticketId.value = Get.arguments;
    super.onInit();
  }

  @override
  void onReady() async {
    currentShift.value = await shiftsRepository
        .getCurrentShift()
        .then((ApiResponse response) => response.data);
    ticket.value = await ticketsRepository
        .getActiveTicket()
        .then((ApiResponse response) => response.data);
    jsas.value = await jsasRepository
        .getJSAsByUser()
        .then((ApiResponse response) => response.data);
    customers.addAll(await customersRepository
        .getCustomers()
        .then((ApiResponse response) => response.data));
    projects.addAll(await projectsRepository
        .getAllProjects()
        .then((ApiResponse response) => response.data));
    companyMen.addAll(await companyMenRepository
        .getAllCompanyMen()
        .then((ApiResponse response) => response.data));
    equipments.addAll(await equipmentsRepository
        .getTrucks()
        .then((ApiResponse response) => response.data));
    allEquipment.addAll(await equipmentsRepository
        .getAllEquipments()
        .then((ApiResponse response) => response.data));
    workers.addAll(await workersRepository
        .getSupervisors()
        .then((ApiResponse response) => response.data));
    helpers.addAll(await workersRepository
        .getHelpers()
        .then((ApiResponse response) => response.data));

    final currentWorkerId = preferencesService.getSession().userId;
    final curentWorkerInfo =
        await workersRepository.getWorkerById(currentWorkerId);
    helpers.add(curentWorkerInfo.data);

    setTicketData();
    ticketAlreadyHasJSA();
    ticketAlreadyHasArrivedPhoto();

    //Only used on step 4, no priority
    workerTypes.addAll(await workersRepository
        .getWorkerTypes()
        .then((ApiResponse response) => response.data));

    super.onReady();
  }

  setTicketData() {
    // Load Shift Data
    stepsFormKeys[0].currentState?.patchValue({
      "helper": ticket.value?.helperId,
      "helper2_id": ticket.value?.helper2Id,
      "helper3_id": ticket.value?.helper3Id,
      "customer_id": customers
          .firstWhereOrNull(
              (Customer customer) => customer.id == ticket.value!.customerId)
          ?.id,
      "project_id": projects
          .firstWhereOrNull(
              (Project project) => project.id == ticket.value!.projectId)
          ?.id,
      "company_man_id": companyMen
          .firstWhereOrNull((CompanyMan companyMan) =>
              companyMan.id == ticket.value!.companyManId)
          ?.id,
      "equipment_id": equipments
          .firstWhereOrNull((Equipment equipment) =>
              equipment.id == ticket.value!.equipmentId)
          ?.id,
    });

    // Set Depart Time
    if (ticket.value?.departTimestamp != null) {
      stepsFormKeys[1].currentState?.patchValue({
        "depart_timestamp": DateTime.parse(ticket.value!.departTimestamp!),
      });
    }

    // Only if the list is empty, we set the aditional workers
    if (aditionalWorkersEditList.length == 0) {
      //We set the aditional workers for step 4
      aditionalWorkersEditList.addAll(ticket.value!.aditionalWorkers!);
      //Then we set the aditional workers and remove duplicates for the first step list
      final session = preferencesService.getSession();
      aditionalWorkers.addAll(ticket.value!.aditionalWorkers!);
      aditionalWorkers.removeWhere((element) {
        return element['workerId'] == session.userId;
      });
      aditionalWorkers.removeWhere((element) {
        return element['workerId'] == currentShift.value!.helperId ||
            element['workerId'] == currentShift.value!.helper2Id ||
            element['workerId'] == currentShift.value!.helper3Id;
      });
    }
  }

  @override
  void onClose() {
    super.onClose();
  }

  //Stepper methods
  void handleOnStepContinue(int stepIndex) {
    if (!stepsFormKeys[stepIndex].currentState!.saveAndValidate()) return;
    incrementCurrentStepIndex();
  }

  void handleOnStepCancel() {
    if (currentStepIndex.value > 0) decrementCurrentStepIndex();
  }

  void handleOnStepTapped(int tappedStep) {
    if (!stepsFormKeys[currentStepIndex.value].currentState!.saveAndValidate())
      return;
    switch (tappedStep) {
      case 0:
        currentStepIndex.value = tappedStep;
        break;
      case 1:
        currentStepIndex.value = tappedStep;
        break;
      case 2:
        if (ticket.value?.departTimestamp == null) break;
        currentStepIndex.value = tappedStep;
        break;
      case 3:
        if (ticket.value?.departTimestamp == null) break;
        if (arrivedPhotoURL.value == null && arrivedPhotoPath.value == null)
          break;
        if (jsaCreated.value == false) break;
        currentStepIndex.value = tappedStep;
      default:
        break;
    }
  }

  void incrementCurrentStepIndex() => currentStepIndex.value++;
  void decrementCurrentStepIndex() => currentStepIndex.value--;

  Future<void> depart() async {
    final response = await ticketsRepository.updateTicketDepart(
      ticketId.value!,
      currentShift.value!.id,
    );

    if (response.success == true) {
      ticket.value!.departTimestamp = response.data.departTimestamp;
      setTicketData();
      incrementCurrentStepIndex();
      departButton.success();
      departButton.reset();

      //Change state of date picker value
      stepsFormKeys[currentStepIndex.value].currentState!.patchValue({
        "depart_timestamp": DateTime.parse(ticket.value!.departTimestamp!),
      });
    } else {
      departButton.error();
      departButton.reset();
    }
  }

  Future<void> finish() async {
    try {
      if (!stepsFormKeys[currentStepIndex.value]
          .currentState!
          .saveAndValidate()) {
        finishButton.error();
        finishButton.reset();
        return;
      }

      if (finishedPhotoPath.value == null) {
        openPhotoMenu();
        finishButton.error();
        finishButton.reset();
        return;
      }

      final copyOfFields =
          Map.from(stepsFormKeys[currentStepIndex.value].currentState!.value);
      copyOfFields['id'] = ticketId.value;
      copyOfFields['shift_id'] = currentShift.value!.id;
      copyOfFields['finished_photo'] = finishedPhotoBytesEncoded.value;

      //Then we add supervisor to the aditional workers
      final supervisorType = workerTypes
              .firstWhereOrNull((UserWorker worker) =>
                  worker.name?.toLowerCase() == "supervisor")
              ?.workerTypeId ??
          6;
      aditionalWorkersEditList.add({
        "workerTypeId": supervisorType,
        "workerId": copyOfFields['supervisor_id'],
        "workerHours": copyOfFields['supervisor_work_hours'],
      });

      //We check if the user left the material fields with values
      if (stepsFormKeys[currentStepIndex.value]
                  .currentState!
                  .fields['material_name']!
                  .value !=
              null &&
          stepsFormKeys[currentStepIndex.value]
                  .currentState!
                  .fields['material_quantity']!
                  .value !=
              null) {
        //If the user left the fields with values, we add the material to the list
        final newMaterial = {
          "description": stepsFormKeys[currentStepIndex.value]
              .currentState!
              .fields['material_name']!
              .value,
          "quantity": stepsFormKeys[currentStepIndex.value]
              .currentState!
              .fields['material_quantity']!
              .value,
        };
        if (copyOfFields['materials'] == null) copyOfFields['materials'] = [];
        copyOfFields['materials'].addAll([newMaterial]);
      }

      await ticketsRepository.updateTicketFinish(
        copyOfFields['id'],
        copyOfFields['shift_id'],
        copyOfFields['finished_photo'],
        copyOfFields['description'],
        copyOfFields['supervisor_id'],
        copyOfFields['supervisor_work_hours'] ?? 0,
        copyOfFields['additional_equipment_ids'],
        aditionalWorkersEditList,
        copyOfFields['materials'] ?? [],
      );

      finishButton.success();
      finishButton.reset();
      Get.offAllNamed(Routes.TABS);
    } catch (e) {
      log(e.toString());
      finishButton.error();
      finishButton.reset();
      finishButton.stop();
      //Remove the supervisor from the aditional workers in case of failure
      final copyOfFields =
          Map.from(stepsFormKeys[currentStepIndex.value].currentState!.value);
      if (aditionalWorkersEditList.contains((element) {
        return element['workerId'] == copyOfFields['supervisor_id'];
      })) {
        aditionalWorkersEditList.removeLast();
      }
    }
  }

  dynamic openPhotoMenu() {
    Get.defaultDialog(
      backgroundColor: Colors.white,
      titlePadding: EdgeInsets.only(top: 32),
      title: 'Alert',
      titleStyle: TextStyle(fontWeight: FontWeight.bold),
      contentPadding: EdgeInsets.only(top: 16, bottom: 24, left: 24, right: 24),
      radius: 16,
      content: Column(
        children: [
          TextButton(
            onPressed: () async {
              await takePhoto();
              Get.back();
            },
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(Icons.camera),
                SizedBox(width: 8),
                Text('Take photo'),
              ],
            ),
          ),
          TextButton(
            onPressed: () async {
              await choosePhotoFromGallery();
              Get.back();
            },
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(Icons.photo),
                SizedBox(width: 8),
                Text('Choose from gallery'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  //If we are on the third setp, we update the ticket arrive()
  Future<void> takePhoto() async {
    final picker = ImagePicker();

    final XFile? image = await picker.pickImage(
        source: ImageSource.camera,
        imageQuality: 30,
        preferredCameraDevice: CameraDevice.rear);

    if (image != null) {
      switch (currentStepIndex.value) {
        case 2:
          final byteImg = await image.readAsBytes();
          ticketsRepository.updateTicketArrive(
              ticketId.value!, currentShift.value?.id, base64.encode(byteImg));
          arrivedPhotoPath.value = image.path;
          arrivedPhotoPath.refresh();
          break;
        default:
          finishedPhotoPath.value = image.path;
          finishedPhotoBytesEncoded.value =
              base64.encode(await image.readAsBytes());
          finishedPhotoPath.refresh();
          finishedPhotoBytesEncoded.refresh();
      }
    }
  }

  //If we are on the third setp, we update the ticket arrive()
  Future<void> choosePhotoFromGallery() async {
    final picker = ImagePicker();

    final XFile? image = await picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 30,
        preferredCameraDevice: CameraDevice.rear);

    if (image != null) {
      switch (currentStepIndex.value) {
        case 2:
          final byteImg = await image.readAsBytes();
          ticketsRepository.updateTicketArrive(
              ticketId.value!, currentShift.value?.id, base64.encode(byteImg));
          arrivedPhotoPath.value = image.path;
          arrivedPhotoPath.refresh();
          break;
        default:
          finishedPhotoPath.value = image.path;
          finishedPhotoBytesEncoded.value =
              base64.encode(await image.readAsBytes());
          finishedPhotoPath.refresh();
          finishedPhotoBytesEncoded.refresh();
      }
    }
  }

  ticketAlreadyHasJSA() {
    final newJsa = jsas.value
        .where((JSA? jsa) => jsa?.ticketId == ticketId.value)
        .isNotEmpty;
    this.jsaCreated.value = newJsa;
  }

  ticketAlreadyHasArrivedPhoto() {
    arrivedPhotoURL.value = ticket.value?.arrivedPhoto;
    arrivedPhotoURL.refresh();
  }

  handleGetNewJSA(bool? newJsaWasCreated) async {
    if (newJsaWasCreated == null) return;
    jsaCreated.value = newJsaWasCreated;
  }

  handleAditionalWorkerHoursChange(int index, int hours) {
    aditionalWorkersEditList[index]['workerHours'] = hours;
    log(aditionalWorkersEditList.toString());
  }

  handleAddMaterial(FormFieldState<Object?> field) {
    stepsFormKeys[currentStepIndex.value].currentState!.save();

    String? materialDescription = stepsFormKeys[currentStepIndex.value]
        .currentState!
        .fields['material_name']!
        .value;
    String? materialQuantity = stepsFormKeys[currentStepIndex.value]
        .currentState!
        .fields['material_quantity']!
        .value;

    if (materialDescription == null || materialQuantity == null) return;

    final newMaterial = {
      "description": materialDescription,
      "quantity": materialQuantity,
    };

    final materials = field.value == null ? [] : field.value as List<dynamic>;
    materials.addAll([newMaterial]);

    field.didChange(materials);

    stepsFormKeys[currentStepIndex.value]
        .currentState!
        .fields['material_name']!
        .didChange(null);

    stepsFormKeys[currentStepIndex.value]
        .currentState!
        .fields['material_quantity']!
        .didChange(null);
  }

  handleRemoveMaterial(int index, FormFieldState<Object?> field) {
    final materials = field.value as List<dynamic>;
    materials.removeAt(index);
    field.didChange(materials);
  }
}
