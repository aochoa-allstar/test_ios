import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:onax_app/src/controllers/jsasSteperFormController.dart';
import 'package:onax_app/src/utils/styles/inputStyles.dart';
import 'package:onax_app/src/utils/styles/themWhite.dart';

class HazardsSteper extends StatelessWidget {
  final JsasSteperFormController controller;
  HazardsSteper({Key? key, required this.controller}) : super(key: key);
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
                _fallPotencial(),
                _overheadLift(),
              ],
            ),
          ),
          //Safety Glass & H2S Monitor
          SizedBox(
            //color: Colors.red,
            width: w,
            child: Row(
              children: [
                _h2s(),
                _pinchPoints(),
              ],
            ),
          ),
          //FRClotigh & Fall Protection
          SizedBox(
            //color: Colors.red,
            width: w,
            child: Row(
              children: [
                _slipTrip(),
                _sharpObj(),
              ],
            ),
          ),
          //Hearing protec & Respirator
          SizedBox(
            //color: Colors.red,
            width: w,
            child: Row(
              children: [
                _powerTools(),
                _hotColdSurf(),
              ],
            ),
          ),

          ///
          SizedBox(
            //color: Colors.red,
            width: w,
            child: Row(
              children: [
                _pressure(),
                _dropOjects(),
              ],
            ),
          ),
          //
          SizedBox(
            //color: Colors.red,
            width: w,
            child: Row(
              children: [
                _heavyLifting(),
                _wather(),
              ],
            ),
          ),
          //
          SizedBox(
            //color: Colors.red,
            width: w,
            child: Row(
              children: [
                _flammables(),
                _chemicals(),
              ],
            ),
          ),
          //Other
          SizedBox(
            width: w,
            child: Row(children: [
              Checkbox(
                value: controller.otherHazard,
                onChanged: (value) {
                  controller.updateCheck(value!, 'otherHazard');
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
                    controller: controller.otherHazardText,
                    style: ThemeWhite().labelHomeTitles(Colors.black),
                    onChanged: (value) {
                      if (controller.otherHazardText.text.isEmpty) {
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

  _fallPotencial() {
    return SizedBox(
      width: w * 0.35,
      child: Row(children: [
        Checkbox(
          value: controller.fallPotencial,
          onChanged: (value) {
            controller.updateCheck(value!, 'fallPotencial');
          },
          checkColor: Colors.white,
          activeColor: Colors.black,
        ),
        Text('new_jsas_hazards_fall'.tr, style: ThemeWhite().labelCheckbox(Colors.black)),
      ]),
    );
  }

  _overheadLift() {
    return SizedBox(
      width: w * 0.35,
      child: Row(children: [
        Checkbox(
          value: controller.overHeadLift,
          onChanged: (value) {
            controller.updateCheck(value!, 'overHeadLift');
          },
          checkColor: Colors.white,
          activeColor: Colors.black,
        ),
        Text('new_jsas_hazards_overhead'.tr, style: ThemeWhite().labelCheckbox(Colors.black)),
      ]),
    );
  }

  _h2s() {
    return SizedBox(
      width: w * 0.35,
      child: Row(children: [
        Checkbox(
          value: controller.h2s,
          onChanged: (value) {
            controller.updateCheck(value!, 'h2s');
          },
          checkColor: Colors.white,
          activeColor: Colors.black,
        ),
        Text('H2S', style: ThemeWhite().labelCheckbox(Colors.black)),
      ]),
    );
  }

  _pinchPoints() {
    return SizedBox(
      width: w * 0.35,
      child: Row(children: [
        Checkbox(
          value: controller.pinchPoints,
          onChanged: (value) {
            controller.updateCheck(value!, 'pinchPoints');
          },
          checkColor: Colors.white,
          activeColor: Colors.black,
        ),
        Text('new_jsas_hazards_pinch'.tr, style: ThemeWhite().labelCheckbox(Colors.black)),
      ]),
    );
  }

  _slipTrip() {
    return SizedBox(
      width: w * 0.35,
      child: Row(children: [
        Checkbox(
          value: controller.splipTrip,
          onChanged: (value) {
            controller.updateCheck(value!, 'splipTrip');
          },
          checkColor: Colors.white,
          activeColor: Colors.black,
        ),
        Text('new_jsas_hazards_split'.tr, style: ThemeWhite().labelCheckbox(Colors.black)),
      ]),
    );
  }

  _sharpObj() {
    return SizedBox(
      width: w * 0.4,
      child: Row(children: [
        Checkbox(
          value: controller.sharpObjects,
          onChanged: (value) {
            controller.updateCheck(value!, 'sharpObjects');
          },
          checkColor: Colors.white,
          activeColor: Colors.black,
        ),
        Text('new_jsas_hazards_sharp'.tr, style: ThemeWhite().labelCheckbox(Colors.black)),
      ]),
    );
  }

  _powerTools() {
    return SizedBox(
      width: w * 0.35,
      child: Row(children: [
        Checkbox(
          value: controller.powerTools,
          onChanged: (value) {
            controller.updateCheck(value!, 'powerTools');
          },
          checkColor: Colors.white,
          activeColor: Colors.black,
        ),
        Text('new_jsas_hazards_power'.tr, style: ThemeWhite().labelCheckbox(Colors.black)),
      ]),
    );
  }

  _hotColdSurf() {
    return SizedBox(
      width: w * 0.42,
      child: Row(children: [
        Checkbox(
          value: controller.hotClodSurface,
          onChanged: (value) {
            controller.updateCheck(value!, 'hotClodSurface');
          },
          checkColor: Colors.white,
          activeColor: Colors.black,
        ),
        Text('new_jsas_hazards_surface'.tr,
            style: ThemeWhite().labelCheckbox(Colors.black)),
      ]),
    );
  }

  _pressure() {
    return SizedBox(
      width: w * 0.35,
      child: Row(children: [
        Checkbox(
          value: controller.pressure,
          onChanged: (value) {
            controller.updateCheck(value!, 'pressure');
          },
          checkColor: Colors.white,
          activeColor: Colors.black,
        ),
        Text('new_jsas_hazards_preassure'.tr, style: ThemeWhite().labelCheckbox(Colors.black)),
      ]),
    );
  }

  _dropOjects() {
    return SizedBox(
      width: w * 0.42,
      child: Row(children: [
        Checkbox(
          value: controller.droppedObjects,
          onChanged: (value) {
            controller.updateCheck(value!, 'droppedObjects');
          },
          checkColor: Colors.white,
          activeColor: Colors.black,
        ),
        Text('new_jsas_hazards_dropped'.tr,
            style: ThemeWhite().labelCheckbox(Colors.black)),
      ]),
    );
  }

  _heavyLifting() {
    return SizedBox(
      width: w * 0.35,
      child: Row(children: [
        Checkbox(
          value: controller.heavyLifting,
          onChanged: (value) {
            controller.updateCheck(value!, 'heavyLifting');
          },
          checkColor: Colors.white,
          activeColor: Colors.black,
        ),
        Text('new_jsas_hazards_heavy'.tr, style: ThemeWhite().labelCheckbox(Colors.black)),
      ]),
    );
  }

  _wather() {
    return SizedBox(
      width: w * 0.35,
      child: Row(children: [
        Checkbox(
          value: controller.weather,
          onChanged: (value) {
            controller.updateCheck(value!, 'weather');
          },
          checkColor: Colors.white,
          activeColor: Colors.black,
        ),
        Text('new_jsas_hazards_weather'.tr, style: ThemeWhite().labelCheckbox(Colors.black)),
      ]),
    );
  }

  _flammables() {
    return SizedBox(
      width: w * 0.35,
      child: Row(children: [
        Checkbox(
          value: controller.flammables,
          onChanged: (value) {
            controller.updateCheck(value!, 'flammables');
          },
          checkColor: Colors.white,
          activeColor: Colors.black,
        ),
        Text('new_jsas_hazards_flammables'.tr, style: ThemeWhite().labelCheckbox(Colors.black)),
      ]),
    );
  }

  _chemicals() {
    return SizedBox(
      width: w * 0.35,
      child: Row(children: [
        Checkbox(
          value: controller.chemicals,
          onChanged: (value) {
            controller.updateCheck(value!, 'chemicals');
          },
          checkColor: Colors.white,
          activeColor: Colors.black,
        ),
        Text('Chemicals', style: ThemeWhite().labelCheckbox(Colors.black)),
      ]),
    );
  }
}
