// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:onax_app/src/controllers/jsasSteperFormController.dart';
import 'package:onax_app/src/utils/sharePrefs/accountPrefs.dart';
import 'package:onax_app/src/utils/styles/themWhite.dart';
import 'package:onax_app/src/views/components/JSas/steperCheckReview.dart';
import 'package:onax_app/src/views/components/JSas/steperControls.dart';
import 'package:onax_app/src/views/components/JSas/steperEnviroment.dart';
import 'package:onax_app/src/views/components/JSas/steperGenerlinfo.dart';
import 'package:onax_app/src/views/components/JSas/steperHazards.dart';
import 'package:onax_app/src/views/components/JSas/steperHazardsTxtArea.dart';
import 'package:onax_app/src/views/components/JSas/steperMusterPoints.dart';
import 'package:onax_app/src/views/components/JSas/steperPermits.dart';
import 'package:onax_app/src/views/components/JSas/steperRecomendedActions.dart';
import 'package:onax_app/src/views/components/JSas/steperRequiredEquipment.dart';
import 'package:onax_app/src/views/components/JSas/steperSinganures.dart';
import 'package:onax_app/src/views/components/JSas/steperTask.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

class JsasFormScreen extends StatelessWidget {
  
  JsasFormScreen({Key? key}) : super(key: key);
  late double h, w;
  @override
  Widget build(BuildContext context) {
    w = MediaQuery.of(context).size.width;
    h = MediaQuery.of(context).size.height;
    final JsasSteperFormController jsasSteperController =
        JsasSteperFormController();
    late Widget widget;
    AccountPrefs.currentShift > 0
        ? widget = Scaffold(
            appBar: AppBar(
                leading: IconButton(
              icon: Icon(Icons.arrow_back_ios),
              onPressed: () {
                Get.back();
                // Get.offNamed('/pages');
              },
            )),
            backgroundColor: Colors.white, //Colors.grey[200],
            body: GetBuilder<JsasSteperFormController>(
              init: jsasSteperController,
              builder: (_) => SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: _content(_, context),
                physics: _.moveScroll == false
                    ? const NeverScrollableScrollPhysics()
                    : const ScrollPhysics(),
              ),
            ),
          )
        : widget = Scaffold(
            backgroundColor: Colors.white, //Colors.grey[200],
            body: SizedBox(
              width: w,
              height: h,
              child: const Center(
                child: Text(
                    'To create JSAs you need to have current shift active.'),
              ),
            ),
          );
    return widget;
  }

  ///
  ///
  _content(JsasSteperFormController _, BuildContext context) {
    return SizedBox(
      width: w,
      height: h * 2.05,
      // color: Colors.red,
      child: Column(
        children: [
          SizedBox(height: h * 0.01),
          SizedBox(
            width: w * 0.8,
            //height: h * 0.05,
            // color: Colors.red,
            child: Text(
              'new_jsas'.tr,
              style: ThemeWhite().titleBar(Colors.black),
              textAlign: TextAlign.center,
            ),
          ),
          Stepper(
            type: StepperType.vertical,
            physics: const NeverScrollableScrollPhysics(),
            currentStep: _.currentSteperIndex,
            controlsBuilder: (context, details) {
              //return const SizedBox(height: 0); remove the defaultbtn
              if (_.currentSteperIndex == getSteps(_).length - 1) {
                return Row(
                  children: <Widget>[
                    RoundedLoadingButton(
                      width: w * 0.3,
                      color: Colors.blue,
                      controller: _.btnSave,
                      onPressed: () async {
                        AccountPrefs.statusConnection == true
                            ? await _.saveJSAs()
                            : await _.saveJSAsNotWIFI();
                        _.btnSave.reset();
                        // await controller.updateFinishedTimeTicket();
                      },
                      borderRadius: 15,
                      child: Text(
                        'utils_save'.tr,
                        style: ThemeWhite().labelBtnActions(Colors.white),
                      ),
                    ),
                  ],
                );
              } else {
                return Row(
                  children: <Widget>[
                    Container(
                      width: w * 0.3,
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: PhysicalModel(
                        elevation: 5,
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(10),
                        child: TextButton(
                          onPressed: details.onStepContinue,
                          child: Text(
                            'utils_next'.tr,
                            style: ThemeWhite().labelBtnActions(Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              }
            },
            onStepContinue: () {
              bool isLastStep =
                  (_.currentSteperIndex == getSteps(_).length - 1);
              if (isLastStep) {
                //doSomething like store the JSAs change the btn
              } else {
                _.steperCompleted(_.currentSteperIndex + 1);
              }
            },
            onStepTapped: (step) {
              _.steperTapByonlyBack(step);
            },
            steps: getSteps(_),
            //'
          ),
        ],
      ),
    );
  }

  getSteps(JsasSteperFormController _) {
    return [
      Step(
        isActive: _.currentSteperIndex >= 0, //   //||
        //_.currentTicket?.deparmentTimesTimep != '',

        state: _.currentSteperIndex >= 0 && _.counterNextTimes > 0
            //&& _.currentTicket?.deparmentTimesTimep != ''
            ? StepState.complete
            : StepState.indexed,
        title: Text('new_jsas_generalinfo'.tr),
        content: GeneralInfoSteper(
          controller: _,
        ),
      ),
      Step(
        isActive: _.currentSteperIndex >= 1,
        state: _.currentSteperIndex >= 1 && _.counterNextTimes > 1 //change
            ? StepState.complete
            : StepState.indexed,
        title: Text('new_jsas_safetyequip'.tr),
        content: RequiredSafeEquipSteper(controller: _),
      ),
      Step(
        isActive: _.currentSteperIndex >= 2,
        state: _.currentSteperIndex >= 2 && _.counterNextTimes > 2 //change
            ? StepState.complete
            : StepState.indexed,
        title: Text('new_jsas_hazards'.tr),
        content: HazardsSteper(controller: _),
      ),
      Step(
        isActive: _.currentSteperIndex >= 3,
        state: _.currentSteperIndex >= 3 && _.counterNextTimes > 3 //change
            ? StepState.complete
            : StepState.indexed,
        title: Text('new_jsas_permits'.tr),
        content: PermitsSteper(controller: _),
      ),
      Step(
        isActive: _.currentSteperIndex >= 4,
        state: _.currentSteperIndex >= 4 && _.counterNextTimes > 4 //change
            ? StepState.complete
            : StepState.indexed,
        title: Text('new_jsas_check'.tr), //EnviromentConcernsSteper
        content: CheckReviewSteper(controller: _),
      ),
      Step(
        isActive: _.currentSteperIndex >= 5,
        state: _.currentSteperIndex >= 5 && _.counterNextTimes > 5 //change
            ? StepState.complete
            : StepState.indexed,
        title: Text('new_jsas_environment'.tr), //EnviromentConcernsSteper
        content: EnviromentConcernsSteper(controller: _),
      ),
      Step(
        isActive: _.currentSteperIndex >= 6,
        state: _.currentSteperIndex >= 6 && _.counterNextTimes > 6 //change
            ? StepState.complete
            : StepState.indexed,
        title: Text('new_jsas_task'.tr), //EnviromentConcernsSteper
        content: TaskSteper(controller: _),
      ),
      Step(
        isActive: _.currentSteperIndex >= 7,
        state: _.currentSteperIndex >= 7 && _.counterNextTimes > 7 //change
            ? StepState.complete
            : StepState.indexed,
        title: Text('new_jsas_hazards'.tr), //EnviromentConcernsSteper
        content: HazardsTxtAreaSteper(controller: _),
      ),
      Step(
        isActive: _.currentSteperIndex >= 8,
        state: _.currentSteperIndex >= 8 && _.counterNextTimes > 8 //change
            ? StepState.complete
            : StepState.indexed,
        title: Text('new_jsas_controls'.tr), //EnviromentConcernsSteper
        content: ControlsSteper(controller: _),
      ),
      Step(
        isActive: _.currentSteperIndex >= 9,
        state: _.currentSteperIndex >= 9 && _.counterNextTimes > 9 //change
            ? StepState.complete
            : StepState.indexed,
        title: Text('new_jsas_recomended'.tr), //EnviromentConcernsSteper
        content: RecomendedActionsSteper(controller: _),
      ),
      Step(
        isActive: _.currentSteperIndex >= 10,
        state: _.currentSteperIndex >= 10 && _.counterNextTimes > 10 //change
            ? StepState.complete
            : StepState.indexed,
        title: Text('new_jsas_muster'.tr), //EnviromentConcernsSteper
        content: MusterPointsSteper(controller: _),
      ),
      Step(
        isActive: _.currentSteperIndex >= 11,
        state: _.currentSteperIndex >= 11 && _.counterNextTimes > 11 //change
            ? StepState.complete
            : StepState.indexed,
        title: Text('new_jsas_signatures'.tr), //EnviromentConcernsSteper
        content: SignaturesSteper(controller: _),
      ),
    ];
  }
}
