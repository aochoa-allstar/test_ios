import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import 'package:onax_app/app/data/models/customer_model.dart';
import 'package:onax_app/app/data/models/equipment_model.dart';
import 'package:onax_app/app/data/models/project_model.dart';
import 'package:onax_app/app/data/models/shift_model.dart';
import 'package:onax_app/app/data/models/user_coordinates_model.dart';
import 'package:onax_app/app/data/models/worker_model.dart';
import 'package:onax_app/app/data/models/destination_model.dart';
import 'package:onax_app/app/data/repositories/customers_repository.dart';
import 'package:onax_app/app/data/repositories/equipments_repository.dart';
import 'package:onax_app/app/data/repositories/jsas_repository.dart';
import 'package:onax_app/app/data/repositories/projects_repository.dart';
import 'package:onax_app/app/data/repositories/shifts_repository.dart';
import 'package:onax_app/app/data/repositories/workers_repository.dart';
import 'package:onax_app/app/data/repositories/destinations_repository.dart';
import 'package:hand_signature/signature.dart';
import 'package:onax_app/core/services/preferences_service.dart';
import 'package:onax_app/src/repositories/models/checkItemInspectionModel.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

class CreateInspectionController extends GetxController {
  final JSAsRepository jsasRepository = Get.find();
  final CustomersRepository customersRepository = Get.find();
  final ProjectsRepository projectsRepository = Get.find();
  final WorkersRepository workersRepository = Get.find();
  final EquipmentsRepository equipmentsRepository = Get.find();
  final ShiftsRepository shiftsRepository = Get.find();
  final DestinationsRepository destinationsRepository = Get.find();

  //services
  final preferences = Get.find<PreferencesService>();

  //Submit button controller
  final submitButton = RoundedLoadingButtonController();

  //Global form data
  final currentStepIndex = 0.obs;
  final userLocation = UserCoordinates(latitude: null, longitude: null).obs;
  final stepperIsScrollable = true.obs;
  final globalFormData = Rx<Map<String, dynamic>>({});

  //Preloaded data if the user sents the ticketId
  final ticketId = Rxn<int>();
  final currentShift = Rxn<Shift>();
  final helper1 = Rxn<UserWorker>();
  final helper2 = Rxn<UserWorker>();
  final helper3 = Rxn<UserWorker>();
  final aditionalWorkers = <Map<String, dynamic>>[].obs;

  //Form fields data
  final customers = <Customer>[].obs;
  final projects = <Project>[].obs;
  final helpers = <UserWorker>[].obs;
  final safetyEquipment = <Equipment>[].obs;
  final locations = List<Destination>.empty(growable: true).obs;
  final selectedLocation = Rxn<int>();
  final trucks = List<Equipment>.empty(growable: true).obs;
  final selectedTruck = Rxn<int>();

  late List<CheckboxItemInspectionModel> checkBoxItems;
  late bool prtAirCompressor;
  late bool potAirCompressor;
  late bool rrAirCompressor;
  late int prePost;


  //Stepper form keys for validation
  final stepsFormKeys =
      List.generate(2, (index) => GlobalKey<FormBuilderState>()).obs;

  final stateOfStepsFormKeys =
      List<Map<String, dynamic>>.generate(2, (index) => {}).obs;

  //Hand signature controllers
  final step11SignatureControl = new HandSignatureControl(
    threshold: 3.0,
    smoothRatio: 0.3,
    velocityRange: 2.0,
  ).obs;
  final step12SignatureControl1 = new HandSignatureControl(
    threshold: 3.0,
    smoothRatio: 0.3,
    velocityRange: 2.0,
  ).obs;
  final step12SignatureControl2 = new HandSignatureControl(
    threshold: 3.0,
    smoothRatio: 0.3,
    velocityRange: 2.0,
  ).obs;
  final step12SignatureControl3 = new HandSignatureControl(
    threshold: 3.0,
    smoothRatio: 0.3,
    velocityRange: 2.0,
  ).obs;
  final step12SignatureControl4 = new HandSignatureControl(
    threshold: 3.0,
    smoothRatio: 0.3,
    velocityRange: 2.0,
  ).obs;

  //Scroll list controllers
  final scrollController = new ScrollController();

