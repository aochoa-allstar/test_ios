// ignore_for_file: prefer_const_constructors_in_immutables, must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:onax_app/src/controllers/inspectionsController.dart';
import 'package:onax_app/src/utils/sharePrefs/accountPrefs.dart';
import 'package:onax_app/src/utils/styles/themWhite.dart';
import 'package:onax_app/src/views/components/Inspection/steperGeneralInfo.dart';
import 'package:onax_app/src/views/components/Inspection/steperPosPrTrip.dart';
import 'package:onax_app/src/views/components/Inspection/steperRemarks.dart';
import 'package:onax_app/src/views/components/Inspection/steperSignature.dart';
import 'package:onax_app/src/views/components/Inspection/steperTrailers.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

import 'pages_screen.dart';
//import 'package:flutter/cupertino.dart';

class ThirdScreen extends StatelessWidget {
  ThirdScreen({Key? key}) : super(key: key);
  late double h, w;
  @override
  Widget build(BuildContext context) {
    h = MediaQuery.of(context).size.height;
    w = MediaQuery.of(context).size.width;
    final InspectionController inspectionsController = InspectionController();

    return WillPopScope(
      onWillPop: () async {
        Get.off(
          () => PagesScreen(),
          arguments: {'page': 0},
          transition: Transition.rightToLeft,
          duration: const Duration(milliseconds: 250),
        );
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            'new_inspection_pretrip_title'.tr,
            style: ThemeWhite().dateTicket(Colors.white),
          ),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Get.off(
                () => PagesScreen(),
                transition: Transition.rightToLeft,
                duration: const Duration(milliseconds: 250),
              );
            },
          ),
        ),
        backgroundColor: Colors.white, //Colors.grey[200],
        body: GetBuilder<InspectionController>(
          init: inspectionsController,
          builder: (_) => SingleChildScrollView(
            controller: _.scrollController,
            scrollDirection: Axis.vertical,
            child: _content(_, context),
            physics: _.moveScroll == false
                ? const NeverScrollableScrollPhysics()
                : const ScrollPhysics(),
          ),
        ),
      ),
    );
  }

  ///
  ///
  _content(InspectionController _, BuildContext context) {
    return SizedBox(
      width: w,
      height: h * 3,
      // color: Colors.red,
      child: Column(
        children: [
          SizedBox(height: h * 0.01),
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
                        // await _.saveJSAs();
                        AccountPrefs.statusConnection == true
                            ? await _.saveInspection()
                            : await _.saveInspectionNotWifi();
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
                if (_.currentSteperIndex == 2 || _.currentSteperIndex == 3) {
                  _.scrollController.animateTo(0,
                      duration: const Duration(seconds: 1),
                      curve: Curves.linear);
                }
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

  getSteps(InspectionController _) {
    return [
      Step(
        isActive: _.currentSteperIndex >= 0,
        state: _.currentSteperIndex >= 0 && _.counterNextTimes > 0 //change
            ? StepState.complete
            : StepState.indexed,
        title: Text('new_jsas_generalinfo'.tr),
        content: GeneralInfoInspectionSteper(
          controller: _,
        ),
      ),
      Step(
        isActive: _.currentSteperIndex >= 1,
        state: _.currentSteperIndex >= 1 && _.counterNextTimes > 1 //change
            ? StepState.complete
            : StepState.indexed,
        title: Text('new_inspection_pretrip_check'.tr),
        content: PosPrTripSteper(
          controller: _,
        ),
      ),
      Step(
        isActive: _.currentSteperIndex >= 2,
        state: _.currentSteperIndex >= 2 && _.counterNextTimes > 2 //change
            ? StepState.complete
            : StepState.indexed,
        title: Text('new_inspection_pretrip_trailers'.tr),
        content: TrailersSteper(
          controller: _,
        ),
      ),
      Step(
        isActive: _.currentSteperIndex >= 3,
        state: _.currentSteperIndex >= 3 && _.counterNextTimes > 3 //change
            ? StepState.complete
            : StepState.indexed,
        title: Text('new_inspection_pretrip_remarks'.tr), //EnviromentConcernsSteper
        content: RemarksStper(
          controller: _,
        ),
      ),
      Step(
        isActive: _.currentSteperIndex >= 4,
        state: _.currentSteperIndex >= 4 && _.counterNextTimes > 4 //change
            ? StepState.complete
            : StepState.indexed,
        title: Text('new_inspection_pretrip_signature'.tr), //EnviromentConcernsSteper
        content: SignatureSteperInspection(
          controller: _,
        ),
      ),
    ];
  }
}
