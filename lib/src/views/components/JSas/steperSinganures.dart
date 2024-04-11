import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import 'package:hand_signature/signature.dart';
import 'package:onax_app/src/controllers/jsasSteperFormController.dart';
import 'package:onax_app/src/utils/sharePrefs/accountPrefs.dart';
import 'package:onax_app/src/utils/styles/themWhite.dart';

class SignaturesSteper extends StatelessWidget {
  final JsasSteperFormController controller;
  SignaturesSteper({Key? key, required this.controller}) : super(key: key);
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
          Text('new_jsas_signatures_msg'.tr,
              style: ThemeWhite().labelCheckbox(Colors.black)),
          SizedBox(height: h * 0.01),
          Text('utils_signature'.tr + ' ${AccountPrefs.name}.',
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
                  width: 1.0,
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

          SizedBox(height: h * 0.02),
          controller.helperID > 0 ? _signature2() : const SizedBox(),
          SizedBox(height: h * 0.02),
          controller.helperID2 > 0 ? _signature3() : const SizedBox(),
          //
          SizedBox(height: h * 0.03),
        ],
      ),
    );
  }

  _signature2() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('utils_signature'.tr + ' ${controller.helperName}.',
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
                control: controller.singnature2Control,
                color: Colors.blueGrey,
                width: 1.0,
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
          child: _btnClearPad2(),
        ),
        // Row(
        //   mainAxisAlignment: MainAxisAlignment.center,
        //   children: [
        //     _btnClearPad2(),
        //     SizedBox(
        //       width: w * 0.03,
        //     ),

        //   ],
        // )
      ],
    );
  }

  _signature3() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('utils_signature'.tr + ' ${controller.helperName2}.',
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
                control: controller.singnature3Control,
                color: Colors.blueGrey,
                width: 1.0,
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
          child: _btnClearPad3(),
        ),
        // _signature3(),
        // Row(
        //   mainAxisAlignment: MainAxisAlignment.center,
        //   children: [
        //     _btnClearPad(),
        //     SizedBox(
        //       width: w * 0.03,
        //     ),

        //   ],
        // )
      ],
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

  _btnClearPad2() {
    return Container(
      width: w * 0.3,
      height: h * 0.06,
      decoration: BoxDecoration(
          color: Colors.black, borderRadius: BorderRadius.circular(15)),
      child: TextButton(
          onPressed: () {
            controller.clearPad2();
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

  _btnClearPad3() {
    return Container(
      width: w * 0.3,
      height: h * 0.06,
      decoration: BoxDecoration(
          color: Colors.black, borderRadius: BorderRadius.circular(15)),
      child: TextButton(
          onPressed: () {
            controller.clearPad3();
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
  //END CLASS
}
