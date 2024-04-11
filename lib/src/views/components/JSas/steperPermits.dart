import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:onax_app/src/controllers/jsasSteperFormController.dart';
import 'package:onax_app/src/utils/styles/inputStyles.dart';
import 'package:onax_app/src/utils/styles/themWhite.dart';

class PermitsSteper extends StatelessWidget {
  final JsasSteperFormController controller;
  PermitsSteper({Key? key, required this.controller}) : super(key: key);
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
          //check Steel Toed Shoes & Hard Hat
          SizedBox(
            //color: Colors.red,
            width: w,

            child: _confineSpace(),
          ),
          SizedBox(
            //color: Colors.red,
            width: w,
            child: Row(
              children: [
                _hotWorkPermit(),
              ],
            ),
          ),
          //Safety Glass & H2S Monitor
          SizedBox(
            //color: Colors.red,
            width: w,
            child: Row(
              children: [
                _excavationTren(),
              ],
            ),
          ),

          //Other
          SizedBox(
            width: w,
            child: Row(children: [
              Checkbox(
                value: controller.otherPermitRequiredCall,
                onChanged: (value) {
                  controller.updateCheck(value!, 'otherPermitRequiredCall');
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
                    controller: controller.otherPermitRequiredCallText,
                    style: ThemeWhite().labelHomeTitles(Colors.black),
                    onChanged: (value) {
                      if (controller.otherPermitRequiredCallText.text.isEmpty) {
                        FocusManager.instance.primaryFocus?.unfocus();
                      }
                    },
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(255),
                    ],
                    keyboardType: TextInputType.text,
                    autofocus: false,
                    decoration:
                        StyleInput().inputTextSyle('new_jsas_permits_onecall'.tr, Colors.white),
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

  _confineSpace() {
    return SizedBox(
      width: w * 0.7,
      child: Row(children: [
        Checkbox(
          value: controller.confinedSpacePermit,
          onChanged: (value) {
            controller.updateCheck(value!, 'confinedSpacePermit');
          },
          checkColor: Colors.white,
          activeColor: Colors.black,
        ),
        Text('new_jsas_permits_confined'.tr,
            style: ThemeWhite().labelCheckbox(Colors.black)),
      ]),
    );
  }

  _hotWorkPermit() {
    return SizedBox(
      width: w * 0.7,
      child: Row(children: [
        Checkbox(
          value: controller.hotWorkPermit,
          onChanged: (value) {
            controller.updateCheck(value!, 'hotWorkPermit');
          },
          checkColor: Colors.white,
          activeColor: Colors.black,
        ),
        Text('new_jsas_permits_hot'.tr,
            style: ThemeWhite().labelCheckbox(Colors.black)),
      ]),
    );
  }

  _excavationTren() {
    return SizedBox(
      width: w * 0.7,
      child: Row(children: [
        Checkbox(
          value: controller.excavationTrenching,
          onChanged: (value) {
            controller.updateCheck(value!, 'excavationTrenching');
          },
          checkColor: Colors.white,
          activeColor: Colors.black,
        ),
        Text('new_jsas_permits_excavation'.tr,
            style: ThemeWhite().labelCheckbox(Colors.black)),
      ]),
    );
  }
}
