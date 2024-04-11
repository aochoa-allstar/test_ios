import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import 'package:hand_signature/signature.dart';

import 'package:onax_app/app/modules/inspection/controllers/create_inspection_controller.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

class CreateInspectionView extends GetView<CreateInspectionController> {
  CreateInspectionView({Key? key}) : super(key: key);

  final CreateInspectionController controller = Get.put(CreateInspectionController());
  late double h, w;

  @override
  Widget build(BuildContext context) {
    w = MediaQuery.of(context).size.width;
    h = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text('inspections_newInspection'.tr),
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
      // case 2:
      //   return _step2Body(stepIndex, formKey);
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
      title: Text("inspections_steps_step${stepIndex + 1}".tr),
      content: Container(
        padding: EdgeInsets.symmetric(vertical: 12),
        child: FormBuilder(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FormBuilderDropdown(
                  name: "location",
                  validator: (value) =>
                      value == null ? "shift_fields_required".tr : null,
                  icon: controller.locations.isEmpty
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
                      controller.handleSelectedLocationChange(value),
                  valueTransformer: (value) => int.parse(value.toString()),
                  decoration: InputDecoration(
                    labelText: "inspections_fields_location".tr,
                    hintText: "inspections_fields_location".tr,
                    contentPadding: EdgeInsets.all(16),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  items: controller.locations
                      .map((location) => DropdownMenuItem(
                            child: Text(location.name),
                            value: location.id,
                          ))
                      .toList(),
                ),
                const SizedBox(height: 16),
                FormBuilderTextField(
                  name: "name",
                  validator: (value) => value == null ? "shift_fields_required".tr : null,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  decoration: InputDecoration(
                    labelText: "inspections_fields_odometerReading".tr,
                    hintText: "inspections_fields_odometerReading".tr,
                    contentPadding: EdgeInsets.all(16),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                FormBuilderDropdown(
                  name: "equipment_id",
                  // onChanged: (value) => controller.handleDropDownListChange(value),
                  icon: controller.trucks.isEmpty
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
                    labelText: "inspections_fields_truck".tr,
                    hintText: "inspections_fields_truck".tr,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(24),
                    ),
                  ),
                  items: controller.trucks
                      .map((equipment) => DropdownMenuItem(
                            child:
                                Text(equipment.number ?? "tickets_fields_noModel".tr),
                            value: equipment.id,
                          ))
                      .toList(),
                ),
                const SizedBox(height: 16),
              ],
            )),
      ),
    );
  }

Step _step2Body(int stepIndex, GlobalKey<FormBuilderState> formKey) {
  return Step(
    isActive: controller.currentStepIndex >= 1,
    title: Text("inspections_steps_step${stepIndex + 1}".tr),
    content: Container(
      padding: EdgeInsets.symmetric(vertical: 12),
      child: FormBuilder(
        key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Flexible(
                  // flex: 1,
                  child: Text(
                    "Prt"
                  ),
                ),
                Flexible(
                  // flex: 1,
                  child: Text(
                    "Pot"
                  ),
                ),
                Flexible(
                  // flex: 1,
                  child: Text(
                    "RR"
                  ),
                ),
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [ // Agregar un espacio entre el texto y el primer checkbox
                Flexible(
                  flex: 1,
                  child: FormBuilderCheckbox(
                    name: 'option1',
                    title: Text(''),
                    onChanged: (value) {
                      if (controller.prePost == 1) {
                        controller.checkboxes('ptrAirCompressor', value!);
                      }
                    },
                  ),
                ),
                Flexible(
                  flex: 1,
                  child: FormBuilderCheckbox(
                    name: 'option2',
                    title: Text(''),
                    onChanged: (value) {
                      if (controller.prePost == 2) {
                        controller.checkboxes('potAirCompressor', value!);
                      }
                    },
                  ),
                ),
                Flexible(
                  flex: 1,
                  child: FormBuilderCheckbox(
                    name: 'option3',
                    title: Text(''),
                    onChanged: (value) {
                      controller.checkboxes('rrAirCompressor', value!);
                    },
                  ),
                ),
                Flexible(
                  child: Text(
                    "inspections_fields_airCompressor".tr,
                    maxLines: null, 
                  ),
                ),
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [ // Agregar un espacio entre el texto y el primer checkbox
                Flexible(
                  flex: 1,
                  child: FormBuilderCheckbox(
                    name: 'option1',
                    title: Text(''),
                    onChanged: (value) {

                    },
                  ),
                ),
                Flexible(
                  flex: 1,
                  child: FormBuilderCheckbox(
                    name: 'option2',
                    title: Text(''),
                    onChanged: (value) {
                      
                    },
                  ),
                ),
                Flexible(
                  flex: 1,
                  child: FormBuilderCheckbox(
                    name: 'option3',
                    title: Text(''),
                    onChanged: (value) {
                      
                    },
                  ),
                ),
                Flexible(
                  child: Text(
                    "inspections_fields_airLines".tr,
                    maxLines: null, 
                  ),
                ),
              ],
            ),
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
}
