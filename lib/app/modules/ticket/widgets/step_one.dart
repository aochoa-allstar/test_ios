import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import 'package:onax_app/app/modules/ticket/controllers/update_ticket_controller.dart';

Step stepOne(int stepIndex, formKey) {
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
        child: Column(
          children: [
            _customersDropdown(),
            const SizedBox(height: 16),
            _projectsDropdown(),
            const SizedBox(height: 16),
            _companyMenDropdown(),
            const SizedBox(height: 16),
            _equipmentsDropdown(),
            const SizedBox(height: 16),
            FormBuilderDropdown(
              name: "helper",
              enabled: false,
              initialValue: controller.currentShift.value?.helperId,
              icon: controller.helpers.isEmpty
                  ? Container(
                      margin: EdgeInsets.only(right: 8),
                      width: 12,
                      height: 12,
                      child: CircularProgressIndicator(
                        strokeWidth: 2.0,
                      ),
                    )
                  : null,
              decoration: InputDecoration(
                hintText: "shift_fields_helper_one".tr,
                labelText: "shift_fields_helper_one".tr,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(24),
                ),
              ),
              items: controller.helpers.isEmpty
                  ? []
                  : [
                      ...controller.helpers.map((e) => DropdownMenuItem(
                          child: Text(e.name ?? ""), value: e.id))
                    ],
            ),
            if (controller.currentShift.value?.helper2Id != null)
              const SizedBox(height: 16),
            if (controller.currentShift.value?.helper2Id != null)
              FormBuilderDropdown(
                name: "helper2_id",
                enabled: false,
                icon: controller.helpers.isEmpty
                    ? Container(
                        margin: EdgeInsets.only(right: 8),
                        width: 12,
                        height: 12,
                        child: CircularProgressIndicator(
                          strokeWidth: 2.0,
                        ),
                      )
                    : null,
                decoration: InputDecoration(
                  hintText: "shift_fields_helper_two".tr,
                  labelText: "shift_fields_helper_two".tr,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(24),
                  ),
                ),
                items: controller.helpers.isEmpty
                    ? []
                    : [
                        ...controller.helpers.map((e) => DropdownMenuItem(
                            child: Text(e.name ?? ""), value: e.id))
                      ],
              ),
            if (controller.currentShift.value?.helper3Id != null)
              const SizedBox(height: 16),
            if (controller.currentShift.value?.helper3Id != null)
              FormBuilderDropdown(
                name: "helper3_id",
                enabled: false,
                icon: controller.helpers.isEmpty
                    ? Container(
                        margin: EdgeInsets.only(right: 8),
                        width: 12,
                        height: 12,
                        child: CircularProgressIndicator(
                          strokeWidth: 2.0,
                        ),
                      )
                    : null,
                decoration: InputDecoration(
                  hintText: "shift_fields_helper_three".tr,
                  labelText: "shift_fields_helper_three".tr,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(24),
                  ),
                ),
                items: controller.helpers.isEmpty
                    ? []
                    : [
                        ...controller.helpers.map((e) => DropdownMenuItem(
                            child: Text(e.name ?? ""), value: e.id))
                      ],
              ),
            const SizedBox(height: 16),
            const Divider(),
            const SizedBox(height: 16),
            ...aditionalHelpersDropdown(controller),
          ],
        ),
      ),
    ),
  );
}

Obx _customersDropdown() {
  UpdateTicketController controller = Get.find();

  return Obx(
    (() => FormBuilderDropdown(
          enabled: false,
          name: "customer_id",
          icon: controller.customers.isEmpty
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
            labelText: "tickets_fields_customer".tr,
            hintText: "tickets_fields_customer".tr,
            contentPadding: EdgeInsets.all(16),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
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

Obx _projectsDropdown() {
  UpdateTicketController controller = Get.find();

  return Obx(
    (() => FormBuilderDropdown(
          enabled: false,
          name: "project_id",
          icon: controller.projects.isEmpty
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
            labelText: "tickets_fields_project".tr,
            hintText: "tickets_fields_project".tr,
            contentPadding: EdgeInsets.all(16),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
            ),
          ),
          items: controller.projects
              .map((project) => DropdownMenuItem(
                    child: Text(project.name),
                    value: project.id,
                  ))
              .toList(),
        )),
  );
}

Obx _companyMenDropdown() {
  UpdateTicketController controller = Get.find();

  return Obx(
    (() => FormBuilderDropdown(
          enabled: false,
          name: "company_man_id",
          icon: controller.companyMen.isEmpty
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
            labelText: "tickets_fields_companyMan".tr,
            hintText: "tickets_fields_companyMan".tr,
            contentPadding: EdgeInsets.all(16),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
            ),
          ),
          items: controller.companyMen
              .map((companyMan) => DropdownMenuItem(
                    child: Text(companyMan.name),
                    value: companyMan.id,
                  ))
              .toList(),
        )),
  );
}

Obx _equipmentsDropdown() {
  UpdateTicketController controller = Get.find();
  return Obx(
    (() => FormBuilderDropdown(
          enabled: false,
          name: "equipment_id",
          icon: controller.equipments.isEmpty
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
            contentPadding: EdgeInsets.all(16),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
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

List<Column> aditionalHelpersDropdown(UpdateTicketController controller) {
  return controller.aditionalWorkers
      .map(
        (e) => Column(
          children: [
            FormBuilderDropdown(
              enabled: false,
              name: "aditional_helper_${e["workerId"]}",
              icon: controller.helpers.isEmpty
                  ? Container(
                      margin: EdgeInsets.only(right: 8),
                      width: 12,
                      height: 12,
                      child: CircularProgressIndicator(
                        strokeWidth: 2.0,
                      ),
                    )
                  : null,
              initialValue: e["workerId"],
              decoration: InputDecoration(
                hintText: "tickets_fields_aditionalHelper".tr,
                labelText: "tickets_fields_aditionalHelper".tr,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(24),
                ),
              ),
              items: controller.helpers.isEmpty
                  ? []
                  : [
                      ...controller.helpers.map((e) => DropdownMenuItem(
                            child: Text(e.name ?? ""),
                            value: e.id,
                          ))
                    ],
            ),
            const SizedBox(height: 16),
          ],
        ),
      )
      .toList();
}
