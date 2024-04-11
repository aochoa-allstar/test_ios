import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:hand_signature/signature.dart';
import 'package:onax_app/src/controllers/inspectionsController.dart';

import 'package:onax_app/src/utils/styles/inputStyles.dart';
import 'package:onax_app/src/utils/styles/themWhite.dart';

class RemarksStper extends StatelessWidget {
  final InspectionController controller;
  RemarksStper({Key? key, required this.controller}) : super(key: key);
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
          Container(
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
            height: h * 0.2,
            width: w * 0.7,
            child: PhysicalModel(
              color: Colors.white,
              elevation: 2,
              borderRadius: BorderRadius.circular(10),
              child: TextFormField(
                maxLines: null,
                controller: controller.remarksTxt,
                style: ThemeWhite().labelHomeTitles(Colors.black),
                onChanged: (value) {
                  if (controller.remarksTxt.text.isEmpty) {
                    FocusManager.instance.primaryFocus?.unfocus();
                  }
                },
                inputFormatters: [
                  LengthLimitingTextInputFormatter(2058),
                ],
                keyboardType: TextInputType.multiline,
                autofocus: false,
                decoration: StyleInput().textAreaStyle(
                    'new_inspection_pretrip_remarks'.tr, Colors.white),
              ),
            ),
          ),
          SizedBox(height: h * 0.02),
          SizedBox(
            //color: Colors.red,
            width: w,
            child: Row(
              children: [
                _conditions(),
                SizedBox(
                  width: w * 0.7,
                  child: Text('new_inspection_pretrip_remarks_msg'.tr,
                      style: ThemeWhite().labelCheckbox(Colors.black)),
                ),
              ],
            ),
          ),
          SizedBox(height: h * 0.02),
          Text('new_inspection_pretrip_remarks_sign'.tr,
              style: ThemeWhite().labelCheckbox(Colors.black)),
          SizedBox(height: h * 0.01),
          Text('new_inspection_pretrip_remarks_sign_conditions'.tr,
              style: ThemeWhite().labelCheckbox(Colors.black)),
          Container(
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
            height: h * 0.15,
            width: w * 0.8,
            child: PhysicalModel(
              color: Colors.white,
              elevation: 2,
              borderRadius: BorderRadius.circular(10),
              child: GestureDetector(
                onVerticalDragUpdate: (_) {},
                onTap: () {
                  controller.onStartPadDraw();
                },
                // onPanStart: (details) {
                //   print(details);
                //   controller.onStartPadDraw();
                // },
                onPanEnd: (details) {
                  controller.onEndPadDraw();
                },
                child: HandSignature(
                  control: controller.singnature1Control,
                  color: Colors.blueGrey,
                  width: 1,
                  maxWidth: 2.5,
                  type: SignatureDrawType.shape,
                ),
              ),
            ),
          ),
          SizedBox(
            height: h * 0.02,
          ),
          Center(
            child: _btnClearPad(),
          ),
          //
          SizedBox(height: h * 0.03),
        ],
      ),
    );
  }

  _conditions() {
    return SizedBox(
      width: 25,
      height: 25,
      child: Checkbox(
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        value: controller.conditionOfAbove,
        onChanged: (value) {
          controller.checkboxes('conditionOfAbove', value!);
          //controller.updateCheck(value!, 'fallPotencial');
        },
        checkColor: Colors.white,
        activeColor: Colors.black,
      ),
    );
  }

  _btnClearPad() {
    return Container(
      width: w * 0.3,
      height: h * 0.06,
      decoration: BoxDecoration(
          color: Colors.black, borderRadius: BorderRadius.circular(15)),
      child: TextButton(
          onPressed: () {
            controller.clearPad();
            //function to clean de pad bat still in the pad
            // setState(() {
            //   keyPad?.currentState?.clear();
            //   signaturePic = '';
            // });
          },
          child: Text(
            'utils_clear'.tr,
            style: TextStyle(color: Colors.white),
          )),
    );
  }
}
