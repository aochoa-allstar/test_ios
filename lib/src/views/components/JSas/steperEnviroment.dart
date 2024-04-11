import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:onax_app/src/controllers/jsasSteperFormController.dart';
import 'package:onax_app/src/utils/styles/inputStyles.dart';
import 'package:onax_app/src/utils/styles/themWhite.dart';

class EnviromentConcernsSteper extends StatelessWidget {
  final JsasSteperFormController controller;
  EnviromentConcernsSteper({Key? key, required this.controller})
      : super(key: key);
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

          //Other
          SizedBox(
            width: w,
            child: Row(children: [
              Checkbox(
                value: controller.weatherCondition,
                onChanged: (value) {
                  controller.updateCheck(value!, 'weatherCondition');
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
                    controller: controller.otherWeatherContition,
                    style: ThemeWhite().labelHomeTitles(Colors.black),
                    onChanged: (value) {
                      if (controller.otherWeatherContition.text.isEmpty) {
                        FocusManager.instance.primaryFocus?.unfocus();
                      }
                    },
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(255),
                    ],
                    keyboardType: TextInputType.text,
                    autofocus: false,
                    decoration: StyleInput()
                        .inputTextSyle('new_jsas_environment_weather'.tr, Colors.white),
                  ),
                ),
              ),
            ]),
          ),

          SizedBox(height: h * 0.02),
          SizedBox(
            width: w,
            child: Row(children: [
              Checkbox(
                value: controller.windDirection,
                onChanged: (value) {
                  controller.updateCheck(value!, 'windDirection');
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
                    controller: controller.otherWindDirection,
                    style: ThemeWhite().labelHomeTitles(Colors.black),
                    onChanged: (value) {
                      if (controller.otherWindDirection.text.isEmpty) {
                        FocusManager.instance.primaryFocus?.unfocus();
                      }
                    },
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(255),
                    ],
                    keyboardType: TextInputType.text,
                    autofocus: false,
                    decoration: StyleInput()
                        .inputTextSyle('new_jsas_environment_wind'.tr, Colors.white),
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
}
