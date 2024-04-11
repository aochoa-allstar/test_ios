import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import 'package:hand_signature/signature.dart';

import 'package:onax_app/app/modules/jsa/controllers/create_jsa_controller.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

class CreateJSAView extends GetView<CreateJSAController> {
  CreateJSAView({Key? key}) : super(key: key);

  final CreateJSAController controller = Get.put(CreateJSAController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('jsas_create_submit'.tr),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 0),
          child: GestureDetector(
            onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
            child: _stepperList(),
          ),
        ),
      ),
    );
  }

  //Sttepper
  Obx _stepperList() {
    return Obx(
      () => Stepper(
        physics: controller.stepperIsScrollable.value
            ? ScrollPhysics()
            : NeverScrollableScrollPhysics(),
        controller: controller.scrollController,
        currentStep: controller.currentStepIndex.value,
        onStepTapped: (value) => controller.hanldeGoToStep(value),
        onStepContinue: () =>
            controller.handleOnStepContinue(controller.currentStepIndex.value),
        controlsBuilder: (context, details) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              controller.currentStepIndex == controller.stepsFormKeys.length - 1
                  ? RoundedLoadingButton(
                      borderRadius: 16,
                      color: Colors.black,
                      controller: controller.submitButton,
                      onPressed: () => controller.handleOnSubmit(),
                      child: Text(
                        "jsas_create_submit".tr,
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    )
                  : FilledButton(
                      onPressed: details.onStepContinue,
                      child: Text("jsas_create_continue".tr),
                    )
            ],
          );
        },
        steps: controller.stepsFormKeys
            .asMap()
            .entries
            .map((mapEntry) => getStepperBody(mapEntry.key, mapEntry.value))
            .toList(),
      ),
    );
  }

  //Stepper body generator
  Step getStepperBody(int stepIndex, GlobalKey<FormBuilderState> formKey) {
    switch (stepIndex) {
      case 0:
        return _step1Body(stepIndex, formKey);
      case 1:
        return _step2Body(stepIndex, formKey);
      case 2:
        return _step3Body(stepIndex, formKey);
      case 3:
        return _step4Body(stepIndex, formKey);
      case 4:
        return _step5Body(stepIndex, formKey);
      case 5:
        return _step6Body(stepIndex, formKey);
      case 6:
        return _step7Body(stepIndex, formKey);
      case 7:
        return _step8Body(stepIndex, formKey);
      case 8:
        return _step9Body(stepIndex, formKey);
      case 9:
        return _step10Body(stepIndex, formKey);
      case 10:
        return _step11Body(stepIndex, formKey);
      case 11:
        return _step12Body(stepIndex, formKey);
      default:
        return Step(
            title: Text("jsas_create_steps_step${stepIndex + 1}".tr),
            content: Text("Not implemented yet"));
    }
  }

  //Steps
  Step _step1Body(int stepIndex, GlobalKey<FormBuilderState> formKey) {
    return Step(
      isActive: controller.currentStepIndex >= 0,
      title: Text("jsas_create_steps_step${stepIndex + 1}".tr),
      content: Container(
        padding: EdgeInsets.symmetric(vertical: 12),
        child: FormBuilder(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FormBuilderDropdown(
                    name: "customer_id",
                    // initialValue: controller.ticketCustomerId.value,
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
                    enabled: false,
                    validator: (value) =>
                        value == null ? "jsas_create_fields_required".tr : null,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    decoration: InputDecoration(
                      hintText: "jsas_create_fields_customer".tr,
                      labelText: "jsas_create_fields_customer".tr,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(24),
                      ),
                    ),
                    items: controller.customers.isEmpty
                        ? []
                        : [
                            ...controller.customers.map((e) => DropdownMenuItem(
                                child: Text(e.name), value: e.id))
                          ]),
                const SizedBox(height: 16),
                FormBuilderDropdown(
                  name: "project_id",
                  enabled: false,
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
                      value == null ? "jsas_create_fields_required".tr : null,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  decoration: InputDecoration(
                    hintText: "jsas_create_fields_project".tr,
                    labelText: "jsas_create_fields_project".tr,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(24),
                    ),
                  ),
                  items: controller.projects.isEmpty
                      ? []
                      : [
                          ...controller.projects.map(
                            (e) => DropdownMenuItem(
                                child: Text(e.name), value: e.id),
                          )
                        ],
                ),
                const SizedBox(height: 16),
                FormBuilderTextField(
                  validator: (value) => value == null || value.isEmpty
                      ? "jsas_create_fields_required".tr
                      : null,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  decoration: InputDecoration(
                    labelText: "jsas_create_fields_jobDescription".tr,
                    hintText: "jsas_create_fields_jobDescription".tr,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(24),
                    ),
                  ),
                  name: "job_description",
                  maxLines: 3,
                ),
                const SizedBox(height: 16),
                controller.userLocation.value.latitude != null
                    ? FormBuilderTextField(
                        validator: (value) => value == null
                            ? "jsas_create_fields_required".tr
                            : null,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        decoration: InputDecoration(
                          labelText: "jsas_create_fields_GPS".tr,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(24),
                          ),
                        ),
                        readOnly: true,
                        name: "coords",
                        initialValue:
                            "${controller.userLocation.value.latitude},${controller.userLocation.value.longitude}",
                      )
                    : TextField(
                        readOnly: true,
                        decoration: InputDecoration(
                          labelText: "jsas_create_fields_GPS".tr,
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
                      ),
                const SizedBox(height: 16),
                if (controller.currentShift.value?.helperId != null &&
                    controller.helpers.isNotEmpty)
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
                if (controller.currentShift.value?.helper2Id != null &&
                    controller.helpers.isNotEmpty)
                  FormBuilderDropdown(
                    name: "helper2_id",
                    enabled: false,
                    initialValue: controller.currentShift.value?.helper2Id,
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
                if (controller.currentShift.value?.helper3Id != null &&
                    controller.helpers.isNotEmpty)
                  FormBuilderDropdown(
                    name: "helper3_id",
                    enabled: false,
                    initialValue: controller.currentShift.value?.helper3Id,
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
            )),
      ),
    );
  }

  Step _step2Body(int stepIndex, GlobalKey<FormBuilderState> formKey) {
    return Step(
      isActive: controller.currentStepIndex >= 1,
      title: Text("jsas_create_steps_step${stepIndex + 1}".tr),
      content: Container(
        padding: EdgeInsets.symmetric(vertical: 12),
        child: FormBuilder(
          key: formKey,
          child: FormBuilderCheckboxGroup(
            name: "items",
            validator: (value) => value == null || value.length <= 0
                ? "jsas_create_fields_required".tr
                : null,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            decoration: InputDecoration(
              border: InputBorder.none,
            ),
            options: [
              FormBuilderFieldOption(
                value: "steel_toad_shoes",
                child: Text("jsas_create_fields_steel_toad_shoes".tr),
              ),
              FormBuilderFieldOption(
                value: "hard_hat",
                child: Text("jsas_create_fields_hard_hat".tr),
              ),
              FormBuilderFieldOption(
                value: "safety_glasses",
                child: Text("jsas_create_fields_safety_glasses".tr),
              ),
              FormBuilderFieldOption(
                value: "h2s_monitor",
                child: Text("jsas_create_fields_h2s_monitor".tr),
              ),
              FormBuilderFieldOption(
                value: "fr_clothing",
                child: Text("jsas_create_fields_fr_clothing".tr),
              ),
              FormBuilderFieldOption(
                value: "fall_protection",
                child: Text("jsas_create_fields_fall_protection".tr),
              ),
              FormBuilderFieldOption(
                value: "hearing_protection",
                child: Text("jsas_create_fields_hearing_protection".tr),
              ),
              FormBuilderFieldOption(
                value: "respirator",
                child: Text("jsas_create_fields_respirator".tr),
              ),
              FormBuilderFieldOption(
                value: "other_safety_equipment",
                child: FormBuilderTextField(
                  name: "other_safety_equipment_name",
                  validator: (value) => formKey.currentState!.value["items"] !=
                                  null &&
                              ((formKey.currentState!.value["items"] as dynamic)
                                      .contains("other_safety_equipment") &&
                                  value == null) ||
                          formKey.currentState!.value["items"] != null &&
                              ((formKey.currentState!.value["items"] as dynamic)
                                      .contains("other_safety_equipment") &&
                                  value!.isEmpty)
                      ? "jsas_create_fields_required".tr
                      : null,
                  autovalidateMode: AutovalidateMode.always,
                  decoration: InputDecoration(
                    labelText: "jsas_create_fields_other".tr,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(24),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Step _step3Body(int stepIndex, GlobalKey<FormBuilderState> formKey) {
    return Step(
      isActive: controller.currentStepIndex >= 2,
      title: Text("jsas_create_steps_step${stepIndex + 1}".tr),
      content: Container(
        padding: EdgeInsets.symmetric(vertical: 12),
        child: FormBuilder(
          key: formKey,
          child: FormBuilderCheckboxGroup(
            name: "items",
            validator: (value) => value == null || value.length <= 0
                ? "jsas_create_fields_required".tr
                : null,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            decoration: InputDecoration(
              border: InputBorder.none,
            ),
            options: [
              FormBuilderFieldOption(
                value: "fail_potential",
                child: Text("jsas_create_fields_fail_potential".tr),
              ),
              FormBuilderFieldOption(
                value: "overhead_lift",
                child: Text("jsas_create_fields_overhead_lift".tr),
              ),
              FormBuilderFieldOption(
                value: "h2s",
                child: Text("jsas_create_fields_h2s".tr),
              ),
              FormBuilderFieldOption(
                value: "pinch_points",
                child: Text("jsas_create_fields_pinch_points".tr),
              ),
              FormBuilderFieldOption(
                value: "slip_trip",
                child: Text("jsas_create_fields_slip_trip".tr),
              ),
              FormBuilderFieldOption(
                value: "sharp_objects",
                child: Text("jsas_create_fields_sharp_objects".tr),
              ),
              FormBuilderFieldOption(
                value: "power_tools",
                child: Text("jsas_create_fields_power_tools".tr),
              ),
              FormBuilderFieldOption(
                value: "hot_cold_surface",
                child: Text("jsas_create_fields_hot_cold_surface".tr),
              ),
              FormBuilderFieldOption(
                value: "pressure",
                child: Text("jsas_create_fields_pressure".tr),
              ),
              FormBuilderFieldOption(
                value: "heavy_lifting",
                child: Text("jsas_create_fields_heavy_lifting".tr),
              ),
              FormBuilderFieldOption(
                value: "weather",
                child: Text("jsas_create_fields_weather".tr),
              ),
              FormBuilderFieldOption(
                value: "flammables",
                child: Text("jsas_create_fields_flammables".tr),
              ),
              FormBuilderFieldOption(
                value: "chemicals",
                child: Text("jsas_create_fields_chemicals".tr),
              ),
              FormBuilderFieldOption(
                value: "other_hazards",
                child: FormBuilderTextField(
                  validator: (value) => formKey.currentState!.value["items"] !=
                                  null &&
                              ((formKey.currentState!.value["items"] as dynamic)
                                      .contains("other_hazards") &&
                                  value == null) ||
                          formKey.currentState!.value["items"] != null &&
                              ((formKey.currentState!.value["items"] as dynamic)
                                      .contains("other_hazards") &&
                                  value!.isEmpty)
                      ? "jsas_create_fields_required".tr
                      : null,
                  name: "other_hazards_name",
                  decoration: InputDecoration(
                    labelText: "jsas_create_fields_other".tr,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(24),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Step _step4Body(int stepIndex, GlobalKey<FormBuilderState> formKey) {
    return Step(
      isActive: controller.currentStepIndex >= 3,
      title: Text("jsas_create_steps_step${stepIndex + 1}".tr),
      content: Container(
        padding: EdgeInsets.symmetric(vertical: 12),
        child: FormBuilder(
          key: formKey,
          child: FormBuilderCheckboxGroup(
            name: "items",
            decoration: InputDecoration(
              border: InputBorder.none,
            ),
            options: [
              FormBuilderFieldOption(
                value: "confined_spaces_permits",
                child: Text("jsas_create_fields_confined_spaces_permits".tr),
              ),
              FormBuilderFieldOption(
                value: "hot_work_permit",
                child: Text("jsas_create_fields_hot_work_permit".tr),
              ),
              FormBuilderFieldOption(
                value: "excavation_trenching",
                child: Text("jsas_create_fields_excavation_trenching".tr),
              ),
              FormBuilderFieldOption(
                value: "one_call",
                child: FormBuilderTextField(
                  validator: (value) => formKey.currentState!.value["items"] !=
                                  null &&
                              ((formKey.currentState!.value["items"] as dynamic)
                                      .contains("one_call") &&
                                  value == null) ||
                          formKey.currentState!.value["items"] != null &&
                              ((formKey.currentState!.value["items"] as dynamic)
                                      .contains("one_call") &&
                                  value!.isEmpty)
                      ? "jsas_create_fields_required".tr
                      : null,
                  name: "one_call_num",
                  decoration: InputDecoration(
                    labelText: "jsas_create_fields_one_call_num".tr,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(24),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Step _step5Body(int stepIndex, GlobalKey<FormBuilderState> formKey) {
    return Step(
      isActive: controller.currentStepIndex >= 4,
      title: Text("jsas_create_steps_step${stepIndex + 1}".tr),
      content: Container(
        padding: EdgeInsets.symmetric(vertical: 12),
        child: FormBuilder(
          key: formKey,
          child: FormBuilderCheckboxGroup(
            name: "items",
            validator: (value) => value == null || value.length <= 0
                ? "jsas_create_fields_required".tr
                : null,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            decoration: InputDecoration(
              border: InputBorder.none,
            ),
            options: [
              FormBuilderFieldOption(
                value: "lock_out_tag_out",
                child: Text("jsas_create_fields_lock_out_tag_out".tr),
              ),
              FormBuilderFieldOption(
                value: "fire_extinguisher",
                child: Text("jsas_create_fields_fire_extinguisher".tr),
              ),
              FormBuilderFieldOption(
                value: "inspection_of_equipment",
                child: Text("jsas_create_fields_inspection_of_equipment".tr),
              ),
              FormBuilderFieldOption(
                value: "msds_review",
                child: Text("jsas_create_fields_msds_review".tr),
              ),
              FormBuilderFieldOption(
                value: "ladder",
                child: Text("jsas_create_fields_ladder".tr),
              ),
              FormBuilderFieldOption(
                value: "permits",
                child: Text("jsas_create_fields_permits".tr),
              ),
              FormBuilderFieldOption(
                value: "other_check_review",
                child: FormBuilderTextField(
                  validator: (value) => formKey.currentState!.value["items"] !=
                                  null &&
                              ((formKey.currentState!.value["items"] as dynamic)
                                      .contains("other_check_review") &&
                                  value == null) ||
                          formKey.currentState!.value["items"] != null &&
                              ((formKey.currentState!.value["items"] as dynamic)
                                      .contains("other_check_review") &&
                                  value!.isEmpty)
                      ? "jsas_create_fields_required".tr
                      : null,
                  name: "weather_condition_description ",
                  decoration: InputDecoration(
                    labelText: "jsas_create_fields_other".tr,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(24),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Step _step6Body(int stepIndex, GlobalKey<FormBuilderState> formKey) {
    return Step(
      isActive: controller.currentStepIndex >= 5,
      title: Text("jsas_create_steps_step${stepIndex + 1}".tr),
      content: Container(
        padding: EdgeInsets.symmetric(vertical: 12),
        child: FormBuilder(
          key: formKey,
          child: FormBuilderCheckboxGroup(
            name: "items",
            validator: (value) => value == null || value.length <= 0
                ? "jsas_create_fields_required".tr
                : null,
            wrapSpacing: 16.0,
            wrapRunSpacing: 16.0,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            decoration: InputDecoration(
              border: InputBorder.none,
            ),
            options: [
              FormBuilderFieldOption(
                value: "weather_condition",
                child: FormBuilderTextField(
                  validator: (value) => formKey.currentState!.value["items"] !=
                                  null &&
                              ((formKey.currentState!.value["items"] as dynamic)
                                      .contains("weather_condition") &&
                                  value == null) ||
                          formKey.currentState!.value["items"] != null &&
                              ((formKey.currentState!.value["items"] as dynamic)
                                      .contains("weather_condition") &&
                                  value!.isEmpty)
                      ? "jsas_create_fields_required".tr
                      : null,
                  name: "weather_condition_description",
                  decoration: InputDecoration(
                    labelText: "jsas_create_fields_weather_conditions".tr,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(24),
                    ),
                  ),
                ),
              ),
              FormBuilderFieldOption(
                value: "wind_direction",
                child: FormBuilderTextField(
                  validator: (value) => formKey.currentState!.value["items"] !=
                                  null &&
                              ((formKey.currentState!.value["items"] as dynamic)
                                      .contains("wind_direction") &&
                                  value == null) ||
                          ((formKey.currentState!.value["items"] as dynamic)
                                  .contains("wind_direction") &&
                              value!.isEmpty)
                      ? "jsas_create_fields_required".tr
                      : null,
                  name: "wind_direction_description",
                  decoration: InputDecoration(
                    labelText: "jsas_create_fields_wind_direction".tr,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(24),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Step _step7Body(int stepIndex, GlobalKey<FormBuilderState> formKey) {
    return Step(
      isActive: controller.currentStepIndex >= 6,
      title: Text("jsas_create_steps_step${stepIndex + 1}".tr),
      content: Container(
        padding: EdgeInsets.symmetric(vertical: 12),
        child: FormBuilder(
          key: formKey,
          child: FormBuilderTextField(
            name: "task",
            maxLines: 5,
            validator: (value) => value == null || value.isEmpty
                ? "jsas_create_fields_required".tr
                : null,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            decoration: InputDecoration(
                labelText: "jsas_create_fields_task".tr,
                hintText: "jsas_create_fields_task".tr,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(24),
                )),
          ),
        ),
      ),
    );
  }

  Step _step8Body(int stepIndex, GlobalKey<FormBuilderState> formKey) {
    return Step(
      isActive: controller.currentStepIndex >= 7,
      title: Text("jsas_create_steps_step${stepIndex + 1}".tr),
      content: Container(
        padding: EdgeInsets.symmetric(vertical: 12),
        child: FormBuilder(
          key: formKey,
          child: FormBuilderTextField(
            name: "hazard",
            maxLines: 5,
            validator: (value) => value == null || value.isEmpty
                ? "jsas_create_fields_required".tr
                : null,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            decoration: InputDecoration(
                labelText: "jsas_create_fields_hazard".tr,
                hintText: "jsas_create_fields_hazard".tr,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(24),
                )),
          ),
        ),
      ),
    );
  }

  Step _step9Body(int stepIndex, GlobalKey<FormBuilderState> formKey) {
    return Step(
      isActive: controller.currentStepIndex >= 8,
      title: Text("jsas_create_steps_step${stepIndex + 1}".tr),
      content: Container(
        padding: EdgeInsets.symmetric(vertical: 12),
        child: FormBuilder(
          key: formKey,
          child: FormBuilderTextField(
            name: "controls",
            maxLines: 5,
            validator: (value) => value == null || value.isEmpty
                ? "jsas_create_fields_required".tr
                : null,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            decoration: InputDecoration(
                labelText: "jsas_create_fields_controls".tr,
                hintText: "jsas_create_fields_controls".tr,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(24),
                )),
          ),
        ),
      ),
    );
  }

  Step _step10Body(int stepIndex, GlobalKey<FormBuilderState> formKey) {
    return Step(
      isActive: controller.currentStepIndex >= 9,
      title: Text("jsas_create_steps_step${stepIndex + 1}".tr),
      content: Container(
        padding: EdgeInsets.symmetric(vertical: 12),
        child: FormBuilder(
          key: formKey,
          child: FormBuilderTextField(
            name: "recommended_actions_and_procedures",
            maxLines: 5,
            validator: (value) => value == null || value.isEmpty
                ? "jsas_create_fields_required".tr
                : null,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            decoration: InputDecoration(
                labelText:
                    "jsas_create_fields_recommended_actions_and_procedures".tr,
                hintText:
                    "jsas_create_fields_recommended_actions_and_procedures".tr,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(24),
                )),
          ),
        ),
      ),
    );
  }

  Step _step11Body(int stepIndex, GlobalKey<FormBuilderState> formKey) {
    return Step(
      isActive: controller.currentStepIndex >= 10,
      title: Text("jsas_create_steps_step${stepIndex + 1}".tr),
      content: Container(
        padding: EdgeInsets.symmetric(vertical: 12),
        child: FormBuilder(
          key: formKey,
          child: FormBuilderField(
            validator: (value) =>
                value == null ? "jsas_create_fields_required".tr : null,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            builder: (field) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  signaturePad(field, controller.step11SignatureControl),
                  const SizedBox(height: 12),
                  TextButton(
                    onPressed: () => controller.handleOnClearSignature(
                        controller.step11SignatureControl, field),
                    child: Text("jsas_create_clear".tr),
                  )
                ],
              );
            },
            name: "muster_points",
          ),
        ),
      ),
    );
  }

  Step _step12Body(int stepIndex, GlobalKey<FormBuilderState> formKey) {
    return Step(
      isActive: controller.currentStepIndex >= 11,
      title: Text("jsas_create_steps_step${stepIndex + 1}".tr),
      content: Container(
        padding: EdgeInsets.symmetric(vertical: 12),
        child: FormBuilder(
          key: formKey,
          child: Column(
            children: [
              FormBuilderField(
                validator: (value) =>
                    value == null ? "jsas_create_fields_required".tr : null,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                builder: (field) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      signaturePad(field, controller.step12SignatureControl1),
                      const SizedBox(height: 12),
                      if (controller.currentShift.value?.workerId != null)
                        Text(
                          controller.currentWorker.value?.name ?? "",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                          ),
                        ),
                      const SizedBox(height: 12),
                      if (!field.hasError)
                        TextButton(
                          onPressed: () => controller.handleOnClearSignature(
                              controller.step12SignatureControl1, field),
                          child: Text("jsas_create_clear".tr),
                        )
                    ],
                  );
                },
                name: "signature1",
              ),
              controller.globalFormData.value["helper"] != null
                  ? FormBuilderField(
                      validator: (value) => value == null
                          ? "jsas_create_fields_required".tr
                          : null,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      builder: (field) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            signaturePad(
                                field, controller.step12SignatureControl2),
                            const SizedBox(height: 12),
                            if (controller.helper1.value != null)
                              Text(
                                  "jsas_create_helper".tr +
                                      "${controller.helper1.value!.name ?? ""}",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12,
                                  )),
                            const SizedBox(height: 12),
                            if (!field.hasError)
                              TextButton(
                                onPressed: () =>
                                    controller.handleOnClearSignature(
                                        controller.step12SignatureControl2,
                                        field),
                                child: Text("jsas_create_clear".tr),
                              )
                          ],
                        );
                      },
                      name: "signature2",
                    )
                  : const SizedBox.shrink(),
              controller.globalFormData.value["helper2_id"] != null
                  ? FormBuilderField(
                      validator: (value) => value == null
                          ? "jsas_create_fields_required".tr
                          : null,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      builder: (field) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            signaturePad(
                                field, controller.step12SignatureControl3),
                            const SizedBox(height: 12),
                            if (controller.helper2.value != null)
                              Text(
                                  "jsas_create_helper".tr +
                                      "${controller.helper2.value!.name ?? ""}",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12,
                                  )),
                            const SizedBox(height: 12),
                            if (!field.hasError)
                              TextButton(
                                onPressed: () =>
                                    controller.handleOnClearSignature(
                                        controller.step12SignatureControl3,
                                        field),
                                child: Text("jsas_create_clear".tr),
                              )
                          ],
                        );
                      },
                      name: "signature3",
                    )
                  : const SizedBox.shrink(),
              controller.globalFormData.value["helper3_id"] != null
                  ? FormBuilderField(
                      validator: (value) => value == null
                          ? "jsas_create_fields_required".tr
                          : null,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      builder: (field) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            signaturePad(
                                field, controller.step12SignatureControl4),
                            const SizedBox(height: 12),
                            if (controller.helper3.value != null)
                              Text(
                                  "jsas_create_helper".tr +
                                      "${controller.helper3.value!.name ?? ""}",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12,
                                  )),
                            const SizedBox(height: 12),
                            if (!field.hasError)
                              TextButton(
                                onPressed: () =>
                                    controller.handleOnClearSignature(
                                        controller.step12SignatureControl4,
                                        field),
                                child: Text("jsas_create_clear".tr),
                              )
                          ],
                        );
                      },
                      name: "signature4",
                    )
                  : const SizedBox.shrink(),
              const SizedBox(height: 16),
              const Divider(),
              const SizedBox(height: 16),
              Obx(
                () => controller.aditionalWorkers.isNotEmpty
                    ? Column(
                        children: controller.aditionalWorkers
                            .asMap()
                            .entries
                            .map((e) {
                          final index = e.key;

                          return FormBuilderField(
                              validator: (value) => value == null
                                  ? "jsas_create_fields_required".tr
                                  : null,
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              builder: (field) {
                                return Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: [
                                    additionalWorkerSignaturePad(field, index),
                                    const SizedBox(height: 12),
                                    Text(
                                        "tickets_fields_aditionalHelper".tr +
                                            ": " +
                                            "${controller.helpers.firstWhere((element) => controller.aditionalWorkers[index]["workerId"] == element.id).name ?? ""}",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 12,
                                        )),
                                    const SizedBox(height: 12),
                                    if (!field.hasError)
                                      TextButton(
                                        onPressed: () => controller
                                            .handleOnClearAdditionalHelperSignature(
                                                field, index),
                                        child: Text("jsas_create_clear".tr),
                                      )
                                  ],
                                );
                              },
                              name: "additional_helper_signature_${index}");
                        }).toList(),
                      )
                    : const SizedBox.shrink(),
              )
            ],
          ),
        ),
      ),
    );
  }

  //Custom fields
  Widget signaturePad(
    FormFieldState<Object?> field,
    Rx<HandSignatureControl> signatureController,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          height: 300,
          decoration: BoxDecoration(
            border: field.hasError
                ? Border.all(color: Colors.redAccent, width: 2)
                : Border.all(color: Colors.grey, width: 2),
            borderRadius: BorderRadius.circular(24),
          ),
          child: HandSignature(
            control: signatureController.value,
            color: Colors.black,
            type: SignatureDrawType.line,
            width: 2,
            onPointerDown: () => controller.handleOnPointerDown(),
            onPointerUp: () =>
                controller.handleOnPointerUp(field, signatureController),
          ),
        ),
        if (field.hasError)
          Padding(
            padding: const EdgeInsets.only(top: 12.0),
            child: Text(
              textAlign: TextAlign.center,
              field.errorText.toString(),
              style: TextStyle(color: Colors.redAccent),
            ),
          )
      ],
    );
  }

  Widget additionalWorkerSignaturePad(
    FormFieldState<Object?> field,
    int index,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          height: 300,
          decoration: BoxDecoration(
            border: field.hasError
                ? Border.all(color: Colors.redAccent, width: 2)
                : Border.all(color: Colors.grey, width: 2),
            borderRadius: BorderRadius.circular(24),
          ),
          child: HandSignature(
            control: controller.additionalHelpersSignatureControl[index],
            color: Colors.black,
            type: SignatureDrawType.line,
            width: 2,
            onPointerDown: () => controller.handleOnPointerDown(),
            onPointerUp: () =>
                controller.handleOnPointerUpAdditionalHelper(field, index),
          ),
        ),
        if (field.hasError)
          Padding(
            padding: const EdgeInsets.only(top: 12.0),
            child: Text(
              textAlign: TextAlign.center,
              field.errorText.toString(),
              style: TextStyle(color: Colors.redAccent),
            ),
          )
      ],
    );
  }

  List<Column> aditionalHelpersDropdown(CreateJSAController controller) {
    return controller.aditionalWorkers
        .map(
          (e) => Column(
            children: [
              FormBuilderDropdown(
                enabled: false,
                name: "aditional_helper_${e["workerId"]}",
                // initialValue: controller.ticketHelper2Id.value,
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
}
