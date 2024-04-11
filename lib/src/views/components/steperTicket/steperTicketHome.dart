// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:onax_app/src/controllers/ticketSteperController.dart';
import 'package:onax_app/src/utils/sharePrefs/accountPrefs.dart';
import 'package:onax_app/src/views/components/steperTicket/ticketSteper_arrived.dart';
import 'package:onax_app/src/views/components/steperTicket/ticketSteper_depart.dart';
import 'package:onax_app/src/views/components/steperTicket/ticketSteper_finish.dart';

import 'package:onax_app/src/views/pages_screen.dart';

import '../../../utils/styles/themWhite.dart';
import 'headerTicketSteper.dart';

class SteperTicketHome extends StatelessWidget {
  SteperTicketHome({Key? key}) : super(key: key);
  late double h, w;

  @override
  Widget build(BuildContext context) {
    w = MediaQuery.of(context).size.width;
    h = MediaQuery.of(context).size.height;
    final TicketSteperController ticketStperController =
        TicketSteperController();
    return WillPopScope(
        onWillPop: () async {
          //return to pageController
          Get.off(
            () => PagesScreen(),
            arguments: {'page': 0},
            transition: Transition.downToUp,
            duration: const Duration(milliseconds: 250),
          );
          return true;
        },
        child: Scaffold(
          appBar: AppBar(
            leading: IconButton(
                onPressed: () {
                  Get.offNamed('/pages');
                },
                icon: Icon(Icons.arrow_back_ios)),
          ),
          body: GetBuilder<TicketSteperController>(
              init: ticketStperController,
              builder: (_) => _.loadTicketForm == false
                  ? Container(
                      width: w,
                      height: h,
                      child: SingleChildScrollView(
                          scrollDirection: Axis.vertical,
                          child: _content(_, context)),
                    )
                  : const Center(
                      child: CircularProgressIndicator(),
                    )),
        ));
  }

  _content(TicketSteperController _, BuildContext context) {
    return SingleChildScrollView(
      // width: w,
      // height: h * 1,
      // color: Colors.red,
      child: Column(
        children: [
          _header(_),
          Stepper(
            type: StepperType.vertical,
            physics: const NeverScrollableScrollPhysics(),
            currentStep: _.currentSteperIndex,
            controlsBuilder: (context, details) {
              return const SizedBox(height: 0);
            },
            onStepContinue: () {
              bool isLastStep =
                  (_.currentSteperIndex == getSteps(_).length - 1);
              if (isLastStep && _.finishedTimestamp != '') {
                if (AccountPrefs.hasOpenTicke == _.ticketId) {}
              }
            },
            onStepTapped: (step) {
              _.steperCompleted(step);
            },
            steps: getSteps(_),
            //'
          ),
        ],
      ),
    );
  }

  _header(TicketSteperController _) {
    return Container(
      width: w,
      height: h * 0.19,
      margin: EdgeInsets.symmetric(horizontal: w * 0.05),
      color: Colors.white,
      child: Stack(
        children: [
          Positioned(
            child: HeaderTicketSteper(
              controller: _,
            ),
          ),
        ],
      ),
    );
  }

  getSteps(TicketSteperController _) {
    return [
      Step(
        isActive: _.currentSteperIndex >= 0 ||
            _.currentTicket?.deparmentTimesTimep != '',
        state: _.currentSteperIndex >= 0 &&
                _.currentTicket?.deparmentTimesTimep != ''
            ? StepState.complete
            : StepState.indexed,
        title: Text('ticket_steps_depart'.tr),
        content: TicketSteperDepart(
          controller: _,
        ),
      ),
      Step(
        isActive: _.currentSteperIndex >= 1 ||
            _.currentTicket?.arrivedTimesTimep != '',
        state: _.currentSteperIndex >= 1 &&
                _.currentTicket?.arrivedTimesTimep != ''
            ? StepState.complete
            : StepState.indexed,
        title: Text('ticket_steps_arrive'.tr),
        content: TicketSteperArrived(controller: _),
      ),
      Step(
        isActive: _.currentSteperIndex >= 2 ||
            _.currentTicket?.finishedTimesTimep != '',
        state: _.currentSteperIndex >= 2 &&
                _.currentTicket?.finishedTimesTimep != ''
            ? StepState.complete
            : StepState.indexed,
        title: Text('ticket_steps_finished'.tr),
        content: TicketSteperFinished(controller: _),
      ),
    ];
  }
}
