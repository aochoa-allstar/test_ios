import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:onax_app/app/modules/project/controllers/update_project_controller.dart';

import 'package:get/get.dart';

class UpdateProjectView extends GetView<UpdateProjectController> {
  final UpdateProjectController controller = Get.put(UpdateProjectController());

  UpdateProjectView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('projects_update'.tr),
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
      key: controller.createProjectFormBuilderKey.value,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              _NameField(),
              const SizedBox(height: 16),
              _customerDropDown(),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: _InitialDateField(),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: _EstimatedCompletionField(),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              _CostField(),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: _LatitudeField(),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: _LongitudeField(),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              _PoAfeField(),
              const SizedBox(height: 16),
              _companyManDropDown(),
              const SizedBox(height: 16),
              _TaxStateField(),
              const SizedBox(height: 16),
              _ProjectTypeField(),
              const SizedBox(height: 16),
              _DescriptionField(),
            ],
          ),
          // RoundedLoadingButton(
          //   borderRadius: 16,
          //   color: Colors.black,
          //   onPressed: (() => controller.createProject()),
          //   controller: controller.submitButton,
          //   child: Text(
          //     'projects_create'.tr,
          //     style: TextStyle(
          //       color: Colors.white,
          //       fontWeight: FontWeight.bold,
          //     ),
          //   ),
          // )
        ],
      ),
    );
  }

  Obx _customerDropDown() {
    return Obx(
      (() => controller.project.value?.customerId != null &&
              controller.customers.isNotEmpty
          ? FormBuilderDropdown(
              name: "customer_id",
              enabled: false,
              validator: (value) =>
                  value == null ? "shift_fields_required".tr : null,
              initialValue: controller.project.value?.customerId ?? null,
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
              autovalidateMode: AutovalidateMode.onUserInteraction,
              onChanged: (value) =>
                  controller.handleSelectedCustomerChange(value),
              valueTransformer: (value) => int.parse(value.toString()),
              decoration: InputDecoration(
                labelText: "projects_fields_customer".tr,
                hintText: "projects_fields_customer".tr,
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
            )
          : FormBuilderDropdown(
              name: "",
              validator: (value) =>
                  value == null ? "shift_fields_required".tr : null,
              initialValue: controller.project.value?.customerId ?? null,
              icon: Container(
                margin: EdgeInsets.only(right: 8),
                width: 12,
                height: 12,
                child: CircularProgressIndicator(
                  strokeWidth: 2.0,
                ),
              ),
              decoration: InputDecoration(
                labelText: "projects_fields_customer".tr,
                hintText: "projects_fields_customer".tr,
                contentPadding: EdgeInsets.all(16),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              items: [],
            )),
    );
  }

  Obx _NameField() {
    return Obx(() => FormBuilderTextField(
          name: "name",
          enabled: false,
          initialValue: controller.project.value?.name,
          validator: (value) =>
              value == null ? "shift_fields_required".tr : null,
          maxLines: controller.project.value?.name != null &&
                  controller.project.value?.name.length >= 60
              ? 2
              : 1,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          decoration: InputDecoration(
            labelText: "projects_fields_name".tr,
            hintText: "projects_fields_name".tr,
            contentPadding: EdgeInsets.all(16),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
            ),
          ),
        ));
  }

  Obx _CostField() {
    return Obx(() => FormBuilderTextField(
          name: "cost",
          enabled: false,
          initialValue: controller.project.value?.cost.toString(),
          validator: (value) =>
              value == null ? "shift_fields_required".tr : null,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          decoration: InputDecoration(
            labelText: "projects_fields_cost".tr,
            hintText: "projects_fields_cost".tr,
            contentPadding: EdgeInsets.all(16),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
            ),
          ),
        ));
  }

  Obx _LatitudeField() {
    return Obx(() => FormBuilderTextField(
          name: "latitude",
          enabled: false,
          initialValue: controller.project.value?.latitude.toString(),
          validator: (value) =>
              value == null ? "shift_fields_required".tr : null,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          decoration: InputDecoration(
            labelText: "projects_fields_latitude".tr,
            hintText: "projects_fields_latitude".tr,
            contentPadding: EdgeInsets.all(16),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
            ),
          ),
        ));
  }

  Obx _LongitudeField() {
    return Obx(() => FormBuilderTextField(
          name: "longitude",
          enabled: false,
          initialValue: controller.project.value?.longitude.toString(),
          validator: (value) =>
              value == null ? "shift_fields_required".tr : null,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          decoration: InputDecoration(
            labelText: "projects_fields_longitude".tr,
            hintText: "projects_fields_longitude".tr,
            contentPadding: EdgeInsets.all(16),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
            ),
          ),
        ));
  }

  Obx _TaxStateField() {
    return Obx(() => FormBuilderTextField(
          name: "table_income_tax_state_id",
          enabled: false,
          initialValue:
              controller.project.value?.tableIncomeTaxStateId.toString(),
          validator: (value) =>
              value == null ? "shift_fields_required".tr : null,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          decoration: InputDecoration(
            labelText: "projects_fields_taxState".tr,
            hintText: "projects_fields_taxState".tr,
            contentPadding: EdgeInsets.all(16),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
            ),
          ),
        ));
  }

  Obx _DescriptionField() {
    return Obx(() => FormBuilderTextField(
          name: "description",
          enabled: false,
          maxLines: controller.project.value?.description != null &&
                  controller.project.value?.description.length! >= 60
              ? 4
              : 1,
          initialValue: controller.project.value?.description.toString(),
          validator: (value) =>
              value == null ? "shift_fields_required".tr : null,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          decoration: InputDecoration(
            labelText: "projects_fields_description".tr,
            hintText: "projects_fields_description".tr,
            contentPadding: EdgeInsets.all(16),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
            ),
          ),
        ));
  }

  Obx _ProjectTypeField() {
    return Obx(() => FormBuilderTextField(
          name: "project_type",
          enabled: false,
          initialValue: controller.project.value?.projectType.toString(),
          validator: (value) =>
              value == null ? "shift_fields_required".tr : null,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          decoration: InputDecoration(
            labelText: "projects_fields_type".tr,
            hintText: "projects_fields_type".tr,
            contentPadding: EdgeInsets.all(16),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
            ),
          ),
        ));
  }

  Obx _PoAfeField() {
    return Obx(() => FormBuilderTextField(
          name: "po_afe",
          enabled: false,
          initialValue: controller.project.value?.poAfe.toString(),
          validator: (value) =>
              value == null ? "shift_fields_required".tr : null,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          decoration: InputDecoration(
            labelText: "projects_fields_PoAfe".tr,
            hintText: "projects_fields_PoAfe".tr,
            contentPadding: EdgeInsets.all(16),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
            ),
          ),
        ));
  }

  Obx _InitialDateField() {
    return Obx(() => FormBuilderDateTimePicker(
          name: "initial_date",
          enabled: false,
          initialValue: controller.project.value?.initialDate != null
              ? DateTime.parse(controller.project.value!.initialDate)
              : null,
          validator: (value) =>
              value == null ? "shift_fields_required".tr : null,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          decoration: InputDecoration(
            labelText: "projects_fields_initialDate".tr,
            hintText: "projects_fields_initialDate".tr,
            contentPadding: EdgeInsets.all(16),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
            ),
          ),
        ));
  }

  Obx _EstimatedCompletionField() {
    return Obx(() => FormBuilderDateTimePicker(
          name: "estimated_completion",
          enabled: false,
          initialValue: controller.project.value?.estimatedCompletion != null
              ? DateTime.parse(controller.project.value!.estimatedCompletion)
              : null,
          validator: (value) =>
              value == null ? "shift_fields_required".tr : null,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          decoration: InputDecoration(
            labelText: "projects_fields_estimatedCompletion".tr,
            hintText: "projects_fields_estimatedCompletion".tr,
            contentPadding: EdgeInsets.all(16),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
            ),
          ),
        ));
  }

  Obx _companyManDropDown() {
    return Obx(
      (() => controller.companyMen.isNotEmpty
          ? FormBuilderDropdown(
              name: "company_men_id",
              validator: (value) =>
                  value == null ? "shift_fields_required".tr : null,
              valueTransformer: (value) => int.parse(value.toString()),
              initialValue: controller.project.value?.companyMenId ?? null,
              autovalidateMode: AutovalidateMode.onUserInteraction,
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
              decoration: InputDecoration(
                labelText: "projects_fields_companyMan".tr,
                hintText: "projects_fields_companyMan".tr,
                contentPadding: EdgeInsets.all(16),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              items: controller.filtredCompanyMan
                  .map((companyMan) => DropdownMenuItem(
                        child: Text(companyMan.name),
                        value: "${companyMan.id}",
                      ))
                  .toList(),
            )
          : FormBuilderDropdown(
              name: "company_men_id",
              validator: (value) =>
                  value == null ? "shift_fields_required".tr : null,
              valueTransformer: (value) => int.parse(value.toString()),
              autovalidateMode: AutovalidateMode.onUserInteraction,
              icon: Container(
                margin: EdgeInsets.only(right: 8),
                width: 12,
                height: 12,
                child: CircularProgressIndicator(
                  strokeWidth: 2.0,
                ),
              ),
              decoration: InputDecoration(
                labelText: "projects_fields_companyMan".tr,
                hintText: "projects_fields_companyMan".tr,
                contentPadding: EdgeInsets.all(16),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              items: [],
            )),
    );
  }
}
