import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import 'package:onax_app/app/data/models/session_model.dart';
import 'package:onax_app/app/data/repositories/shifts_repository.dart';
import 'package:onax_app/app/data/repositories/workers_repository.dart';
import 'package:onax_app/app/routes/app_pages.dart';
import 'package:onax_app/core/services/preferences_service.dart';
import 'package:onax_app/app/data/models/worker_model.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

class CreateShiftController extends GetxController {
  final workersRepository = Get.find<WorkersRepository>();
  final shiftsRepository = Get.find<ShiftsRepository>();
  final preferences = Get.find<PreferencesService>();
  final submitButton = RoundedLoadingButtonController();

  final workers = List<UserWorker>.empty(growable: true).obs;
  final workerRoles = List<UserWorker>.empty(growable: true).obs;
  final requiredHelpers = 0.obs;

  final createShiftFormBuilderKey = GlobalKey<FormBuilderState>().obs;

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() async {
    getHelpers();
    getWorkersRoles();
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void getHelpers() async {
    final response = await workersRepository.getHelpers();
    if (response.success == true) {
      workers.addAll(response.data!);
    }
  }

  void getWorkersRoles() async {
    final response = await workersRepository.getWorkerTypes();
    if (response.success == true) {
      final List<UserWorker> rawWorkerRoles = response.data!;
      workerRoles.addAll(rawWorkerRoles);
      workerRoles.removeWhere((element) {
        if (element.type == null) return true;
        return element.type!.contains("Helper");
      });
    }
  }

  void setRequiredHelpers(int workerRoleId) {
    final UserWorker workerRole = workerRoles.firstWhere(
        (element) => element.id == workerRoleId,
        orElse: () => UserWorker());
    requiredHelpers.value = workerRole.helpersQuantity ?? 0;
  }

  void handleDropDownListChange(dynamic value) {
    if (value == null) return;

    setRequiredHelpers(value);

    //Reset helpers dropdowns
    createShiftFormBuilderKey.value.currentState!.fields.forEach((key, field) {
      if (key.contains("helper")) field.didChange(null);
    });
  }

  void handleHelperDropDownListChange(dynamic value) {
    if (value == null) return;
    workers.refresh();
  }

  Future<void> createShift() async {
    //Validate form
    if (!createShiftFormBuilderKey.value.currentState!.saveAndValidate()) {
      submitButton.reset();
      return;
    }

    //Get form data values
    final shiftData =
        Map.from(createShiftFormBuilderKey.value.currentState!.value);

    //Get the current woker info
    final Session currentUser = preferences.getSession();

    //Then we add the required fields to shiftData
    shiftData.addEntries([
      MapEntry('worker_id', currentUser.userId),
      MapEntry('worker_type_id', shiftData['worker_type_id']),
    ]);

    final response = await shiftsRepository.createShift(
      shiftData['worker_id'],
      shiftData['worker_type_id'],
      shiftData['helper_id'],
      shiftData['helper2_id'],
      shiftData['helper3_id'],
      shiftData['equipment_id'],
    );

    if (response.success == true) {
      submitButton.success();
      Get.offAllNamed(Routes.TABS);
    } else {
      submitButton.error();
      submitButton.reset();
    }
  }
}