  @override
  void onInit() async {
    prePost = 0;
    prtAirCompressor = prePost == 1 ? false : false;
    potAirCompressor = prePost == 2 ? false : false;
    rrAirCompressor = false;
    super.onInit();
  }

  @override
  void onReady() async {
    await getInitialInformation();
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  Future<void> getInitialInformation() async {
    // ticketId.value = Get.arguments['ticket_id'];
    // await getCustomers();
    // await getProjects();
    // //If the user sent a ticketId we need to preload the data
    // stepsFormKeys[0].currentState?.patchValue({
    //   "customer_id": customers
    //       .firstWhereOrNull((Customer customer) =>
    //           customer.id == Get.arguments['customer_id'])
    //       ?.id,
    //   "project_id": projects
    //       .firstWhereOrNull(
    //           (Project project) => project.id == Get.arguments['project_id'])
    //       ?.id,
    // });
    // await getShiftInfo();
    // await getHelpers();
    // await getUserLocation();
    await getLocations();
    await getTrucks();
  }

  //Stepper methods

  void hanldeGoToStep(int stepIndex) {
    scrollController.animateTo(
      stepIndex * 50.0,
      duration: Duration(milliseconds: 500),
      curve: Curves.ease,
    );

    //First we get the next form and the next state of the form
    final nextStepForm = stepsFormKeys[stepIndex].currentState!;
    final nextStateOfSetspFormkeys = stateOfStepsFormKeys[stepIndex];

    //Then we get the current form and the current state of the form
    final currentStepForm = stepsFormKeys[currentStepIndex.value].currentState!;
    final currentStateOfSetspFormkeys =
        stateOfStepsFormKeys[currentStepIndex.value];

    //If the user tries to go to another step, we need to validate the current step
    if (!currentStepForm.saveAndValidate()) {
      submitButton.reset();
      submitButton.stop();
      return;
    }

    //Then we need to save the current state of the form
    //Wait until the user location is loaded
    // if (stepIndex == 0 && userLocation.value.latitude == null) return;
    //We save the form data into the global FormData map
    if (currentStepForm.value.containsKey("items")) {
      //If the step has a list of items we need to flat the values (CheckBox group)
      print(currentStepForm.fields);
      globalFormData.value.addAll(flatFormValues(currentStepForm.value));
    } else {
      globalFormData.value.addAll(currentStepForm.value);
    }
    //We save the current state of the form
    currentStateOfSetspFormkeys.addAll(currentStepForm.value);

    //Then we patch the next step form with the current state
    nextStepForm.patchValue(nextStateOfSetspFormkeys);
    currentStepIndex.value = stepIndex;
  }

  void handleOnStepContinue(int stepIndex) {
    scrollController.animateTo(
      stepIndex * 50.0,
      duration: Duration(milliseconds: 500),
      curve: Curves.ease,
    );

    //First we patch the next step form with the current state
    final nextStepForm = stepsFormKeys[stepIndex + 1].currentState!;
    final nextStateOfSetspFormkeys = stateOfStepsFormKeys[stepIndex + 1];

    nextStepForm.patchValue(nextStateOfSetspFormkeys);

    //Then we get the current step
    final currentStepForm = stepsFormKeys[stepIndex].currentState!;
    final currentStateOfSetspFormkeys = stateOfStepsFormKeys[stepIndex];

    if (!currentStepForm.saveAndValidate()) {
      submitButton.reset();
      submitButton.stop();
      return;
    }

    //Wait until the user location is loaded
    // if (stepIndex == 0 && userLocation.value.latitude == null) return;

    //We save the form data into the global FormData map
    if (currentStepForm.value.containsKey("items")) {
      //If the step has a list of items we need to flat the values (CheckBox group)
      globalFormData.value.addAll(flatFormValues(currentStepForm.value));
    } else {
      globalFormData.value.addAll(currentStepForm.value);
    }

    //We save the current state of the form
    currentStateOfSetspFormkeys.addAll(currentStepForm.value);

    incrementCurrentStepIndex();
  }

  void handleOnSubmit() async {
    //In the las step we need to validate the current step before submit
    final lastStepForm = stepsFormKeys[stepsFormKeys.length - 1].currentState!;

    if (!lastStepForm.saveAndValidate()) {
      submitButton.reset();
      submitButton.stop();
      return;
    }

    globalFormData.value.addAll(lastStepForm.value);

    //Prepare the data to send
    final session = preferences.getSession();
    final currentDate = DateTime.now().toIso8601String();

    _fillCheckboxItems();
    print(json.encode(checkBoxItems));
    print(globalFormData.value);
    // globalFormData.value.addAll({
    //   "ticket_id": ticketId.value,
    //   "date": currentDate,
    //   "worker_id": session.userId,
    // });

    // //Send the data to the server
    // final response = await jsasRepository.createJSA(globalFormData.value);
    // if (response.success == true) {
    //   submitButton.success();
    //   Get.back(result: true, closeOverlays: true);
    // } else {
    //   if (response.message != null &&
    //       response.message!.contains("Validation error")) {
    //     ScaffoldMessenger.of(Get.context!).showSnackBar(
    //       SnackBar(
    //         content: Text(
    //             "Please make sure to fill all the required fields in the previous steps and try again."),
    //         backgroundColor: Colors.redAccent,
    //       ),
    //     );
    //   }
    //   submitButton.error();
    //   submitButton.reset();
    //   submitButton.stop();
    // }
  }

  void incrementCurrentStepIndex() => currentStepIndex.value++;
  void decrementCurrentStepIndex() => currentStepIndex.value--;

  Map<String, dynamic> flatFormValues(Map<String, dynamic> data) {
    final Map<String, dynamic> flatValues = {};
    data.forEach((key, field) {
      if (field is List<String>) {
        //If the value is a list we create a Key-Value pair for each item in the list
        field.asMap().forEach((index, title) {
          flatValues.addAll({title: true});
        });
      } else {
        flatValues.addAll({key: field});
      }
    });

    return flatValues;
  }

  //Populate dropdowns methods
  Future<void> getUserLocation() async {
    final location = await jsasRepository.getLocation();
    userLocation.value = location;
  }

  Future<void> getCustomers() async {
    final response = await customersRepository.getCustomers();
    if (response.success == true) {
      customers.value = response.data;
    }
  }

  Future<void> getProjects() async {
    final response = await projectsRepository.getAllProjects();
    if (response.success == true) {
      projects.value = response.data;
    }
  }

  Future<void> getLocations() async {
    final response = await destinationsRepository.getAllDestinations();
    if (response.success == true) {
      locations.value = response.data;
    }
  }

  Future<void> getTrucks() async {
    final response = await equipmentsRepository.getTrucks();
    if (response.success == true) {
      trucks.value = response.data;
    }
  }

  Future<void> getShiftInfo() async {
    final response = await shiftsRepository.getCurrentShift();
    if (response.success == true) {
      currentShift.value = response.data;
    }
  }


  void handleSelectedLocationChange(Object? value) {
    final selectedLocationId = value as int;
    selectedLocation.value = selectedLocationId;
  }

  void handleSelectedTruck(Object? value) {
    final selectedTruckId = value as int;
    selectedTruck.value = selectedTruckId;
  }

  //Signature methods
  void handleOnPointerDown() {
    stepperIsScrollable.value = false;
  }

  void handleOnPointerUp(
      FormFieldState<Object?> field, Rx<HandSignatureControl> step) async {
    var image = await step.value.toImage(
      background: Colors.white,
      color: Colors.black,
      fit: true,
    );
    Uint8List? imageBytes = image!.buffer.asUint8List();
    final String base64Singnature1 = base64Encode(imageBytes);
    field.didChange(base64Singnature1);

    stepperIsScrollable.value = true;
  }

  void handleOnClearSignature(
    Rx<HandSignatureControl> controler,
    FormFieldState<Object?> field,
  ) {
    controler.value.clear();
    field.didChange(null);
  }


  checkboxes(String nameCheckbox, bool value) {
    switch (nameCheckbox) {
      //AirCompressor
      case 'ptrAirCompressor':
        prtAirCompressor = value;
        break;
      case 'potAirCompressor':
        potAirCompressor = value;
        break;
      case 'rrAirCompressor':
        rrAirCompressor = value;
        break;
      default:
    }
  }

  _fillCheckboxItems() {
    checkBoxItems = [
      CheckboxItemInspectionModel(
          preTrip: prtAirCompressor == true ? 1 : 0,
          postTrip: potAirCompressor == true ? 1 : 0,
          requiresRepair: rrAirCompressor == true ? 1 : 0,
          name: "Air Compressor"),
    ];
  }
}
