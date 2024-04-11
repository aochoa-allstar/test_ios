// ignore_for_file: must_be_immutable, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:onax_app/src/controllers/homeController.dart';
import 'package:onax_app/src/utils/sharePrefs/accountPrefs.dart';
import 'package:onax_app/src/utils/styles/themWhite.dart';
import 'package:get/get.dart';

class CardInfoShift extends StatelessWidget {
  final HomeController controller;
  CardInfoShift({Key? key, required this.controller}) : super(key: key);
  late double h, w;
  late SnackBar snackBar;
  @override
  Widget build(BuildContext context) {
    w = MediaQuery.of(context).size.width;
    h = MediaQuery.of(context).size.height;
    snackBar = SnackBar(
      content: Text('home_shift_warning'.tr),
      duration: Duration(seconds: 3),
    );
    return Container(
      width: w,
      height: h * 0.18,
      color: Colors.white,
      margin: EdgeInsets.symmetric(horizontal: w * 0.07, vertical: h * 0.01),
      child: _cardInfoUser(context),
    );
  }

  _cardInfoUser(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        //

        if (controller.statusShiftTicket != 0) {
          if (AccountPrefs.hasOpenTicke > 0) {
            controller.moveToSeeTheCurrentTicket();
          } else {
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          }
        } else {
          controller.moveToStartShift();
        } //&&
      },
      child: PhysicalModel(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        elevation: 5,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            /* border: Border.all(
              color: Colors.grey,
              style: BorderStyle.solid,
              width: 1,
            ),*/
          ),
          child: controller.statusShiftTicket == 1 ? _dataInfo() : _dataInfo(),
        ),
      ),
    );
  }

  _dataInfo() {
    return Row(
      children: [
        //data
        Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: h * 0.02,
              ),
              Container(
                margin: EdgeInsets.only(left: w * 0.03),
                child: Text(
                  AccountPrefs.name,
                  style: ThemeWhite().labelNameCardsWorker(Colors.black),
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: w * 0.03),
                child: Text(
                  'Onax LLC',
                  style: ThemeWhite().labelCompanyCardsWorker(Colors.black54),
                ),
              ),
              SizedBox(
                height: h * 0.01,
              ),
              Container(
                  width: w * 0.25,
                  height: h * 0.025,
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(7),
                  ),
                  margin: EdgeInsets.only(left: w * 0.03),
                  child: Row(
                    children: [
                      SizedBox(
                        width: w * 0.01,
                      ),
                      _circleActive(),
                      Container(
                        margin: EdgeInsets.only(left: w * 0.01),
                        child: Text(
                          AccountPrefs.currentShift > 0
                              ? 'home_shift_active'.tr
                              : 'home_shift_start_shift'.tr,
                          style: ThemeWhite().labelStatusShift(
                            Colors.black,
                          ),
                        ),
                      ),
                    ],
                  )),
            ],
          ),
        ),
        const Spacer(
          flex: 7,
        ),
        Container(
          width: w * 0.12,
          height: h,
          child: const Icon(Icons.arrow_forward_ios),
        ),
        /*Expanded(
          child: Container(
            width: w,
            height: h * 0.04,
            margin: EdgeInsets.only(left: w * 0.03),
            decoration: BoxDecoration(
                //color: Colors.red,
                ),
            child: Text(
              'Josue Aguilera',
              style: ThemeWhite().labelNameCardsWorker(Colors.black54),
            ),
          ),
        ),*/

        Spacer(),
      ],
    );
  }

  _dataNewShift() {}

  _circleActive() {
    late Widget widget;

    switch (1) {
      case 1:
        widget = Container(
          width: 8,
          height: 8,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
            color:
                AccountPrefs.currentShift > 0 && AccountPrefs.hasOpenTicke > 0
                    ? Colors.yellow[600]
                    : Colors.black45,
          ),
        );
        break;
      default:
    }
    return widget;
  }
}
