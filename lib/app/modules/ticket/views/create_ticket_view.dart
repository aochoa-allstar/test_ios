import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

import 'package:get/get.dart';
import 'package:onax_app/app/data/models/worker_model.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

import '../controllers/create_ticket_controller.dart';

class CreateTicketView extends GetView<CreateTicketController> {
  CreateTicketView({Key? key}) : super(key: key);

  final CreateTicketController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('tickets_title'.tr),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.only(left: 16, right: 16, bottom: 16),
          child: _ticketForm(),
        ),
      ),
    );
  }

  FormBuilder _ticketForm() {
    return FormBuilder(
      key: controller.createTicketFormBuilderKey.value,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Obx(
            () => Container(
              height: MediaQuery.of(Get.context!).size.height * 0.8,
              child: ListView(
                padding: EdgeInsets.symmetric(vertical: 16),
                children: [
                  _customersDropdown(),
                  if (controller.customerSelected.value == true)
                    _customerDependentDropdowns(),
                  SizedBox(height: 12),
                  _equipmentsDropdown(),
                  _currentHelpersDropdown(),
                  _supervisorsDropdown(controller),
                  SizedBox(height: 12),
                  Text(
                    "tickets_fields_aditionalHelper".tr,
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 12),
                  _aditionalHelpersList(),
                  _aditionalHelpers(),
                ],
              ),
            ),
          ),
          RoundedLoadingButton(
            borderRadius: 16,
            color: Colors.black,
            onPressed: (() => controller.createTicket()),
            controller: controller.submitButton,
            child: Text(
              'tickets_create_submit'.tr,
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

  Obx _equipmentsDropdown() {
    return Obx(
      (() => FormBuilderDropdown(
            name: "equipment_id",
            // onChanged: (value) => controller.handleDropDownListChange(value),
            icon: controller.loading.value
                ? Container(
                    margin: EdgeInsets.only(right: 8),
                    width: 12,
                    height: 12,
                    child: CircularProgressIndicator(
                      strokeWidth: 2.0,
                    ),
                  )
                : null,
            validator: (value) =>
                value == null ? "tickets_fields_required".tr : null,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            decoration: InputDecoration(
              labelText: "tickets_fields_equipment".tr,
              hintText: "tickets_fields_equipment".tr,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(24),
              ),
            ),
            items: controller.equipments
                .map((equipment) => DropdownMenuItem(
                      child:
                          Text(equipment.number ?? "tickets_fields_noModel".tr),
                      value: equipment.id,
                    ))
                .toList(),
          )),
    );
  }

  Obx _customersDropdown() {
    return Obx(
      (() => FormBuilderDropdown(
            name: "customer_id",
            onChanged: (value) =>
                controller.handleSelectedCustomerChange(value),
            validator: (value) =>
                value == null ? "tickets_fields_required".tr : null,
            icon: controller.loading.value
                ? Container(
                    margin: EdgeInsets.only(right: 8),
                    width: 12,
                    height: 12,
                    child: CircularProgressIndicator(
                      strokeWidth: 2.0,
                    ),
                  )
                : null,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            decoration: InputDecoration(
              labelText: "tickets_fields_customer".tr,
              hintText: "tickets_fields_customer".tr,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(24),
              ),
            ),
            items: controller.customers
                .map((customer) => DropdownMenuItem(
                      child: Text(customer.name),
                      value: customer.id,
                    ))
                .toList(),
          )),
    );
  }

  Widget _customerDependentDropdowns() {
    return Column(
      children: [
        const SizedBox(height: 12),
        _projectsDropdown(),
        const SizedBox(height: 12),
        _companyMenDropdown(),
      ],
    );
  }

  Obx _projectsDropdown() {
    return Obx(
      (() => FormBuilderDropdown(
            name: "project_id",
            // onChanged: (value) => controller.handleDropDownListChange(value),
            validator: (value) =>
                value == null ? "tickets_fields_required".tr : null,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            decoration: InputDecoration(
              labelText: "tickets_fields_project".tr,
              hintText: "tickets_fields_project".tr,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(24),
              ),
            ),
            items: controller.filteredProjects
                .map((project) => DropdownMenuItem(
                      child: Text(project.name),
                      value: project.id,
                    ))
                .toList(),
          )),
    );
  }

  Obx _companyMenDropdown() {
    return Obx(
      (() => FormBuilderDropdown(
            name: "company_man_id",
            // onChanged: (value) => controller.handleDropDownListChange(value),
            validator: (value) =>
                value == null ? "tickets_fields_required".tr : null,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            decoration: InputDecoration(
              labelText: "tickets_fields_companyMan".tr,
              hintText: "tickets_fields_companyMan".tr,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(24),
              ),
            ),
            items: controller.filteredCompanyMen
                .map((companyMan) => DropdownMenuItem(
                      child: Text(companyMan.name),
                      value: companyMan.id,
                    ))
                .toList(),
          )),
    );
  }

  Obx _currentHelpersDropdown() {
    return Obx(
      (() => Column(
            children: [
              const SizedBox(height: 12),
              if (controller.currentShift.value?.helperId != null &&
                  controller.helpers.isNotEmpty)
                FormBuilderDropdown(
                  name: "helper_id",
                  // onChanged: (value) => controller.handleDropDownListChange(value),
                  validator: (value) =>
                      value == null ? "tickets_fields_required".tr : null,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  initialValue: controller.currentShift.value?.helperId,
                  decoration: InputDecoration(
                    labelText: "tickets_fields_helper".tr,
                    hintText: "tickets_fields_helper".tr,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(24),
                    ),
                  ),
                  onChanged: (value) =>
                      controller.handleHelperDropDownListChange(value),
                  items: controller.helpers.map((workerRole) {
                    if (controller.createTicketFormBuilderKey.value
                                .currentState!.fields['helper_id']?.value ==
                            workerRole.id ||
                        controller.createTicketFormBuilderKey.value
                                .currentState!.fields['helper2_id']?.value ==
                            workerRole.id ||
                        controller.createTicketFormBuilderKey.value
                                .currentState!.fields['helper3_id']?.value ==
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
              if (controller.currentShift.value?.helper2Id != null &&
                  controller.helpers.isNotEmpty)
                const SizedBox(height: 12),
              if (controller.currentShift.value?.helper2Id != null &&
                  controller.helpers.isNotEmpty)
                FormBuilderDropdown(
                  name: "helper2_id",
                  // onChanged: (value) => controller.handleDropDownListChange(value),
                  validator: (value) =>
                      value == null ? "tickets_fields_required".tr : null,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  initialValue: controller.currentShift.value?.helper2Id,
                  decoration: InputDecoration(
                    labelText: "tickets_fields_helper".tr,
                    hintText: "tickets_fields_helper".tr,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(24),
                    ),
                  ),
                  onChanged: (value) =>
                      controller.handleHelperDropDownListChange(value),
                  items: controller.helpers.map((workerRole) {
                    if (controller.createTicketFormBuilderKey.value
                                .currentState!.fields['helper_id']?.value ==
                            workerRole.id ||
                        controller.createTicketFormBuilderKey.value
                                .currentState!.fields['helper2_id']?.value ==
                            workerRole.id ||
                        controller.createTicketFormBuilderKey.value
                                .currentState!.fields['helper3_id']?.value ==
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
              if (controller.currentShift.value?.helper3Id != null &&
                  controller.helpers.isNotEmpty)
                const SizedBox(height: 12),
              if (controller.currentShift.value?.helper3Id != null &&
                  controller.helpers.isNotEmpty)
                FormBuilderDropdown(
                  name: "helper3_id",
                  // onChanged: (value) => controller.handleDropDownListChange(value),
                  validator: (value) =>
                      value == null ? "tickets_fields_required".tr : null,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  initialValue: controller.currentShift.value?.helper3Id,
                  decoration: InputDecoration(
                    labelText: "tickets_fields_helper".tr,
                    hintText: "tickets_fields_helper".tr,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(24),
                    ),
                  ),
                  onChanged: (value) =>
                      controller.handleHelperDropDownListChange(value),
                  items: controller.helpers.map((workerRole) {
                    if (controller.createTicketFormBuilderKey.value
                                .currentState!.fields['helper_id']?.value ==
                            workerRole.id ||
                        controller.createTicketFormBuilderKey.value
                                .currentState!.fields['helper2_id']?.value ==
                            workerRole.id ||
                        controller.createTicketFormBuilderKey.value
                                .currentState!.fields['helper3_id']?.value ==
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
              const SizedBox(height: 12),
            ],
          )),
    );
  }

  Widget _aditionalHelpersList() {
    return Obx(() => Container(
          height: 40,
          margin: EdgeInsets.only(bottom: 20),
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: controller.additionalHelpersList.length,
            padding: EdgeInsets.all(0),
            separatorBuilder: (context, index) => SizedBox(width: 8),
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () => controller.handleRemoveAditionalHelper(index),
                child: Container(
                  height: 40,
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(12)),
                  child: Center(
                    child: Row(
                      children: [
                        Text(
                            controller.helpers.firstWhere((element) {
                                  return element.id ==
                                      controller.additionalHelpersList[index]
                                          ["workerId"] as int?;
                                },
                                    orElse: () =>
                                        UserWorker(name: "unknown")).name ??
                                "tickets_fields_aditionalHelper".tr,
                            style: TextStyle(color: Colors.white, fontSize: 12),
                            textAlign: TextAlign.center),
                        const SizedBox(width: 4),
                        Icon(
                          Icons.close,
                          color: Colors.white,
                          size: 16,
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ));
  }

  Widget _aditionalHelpers() {
    return FormBuilderField(
        builder: (field) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Obx(
                () => FormBuilderDropdown(
                  icon: controller.loading.value
                      ? Container(
                          margin: EdgeInsets.only(right: 8),
                          width: 12,
                          height: 12,
                          child: CircularProgressIndicator(
                            strokeWidth: 2.0,
                          ),
                        )
                      : null,
                  name: "add_aditional_helpers",
                  decoration: InputDecoration(
                    labelText: "tickets_fields_aditionalHelper".tr,
                    hintText: "tickets_fields_aditionalHelper".tr,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(24),
                    ),
                  ),
                  onChanged: (value) =>
                      controller.handleAddAditionalHelper(field, value),
                  items: controller.helpers.map((workerRole) {
                    if (controller.createTicketFormBuilderKey.value
                                .currentState!.fields['helper_id']?.value ==
                            workerRole.id ||
                        controller.createTicketFormBuilderKey.value
                                .currentState!.fields['helper2_id']?.value ==
                            workerRole.id ||
                        controller.createTicketFormBuilderKey.value
                                .currentState!.fields['helper3_id']?.value ==
                            workerRole.id ||
                        controller.additionalHelpersList
                            .where((p0) => p0["workerId"] == workerRole.id)
                            .isNotEmpty) {
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
              ),
              const SizedBox(height: 8),
            ],
          );
        },
        name: "aditional_helpers");
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

  Obx _supervisorsDropdown(CreateTicketController controller) {
    return Obx(
      (() => FormBuilderDropdown(
            name: "supervisor_id",
            decoration: InputDecoration(
              labelText: "tickets_fields_supervisor".tr,
              hintText: "tickets_fields_supervisor".tr,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(24),
              ),
            ),
            items: controller.workers
                .map((worker) => DropdownMenuItem(
                      child: Text(worker.name!),
                      value: worker.id,
                    ))
                .toList(),
          )),
    );
  }
}
