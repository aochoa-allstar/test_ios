import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:onax_app/src/utils/sharePrefs/accountPrefs.dart';
import 'package:onax_app/src/utils/styles/themWhite.dart';

import 'inspectionScreen.dart';

class FourthScreen extends StatelessWidget {
  FourthScreen({Key? key}) : super(key: key);
  late Widget widget;
  late double h, w;
  @override
  Widget build(BuildContext context) {
    h = MediaQuery.of(context).size.height;
    w = MediaQuery.of(context).size.width;
    AccountPrefs.currentShift > 0
        ? widget = Scaffold(
            backgroundColor: Colors.white, //Colors.grey[200],
            body: SizedBox(
              width: w,
              height: h,
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  //content
                  SizedBox(height: h * 0.04),
                  SizedBox(
                    width: w * 0.8,
                    child: Text(
                      'new_inspection_msg'.tr,
                      style: ThemeWhite().dateTicket(Colors.black),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(height: h * 0.02),
                  _makeAPreTrip(),
                  SizedBox(height: h * 0.02),
                  _makeAPostTrip()
                ],
              ),
            ),
          )
        : widget = Scaffold(
            backgroundColor: Colors.white, //Colors.grey[200],
            body: SizedBox(
              width: w,
              height: h,
              child: const Center(
                child: Padding(
                  padding: EdgeInsets.all(20.0),
                  child: Text(
                      'To Pre or Post a Trip Inspection you need to have a current shift active.'),
                ),
              ),
            ),
          );
    return widget;
  }

  _makeAPreTrip() {
    return Container(
      width: w * 0.3,
      decoration: BoxDecoration(
        color: Colors.blue,
        borderRadius: BorderRadius.circular(10),
      ),
      child: PhysicalModel(
        elevation: 5,
        color: Colors.blue,
        borderRadius: BorderRadius.circular(10),
        child: TextButton(
          onPressed: () async {
            // await controller.login();
            return Get.off(
              () => ThirdScreen(),
              arguments: {"flag": 1},
              transition: Transition.upToDown,
              duration: const Duration(milliseconds: 250),
            );
          },
          child: Text(
            'new_inspection_pretrip'.tr,
            style: ThemeWhite().labelBtnActions(Colors.white),
          ),
        ),
      ),
    );
  }

  _makeAPostTrip() {
    return Container(
      width: w * 0.3,
      decoration: BoxDecoration(
        color: Colors.orange,
        borderRadius: BorderRadius.circular(10),
      ),
      child: PhysicalModel(
        elevation: 5,
        color: Colors.orange,
        borderRadius: BorderRadius.circular(10),
        child: TextButton(
          onPressed: () async {
            // await controller.login();
            return Get.off(
              () => ThirdScreen(),
              arguments: {"flag": 2},
              transition: Transition.upToDown,
              duration: const Duration(milliseconds: 250),
            );
          },
          child: Text(
            'new_inspection_posttrip'.tr,
            style: ThemeWhite().labelBtnActions(Colors.white),
          ),
        ),
      ),
    );
  }
}
