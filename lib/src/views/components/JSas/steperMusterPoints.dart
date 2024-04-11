import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import 'package:hand_signature/signature.dart';
import 'package:onax_app/src/controllers/jsasSteperFormController.dart';
import 'package:onax_app/src/utils/styles/themWhite.dart';

class MusterPointsSteper extends StatelessWidget {
  final JsasSteperFormController controller;
  MusterPointsSteper({Key? key, required this.controller}) : super(key: key);
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
          //jobDescription
          Text('new_jsas_muster_draw'.tr,
              style: ThemeWhite().labelCheckbox(Colors.black)),
          RawGestureDetector(
            gestures: {
              VerticalDragGestureRecognizer:
                  GestureRecognizerFactoryWithHandlers<
                      VerticalDragGestureRecognizer>(
                () => VerticalDragGestureRecognizer(),
                (instance) {
                  instance.onUpdate = (details) {
                    print(details);
                  };
                },
              ),
            },
            child: Container(
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(10)),
              height: h * 0.4,
              width: w,
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
                    control: controller.handMusterPointsControl,
                    color: Colors.blueGrey,
                    width: 1,
                    maxWidth: 2.5,
                    type: SignatureDrawType.shape,
                  ),
                ),
              ),
            ),
          ),
          //clearMosterPoints()
          //
          SizedBox(height: h * 0.02),
          _btnclearMusterPoints(),
          SizedBox(height: h * 0.01),
        ],
      ),
    );
  }

  _btnclearMusterPoints() {
    return Container(
      width: w * 0.3,
      height: h * 0.06,
      decoration: BoxDecoration(
          color: Colors.black, borderRadius: BorderRadius.circular(15)),
      child: TextButton(
          onPressed: () {
            controller.clearMosterPoints();
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
