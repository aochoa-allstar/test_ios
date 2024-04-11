import 'dart:convert';
import 'dart:developer';
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
import 'package:onax_app/app/data/repositories/customers_repository.dart';
import 'package:onax_app/app/data/repositories/equipments_repository.dart';
import 'package:onax_app/app/data/repositories/jsas_repository.dart';
import 'package:onax_app/app/data/repositories/projects_repository.dart';
import 'package:onax_app/app/data/repositories/shifts_repository.dart';
import 'package:onax_app/app/data/repositories/workers_repository.dart';
import 'package:hand_signature/signature.dart';
import 'package:onax_app/core/services/preferences_service.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

class CreateJSAController extends GetxController {
  final JSAsRepository jsasRepository = Get.find();
  final CustomersRepository customersRepository = Get.find();
  final ProjectsRepository projectsRepository = Get.find();
  final WorkersRepository workersRepository = Get.find();
  final EquipmentsRepository equipmentsRepository = Get.find();
  final ShiftsRepository shiftsRepository = Get.find();

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
  final currentWorker = Rxn<UserWorker>();
  final aditionalWorkers = <Map<String, dynamic>>[].obs;

  //Form fields data
  final customers = <Customer>[].obs;
  final projects = <Project>[].obs;
  final helpers = <UserWorker>[].obs;
  final safetyEquipment = <Equipment>[].obs;

  //Stepper form keys for validation
  final stepsFormKeys =
      List.generate(12, (index) => GlobalKey<FormBuilderState>()).obs;

  final stateOfStepsFormKeys =
      List<Map<String, dynamic>>.generate(12, (index) => {}).obs;

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

  final additionalHelpersSignatureControl = <HandSignatureControl>[].obs;

  //Scroll list controllers
  final scrollController = new ScrollController();

  @override
  void onInit() async {
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
    ticketId.value = Get.arguments['ticket_id'];
    await getCustomers();
    await getProjects();
    //If the user sent a ticketId we need to preload the data
    stepsFormKeys[0].currentState?.patchValue({
      "customer_id": customers
          .firstWhereOrNull((Customer customer) =>
              customer.id == Get.arguments['customer_id'])
          ?.id,
      "project_id": projects
          .firstWhereOrNull(
              (Project project) => project.id == Get.arguments['project_id'])
          ?.id,
    });
    await getShiftInfo();
    await getHelpers();
    await getUserLocation();
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
    if (stepIndex == 0 && userLocation.value.latitude == null) return;
    //We save the form data into the global FormData map
    if (currentStepForm.value.containsKey("items")) {
      //If the step has a list of items we need to flat the values (CheckBox group)
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
    if (stepIndex == 0 && userLocation.value.latitude == null) return;

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

    //Then we create a array with maps containing each additional helper signature and name
    final additionalHelpersSignatures = <Map<String, dynamic>>[];
    aditionalWorkers.asMap().entries.forEach((element) {
      final value = element.value;
      final index = element.key;
      final currentHelperName =
          helpers.firstWhere((element) => value["workerId"] == element.id).name;

      additionalHelpersSignatures.add({
        "name": currentHelperName,
        "signature":
            globalFormData.value["additional_helper_signature_${index}"],
      });

      globalFormData.value.remove("additional_helper_signature_${index}");
    });

    globalFormData.value.addAll({
      "ticket_id": ticketId.value,
      "date": currentDate,
      "worker_id": session.userId,
      "additional_signatures": additionalHelpersSignatures,
    });

    //Send the data to the server
    try {
      final response = await jsasRepository.createJSA(globalFormData.value);
      if (response.success == true) {
        submitButton.success();
        Get.back(result: true, closeOverlays: true);
      } else {
        if (response.message != null &&
            response.message!.contains("Validation error")) {
          ScaffoldMessenger.of(Get.context!).showSnackBar(
            SnackBar(
              content: Text(
                  "Please make sure to fill all the required fields in the previous steps and try again."),
              backgroundColor: Colors.redAccent,
            ),
          );
        }
        submitButton.error();
        submitButton.reset();
        submitButton.stop();
      }
    } catch (e) {
      log(e.toString());
      submitButton.error();
      submitButton.reset();
      submitButton.stop();
    }
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

  Future<void> getHelpers() async {
    final response = await workersRepository.getHelpers();
    if (response.success == true) {
      helpers.value = response.data;
      //Then we set the helper values
      helper1.value = helpers.firstWhereOrNull(
          (UserWorker helper) => helper.id == currentShift.value?.helperId);
      helper2.value = helpers.firstWhereOrNull(
          (UserWorker helper) => helper.id == currentShift.value?.helper2Id);
      helper3.value = helpers.firstWhereOrNull(
          (UserWorker helper) => helper.id == currentShift.value?.helper3Id);
      final session = preferences.getSession();

      //Then we set the aditional workers and remove duplicates
      aditionalWorkers.addAll(Get.arguments['workers'] ?? []);
      aditionalWorkers.removeWhere((element) {
        return element['workerId'] == session.userId;
      });
      aditionalWorkers.removeWhere((element) {
        return element['workerId'] == currentShift.value?.helperId;
      });
      aditionalWorkers.removeWhere((element) {
        return element['workerId'] == currentShift.value?.helper2Id;
      });
      aditionalWorkers.removeWhere((element) {
        return element['workerId'] == currentShift.value?.helper3Id;
      });
    }
    final currentWorkerId = preferences.getSession().userId;
    final curentWorkerInfo =
        await workersRepository.getWorkerById(currentWorkerId);
    currentWorker.value = curentWorkerInfo.data;
    helpers.add(curentWorkerInfo.data);

    //Then we create a signature control for each additional worker
    additionalHelpersSignatureControl.addAll(
      List.generate(aditionalWorkers.length, (index) {
        return new HandSignatureControl(
          threshold: 3.0,
          smoothRatio: 0.3,
          velocityRange: 2.0,
        );
      }),
    );
  }

  Future<void> getShiftInfo() async {
    final response = await shiftsRepository.getCurrentShift();
    if (response.success == true) {
      currentShift.value = response.data;
    }
  }

  //Signature methods
  void handleOnPointerDown() {
    stepperIsScrollable.value = false;
  }

  void handleOnPointerUpAdditionalHelper(
    FormFieldState<Object?> field,
    int index,
  ) async {
    var step = additionalHelpersSignatureControl[index];
    var image = await step.toImage(
      background: Colors.white,
      color: Colors.black,
      fit: true,
    );
    Uint8List? imageBytes = image!.buffer.asUint8List();
    final String base64Singnature1 = base64Encode(imageBytes);
    field.didChange(base64Singnature1);

    stepperIsScrollable.value = true;
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

  void handleOnClearAdditionalHelperSignature(
    FormFieldState<Object?> field,
    int index,
  ) {
    final controler = additionalHelpersSignatureControl[index];
    controler.clear();
    field.didChange(null);
  }
}
