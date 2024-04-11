import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:onax_app/src/controllers/jsasSteperFormController.dart';
import 'package:onax_app/src/utils/styles/inputStyles.dart';
import 'package:onax_app/src/utils/styles/themWhite.dart';

class CheckReviewSteper extends StatelessWidget {
  final JsasSteperFormController controller;
  CheckReviewSteper({Key? key, required this.controller}) : super(key: key);
  late double h, w;
  @override
  Widget build(BuildContext context) {
    w = MediaQuery.of(context).size.width;
    h = MediaQuery.of(context).size.height;
    return SizedBox(
      width: w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: h * 0.01),
          //check Steel Toed Shoes & Hard Hat
          SizedBox(
            //color: Colors.red,
            width: w,
            child: Row(
              children: [
                _lockOutTagOut(),
                _ladder(),
              ],
            ),
          ),
          //Safety Glass & H2S Monitor
          SizedBox(
            //color: Colors.red,
            width: w,
            child: Row(
              children: [
                _fireExinger(),
                _permits(),
              ],
            ),
          ),
          //FRClotigh & Fall Protection
          SizedBox(
            //color: Colors.red,
            width: w,
            child: Row(
              children: [
                _inspectionEquipment(),
              ],
            ),
          ),
          //Hearing protec & Respirator
          SizedBox(
            //color: Colors.red,
            width: w,
            child: Row(
              children: [
                _msdsReview(),
              ],
            ),
          ),
          //Other
          SizedBox(
            width: w,
            child: Row(children: [
              Checkbox(
                value: controller.otherCheckReview,
                onChanged: (value) {
                  controller.updateCheck(value!, 'otherCheckReview');
                },
                checkColor: Colors.white,
                activeColor: Colors.black,
              ),
              Container(
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(10)),
                height: h * 0.055,
                width: w * 0.65,
                child: PhysicalModel(
                  color: Colors.white,
                  elevation: 2,
                  borderRadius: BorderRadius.circular(10),
                  child: TextFormField(
                    controller: controller.otherCheckReviewText,
                    style: ThemeWhite().labelHomeTitles(Colors.black),
                    onChanged: (value) {
                      if (controller.otherCheckReviewText.text.isEmpty) {
                        FocusManager.instance.primaryFocus?.unfocus();
                      }
                    },
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(255),
                    ],
                    keyboardType: TextInputType.text,
                    autofocus: false,
                    decoration:
                        StyleInput().inputTextSyle('utils_other'.tr, Colors.white),
                  ),
                ),
              ),
            ]),
          ),

          //
          SizedBox(height: h * 0.01),
        ],
      ),
    );
  }

  _lockOutTagOut() {
    return SizedBox(
      width: w * 0.42,
      child: Row(children: [
        Checkbox(
          value: controller.lockOutTagOut,
          onChanged: (value) {
            controller.updateCheck(value!, 'lockOutTagOut');
          },
          checkColor: Colors.white,
          activeColor: Colors.black,
        ),
        Text('new_jsas_check_lockout'.tr,
            style: ThemeWhite().labelCheckbox(Colors.black)),
      ]),
    );
  }

  _ladder() {
    return SizedBox(
      width: w * 0.32,
      child: Row(children: [
        Checkbox(
          value: controller.ladder,
          onChanged: (value) {
            controller.updateCheck(value!, 'ladder');
          },
          checkColor: Colors.white,
          activeColor: Colors.black,
        ),
        Text('new_jsas_check_ladder'.tr, style: ThemeWhite().labelCheckbox(Colors.black)),
      ]),
    );
  }

  _fireExinger() {
    return SizedBox(
      width: w * 0.42,
      child: Row(children: [
        Checkbox(
          value: controller.fireExtinguisher,
          onChanged: (value) {
            controller.updateCheck(value!, 'fireExtinguisher');
          },
          checkColor: Colors.white,
          activeColor: Colors.black,
        ),
        Text('new_jsas_check_fire'.tr,
            style: ThemeWhite().labelCheckbox(Colors.black)),
      ]),
    );
  }

  _permits() {
    return SizedBox(
      width: w * 0.33,
      child: Row(children: [
        Checkbox(
          value: controller.permmits,
          onChanged: (value) {
            controller.updateCheck(value!, 'permmits');
          },
          checkColor: Colors.white,
          activeColor: Colors.black,
        ),
        Text('new_jsas_check_permits'.tr, style: ThemeWhite().labelCheckbox(Colors.black)),
      ]),
    );
  }

  _inspectionEquipment() {
    return SizedBox(
      width: w * 0.7,
      child: Row(children: [
        Checkbox(
          value: controller.inspectionEquipment,
          onChanged: (value) {
            controller.updateCheck(value!, 'inspectionEquipment');
          },
          checkColor: Colors.white,
          activeColor: Colors.black,
        ),
        Text('new_jsas_check_inspection'.tr,
            style: ThemeWhite().labelCheckbox(Colors.black)),
      ]),
    );
  }

  _msdsReview() {
    return SizedBox(
      width: w * 0.4,
      child: Row(children: [
        Checkbox(
          value: controller.msdsReview,
          onChanged: (value) {
            controller.updateCheck(value!, 'msdsReview');
          },
          checkColor: Colors.white,
          activeColor: Colors.black,
        ),
        Text('new_jsas_check_msds'.tr, style: ThemeWhite().labelCheckbox(Colors.black)),
      ]),
    );
  }
}
