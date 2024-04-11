import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import 'package:onax_app/app/data/models/worker_model.dart';
import 'package:onax_app/app/modules/ticket/controllers/update_ticket_controller.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

Step stepFour(int stepIndex, formKey) {
  UpdateTicketController controller = Get.find();

  return Step(
    title: Text(
      'tickets_steps_step${stepIndex + 1}'.tr,
      style: TextStyle(
        fontWeight: FontWeight.w600,
      ),
    ),
    content: Container(
      padding: EdgeInsets.symmetric(vertical: 12),
      child: FormBuilder(
          key: formKey,
          child: Obx(
            () => Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _supervisorsDropdown(controller),
                SizedBox(height: 16),
                FormBuilderTextField(
                  name: "supervisor_work_hours",
                  valueTransformer: (value) => int.parse(value ?? "0"),
                  // validator: (value) => value == null || value.isEmpty
                  //     ? "tickets_fields_required".tr
                  //     : null,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: "tickets_fields_supervisorWorkHours".tr,
                    hintText: "tickets_fields_supervisorWorkHours".tr,
                    contentPadding: EdgeInsets.all(16),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                ),
                SizedBox(height: 16),
                finishedPhotoPicker(controller),
                SizedBox(height: 16),
                FormBuilderTextField(
                  name: "description",
                  validator: (value) => value == null || value.isEmpty
                      ? "tickets_fields_required".tr
                      : null,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  decoration: InputDecoration(
                    labelText: "tickets_fields_description".tr,
                    hintText: "tickets_fields_description".tr,
                    contentPadding: EdgeInsets.all(16),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                ),
                SizedBox(height: 16),
                ...controller.aditionalWorkersEditList.asMap().entries.map((e) {
                  var index = e.key;
                  var value = e.value;

                  return Column(
                    children: [
                      Row(children: [
                        Expanded(
                          child: Text(
                            controller.helpers.firstWhere((element) {
                                  return element.id == value["workerId"];
                                },
                                    orElse: () => UserWorker(
                                        name: "jsas_create_worker".tr)).name ??
                                "tickets_fields_aditionalHelper".tr,
                          ),
                        ),
                        SizedBox(width: 16),
                        SizedBox(
                          width: 170,
                          child: FormBuilderTextField(
                            onChanged: (value) =>
                                controller.handleAditionalWorkerHoursChange(
                                    index,
                                    value != null && value.isNotEmpty
                                        ? int.parse(value)
                                        : 0),
                            name: "work_hours_${value["workerId"]}",
                            valueTransformer: (value) =>
                                int.parse(value ?? "0"),
                            validator: (value) => value == null || value.isEmpty
                                ? "tickets_fields_required".tr
                                : null,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              labelText: "tickets_fields_workHours".tr,
                              hintText: "tickets_fields_workHours".tr,
                              contentPadding: EdgeInsets.all(16),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                            ),
                          ),
                        ),
                      ]),
                      const SizedBox(height: 8),
                    ],
                  );
                }).toList(),
                SizedBox(height: 8),
                Text(
                  "tickets_fields_additionalMaterials".tr,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
                SizedBox(height: 8),
                additionalMaterialsField(controller),
                SizedBox(height: 16),
                _additionalEquipmentDropdown(controller),
                SizedBox(height: 16),
                RoundedLoadingButton(
                  controller: controller.finishButton,
                  child: Text(
                    "tickets_steps_step4".tr,
                    style: TextStyle(color: Colors.white),
                  ),
                  borderRadius: 16,
                  color: Colors.black,
                  onPressed: () {
                    controller.finish();
                  },
                ),
              ],
            ),
          )),
    ),
  );
}

