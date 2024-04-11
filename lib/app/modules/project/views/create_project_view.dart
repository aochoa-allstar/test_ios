import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:onax_app/app/modules/project/controllers/create_project_controller.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

import 'package:get/get.dart';

class CreateProjectView extends GetView<CreateProjectController> {
  final CreateProjectController controller = Get.put(CreateProjectController());

  CreateProjectView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('projects_newProject'.tr),
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
              _customerDropDown(),
              const SizedBox(height: 16),
              _NameField(),
              const SizedBox(height: 16),
              _CoordinatesField(),
              const SizedBox(height: 16),
              _companyManDropDown(),
            ],
          ),
          RoundedLoadingButton(
            borderRadius: 16,
            color: Colors.black,
            onPressed: (() => controller.createProject()),
            controller: controller.submitButton,
            child: Text(
              'projects_create'.tr,
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

  Obx _customerDropDown() {
    return Obx(
      (() => FormBuilderDropdown(
            name: "customer_id",
            validator: (value) =>
                value == null ? "shift_fields_required".tr : null,
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
          )),
    );
  }

  FormBuilderTextField _NameField() {
    return FormBuilderTextField(
      name: "name",
      validator: (value) => value == null ? "shift_fields_required".tr : null,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      decoration: InputDecoration(
        labelText: "projects_fields_name".tr,
        hintText: "projects_fields_name".tr,
        contentPadding: EdgeInsets.all(16),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),
    );
  }

  Widget _CoordinatesField() {
    return Obx(() => controller.userLocation.value.latitude != null
        ? FormBuilderTextField(
            validator: (value) => validateCoords(value),
            autovalidateMode: AutovalidateMode.onUserInteraction,
            decoration: InputDecoration(
              labelText: "projects_fields_GPS".tr,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(24),
              ),
            ),
            readOnly: false,
            name: "coords",
            initialValue:
                "${controller.userLocation.value.latitude},${controller.userLocation.value.longitude}",
          )
        : TextField(
            readOnly: true,
            decoration: InputDecoration(
              labelText: "projects_fields_GPS".tr,
              icon: Container(
                width: 12,
                height: 12,
                child: CircularProgressIndicator(
                  strokeWidth: 2.0,
                ),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(24),
              ),
            ),
            controller: TextEditingController(text: ""),
          ));
  }

  Obx _companyManDropDown() {
    return Obx(
      (() => FormBuilderDropdown(
            name: "company_men_id",
            validator: (value) =>
                value == null ? "shift_fields_required".tr : null,
            valueTransformer: (value) => int.parse(value.toString()),
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
          )),
    );
  }

  String? validateCoords(String? value) {
    if (value == null || value.isEmpty) {
      return "jsas_create_fields_required".tr;
    }

    RegExp regex = RegExp(
        r'^[-+]?([1-8]?\d(\.\d+)?|90(\.0+)?),\s*[-+]?(180(\.0+)?|((1[0-7]\d)|([1-9]?\d))(\.\d+)?)$');

    if (!regex.hasMatch(value)) {
      return "jsas_create_fields_required".tr;
    }

    return null;
  }
}
