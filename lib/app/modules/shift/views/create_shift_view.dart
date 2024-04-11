import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

import 'package:get/get.dart';

import '../controllers/create_shift_controller.dart';

class CreateShiftView extends GetView<CreateShiftController> {
  final CreateShiftController controller = Get.put(CreateShiftController());

  CreateShiftView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('shift_create_submit'.tr),
      ),
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.all(16),
          child: _shiftForm(),
        ),
      ),
    );
  }

  FormBuilder _shiftForm() {
    return FormBuilder(
      key: controller.createShiftFormBuilderKey.value,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              _workerTypeDropDown(),
              const SizedBox(height: 16),
              _getWorkerHelpersDropdowns(),
            ],
          ),
          RoundedLoadingButton(
            borderRadius: 16,
            color: Colors.black,
            onPressed: (() => controller.createShift()),
            controller: controller.submitButton,
            child: Text(
              'shift_create_submit'.tr,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          )
        ],
      ),
    );
  }

  Obx _workerTypeDropDown() {
    return Obx(
      (() => FormBuilderDropdown(
            name: "worker_type_id",
            onChanged: (value) => controller.handleDropDownListChange(value),
            validator: (value) =>
                value == null ? "shift_fields_required".tr : null,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            decoration: InputDecoration(
              labelText: "shift_fields_role".tr,
              hintText: "shift_fields_role".tr,
              contentPadding: EdgeInsets.all(16),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
              ),
            ),
            items: controller.workerRoles
                .map((workerRol) => DropdownMenuItem(
                      child: Text(getWorkersRolesName(workerRol.type!)),
                      value: workerRol.id,
                    ))
                .toList(),
          )),
    );
  }

  Widget _getWorkerHelpersDropdowns() {
    const helpersText = ["one", "two", "three"];

    return Obx(
      () => Column(
        children: [
          ...List.generate(
            controller.requiredHelpers.value,
            (index) {
              return Container(
                margin: EdgeInsets.only(bottom: 16),
                child: FormBuilderDropdown(
                  name: index == 0 ? "helper_id" : "helper${index + 1}_id",
                  validator: (value) =>
                      value == null ? "shift_fields_required".tr : null,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  decoration: InputDecoration(
                    labelText: "shift_fields_helper_${helpersText[index]}".tr,
                    hintText: "shift_fields_helper_${helpersText[index]}".tr,
                    contentPadding: EdgeInsets.all(16),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  onChanged: (value) =>
                      controller.handleHelperDropDownListChange(value),
                  items: controller.workers.map((workerRole) {
                    if (controller.createShiftFormBuilderKey.value.currentState!
                                .fields['helper_id']?.value ==
                            workerRole.id ||
                        controller.createShiftFormBuilderKey.value.currentState!
                                .fields['helper2_id']?.value ==
                            workerRole.id ||
                        controller.createShiftFormBuilderKey.value.currentState!
                                .fields['helper3_id']?.value ==
                            workerRole.id) {
                      return DropdownMenuItem(
                        child: Text(workerRole.name!),
                        enabled: false,
                        value: workerRole.id,
                      );
                    }
                    return DropdownMenuItem(
                      child: Text(workerRole.name!),
                      value: workerRole.id,
                    );
                  }).toList(),
                ),
              );
            },
          )
        ],
      ),
    );
  }

  getWorkersRolesName(String workerRol) {
    if (workerRol.contains(" - ")) {
      final type = workerRol.split(" - ")[0].tr;
      final name = workerRol.split(" - ")[1];
      return "workerRoles_${type}".tr + " - $name";
    }
    if (workerRol.contains("Man crew")) {
      return workerRol;
    }
    if (!workerRol.contains(" ")) {
      return "workerRoles_$workerRol".tr;
    }
    return workerRol;
  }
}