FormBuilderField<Object?> additionalMaterialsField(
    UpdateTicketController controller) {
  return FormBuilderField(
      builder: (field) => Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(
                height: field.value == null ||
                        (field.value as List<dynamic>).isEmpty
                    ? 0
                    : 60,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) => Container(
                    child: GestureDetector(
                      onTap: () =>
                          controller.handleRemoveMaterial(index, field),
                      child: Container(
                        padding: EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.all(Radius.circular(12)),
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    width: 100,
                                    child: Text(
                                      controller
                                          .stepsFormKeys[
                                              controller.currentStepIndex.value]
                                          .currentState!
                                          .fields["materials"]!
                                          .value[index]["description"],
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  Text(
                                    "tickets_fields_materialQty".tr +
                                        ": " +
                                        controller
                                            .stepsFormKeys[controller
                                                .currentStepIndex.value]
                                            .currentState!
                                            .fields["materials"]!
                                            .value[index]["quantity"],
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 12,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ]),
                            const SizedBox(width: 8),
                            Icon(Icons.close, color: Colors.white, size: 12),
                          ],
                        ),
                      ),
                    ),
                  ),
                  separatorBuilder: (context, index) => SizedBox(width: 8),
                  itemCount: field.value == null
                      ? 0
                      : (field.value as List<dynamic>).length,
                ),
              ),
              field.value == null || (field.value as List<dynamic>).isEmpty
                  ? const SizedBox.shrink()
                  : const SizedBox(height: 8),
              Row(
                children: [
                  Expanded(
                    child: FormBuilderTextField(
                      name: "material_name",
                      decoration: InputDecoration(
                        labelText: "tickets_fields_materialName".tr,
                        hintText: "tickets_fields_materialName".tr,
                        contentPadding: EdgeInsets.all(16),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  SizedBox(
                    width: 120,
                    child: FormBuilderTextField(
                      name: "material_quantity",
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: "tickets_fields_materialQty".tr,
                        hintText: "tickets_fields_materialQty".tr,
                        contentPadding: EdgeInsets.all(16),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 8),
              FilledButton(
                  onPressed: () => controller.handleAddMaterial(field),
                  child: Text(
                    "tickets_fields_addMaterial".tr,
                  ),
                  style: ButtonStyle(
                    backgroundColor: MaterialStatePropertyAll(Colors.black),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(8)))),
                  )),
            ],
          ),
      name: "materials");
}

GestureDetector finishedPhotoPicker(UpdateTicketController controller) {
  return GestureDetector(
    onTap: () => controller.openPhotoMenu(),
    child: Container(
      height: 256,
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.all(
          Radius.circular(16),
        ),
      ),
      width: double.maxFinite,
      child: controller.finishedPhotoPath.value != null
          ? ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(16)),
              child: Image.file(
                  fit: BoxFit.cover,
                  File(controller.finishedPhotoPath.value ?? "")),
            )
          : Icon(Icons.camera_alt_outlined),
    ),
  );
}

Obx _supervisorsDropdown(UpdateTicketController controller) {
  return Obx(
    (() => controller.workers.isNotEmpty
        ? FormBuilderDropdown(
            name: "supervisor_id",
            // onChanged: (value) => controller.handleDropDownListChange(value),
            validator: (value) =>
                value == null ? "tickets_fields_required".tr : null,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            initialValue: controller.ticket.value?.supervisorId,
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
          )
        : const SizedBox.shrink()),
  );
}

Obx _additionalEquipmentDropdown(UpdateTicketController controller) {
  return Obx(
    (() => FormBuilderCheckboxGroup(
          name: "additional_equipment_ids",
          // onChanged: (value) => controller.handleCheckboxListChange(value),
          // validator: FormBuilderValidators.required(context),
          decoration: InputDecoration(
            labelText: "tickets_fields_additionalEquipment".tr,
            // hintText: "tickets_fields_additional_equipment".tr,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(24),
            ),
          ),
          options: controller.allEquipment
              .map((equipment) => FormBuilderFieldOption(
                    value: equipment.id,
                    child: Text(equipment.number!),
                  ))
              .toList(),
        )),
  );
}
