import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

import 'package:get/get.dart';
import 'package:onax_app/app/modules/ticket/controllers/update_ticket_controller.dart';
import 'package:onax_app/app/modules/ticket/widgets/step_two.dart';
import 'package:onax_app/app/modules/ticket/widgets/step_four.dart';
import 'package:onax_app/app/modules/ticket/widgets/step_three.dart';
import 'package:onax_app/app/modules/ticket/widgets/step_one.dart';
import 'package:onax_app/app/routes/app_pages.dart';

class UpdateTicketView extends GetView<UpdateTicketController> {
  UpdateTicketView({Key? key}) : super(key: key);

  final UpdateTicketController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) {
        Get.offAllNamed(Routes.TABS);
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('tickets_title'.tr),
          centerTitle: true,
        ),
        body: SafeArea(
          child: Container(
            height: double.maxFinite,
            child: _stepperList(),
          ),
        ),
      ),
    );
  }

  Obx _stepperList() {
    return Obx(() => FormBuilder(
          key: controller.updateTicketFormBuilderKey.value,
          child: Stepper(
            currentStep: controller.currentStepIndex.value,
            onStepTapped: ((int tappedStep) =>
                controller.handleOnStepTapped(tappedStep)),
            // onStepContinue: () => controller
            //     .handleOnStepContinue(controller.currentStepIndex.value),
            onStepCancel: () => controller.handleOnStepCancel(),
            connectorThickness: 2,
            controlsBuilder: (context, details) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // TextButton(
                  //   onPressed: details.onStepCancel,
                  //   child: Text("back"),
                  // ),
                  // SizedBox(width: 16),
                  // FilledButton(
                  //   onPressed: details.onStepContinue,
                  //   child: Text("continue"),
                  // ),
                ],
              );
            },
            steps: controller.stepsFormKeys
                .asMap()
                .entries
                .map(
                  (mapEntry) => getStepperBody(mapEntry.key, mapEntry.value),
                )
                .toList(),
          ),
        ));
  }

  Step getStepperBody(int stepIndex, GlobalKey<FormBuilderState> formKey) {
    switch (stepIndex) {
      case 0:
        return stepOne(stepIndex, formKey);
      case 1:
        return stepTwo(stepIndex, formKey);
      case 2:
        return stepThree(stepIndex, formKey);
      case 3:
        return stepFour(stepIndex, formKey);
      default:
        return Step(
            title: Text("tickets_create_steps_step${stepIndex + 1}".tr),
            content: Text("Not implemented yet"));
    }
  }
}
