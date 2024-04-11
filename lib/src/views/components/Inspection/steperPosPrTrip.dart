import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:onax_app/src/controllers/inspectionsController.dart';

import 'package:onax_app/src/utils/styles/inputStyles.dart';
import 'package:onax_app/src/utils/styles/themWhite.dart';

class PosPrTripSteper extends StatelessWidget {
  final InspectionController controller;
  PosPrTripSteper({Key? key, required this.controller}) : super(key: key);
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
          SizedBox(
            //color: Colors.red,
            width: w,
            child: Row(
              children: [
                Text('Prt', style: ThemeWhite().labelCheckbox(Colors.black)),
                SizedBox(
                  width: w * 0.06,
                ),
                Text('Pot', style: ThemeWhite().labelCheckbox(Colors.black)),
                SizedBox(
                  width: w * 0.06,
                ),
                Text('RR', style: ThemeWhite().labelCheckbox(Colors.black)),
              ],
            ),
          ),
          SizedBox(height: h * 0.01),
          //check Steel Toed Shoes & Hard Hat
          SizedBox(
            //color: Colors.red,
            width: w,
            child: Row(
              children: [
                _prtAirCompressor(),
                SizedBox(
                  width: w * 0.04,
                ),
                _posAirCompressor(),
                SizedBox(
                  width: w * 0.04,
                ),
                _rrAirCompressor(),
                SizedBox(
                  width: w * 0.02,
                ),
                Text('new_inspection_pretrip_check_aircompressor'.tr,
                    style: ThemeWhite().labelCheckbox(Colors.black)),
              ],
            ),
          ),
          SizedBox(height: h * 0.02),
          //Safety Glass & H2S Monitor
          SizedBox(
            //color: Colors.red,
            width: w,
            child: Row(
              children: [
                _prtAirLines(),
                SizedBox(
                  width: w * 0.04,
                ),
                _posAirLines(),
                SizedBox(
                  width: w * 0.04,
                ),
                _rrAirLines(),
                SizedBox(
                  width: w * 0.02,
                ),
                Text('new_inspection_pretrip_check_airlines'.tr,
                    style: ThemeWhite().labelCheckbox(Colors.black)),
              ],
            ),
          ),
          SizedBox(height: h * 0.02),
          //FRClotigh & Fall Protection
          SizedBox(
            //color: Colors.red,
            width: w,
            child: Row(
              children: [
                _prtBattery(),
                SizedBox(
                  width: w * 0.04,
                ),
                _posBattery(),
                SizedBox(
                  width: w * 0.04,
                ),
                _rrBattery(),
                SizedBox(
                  width: w * 0.02,
                ),
                Text('new_inspection_pretrip_check_battery'.tr,
                    style: ThemeWhite().labelCheckbox(Colors.black)),
              ],
            ),
          ),
          SizedBox(height: h * 0.02),
          //Hearing protec & Respirator
          SizedBox(
            //color: Colors.red,
            width: w,
            child: Row(
              children: [
                _prtBeltsHoses(),
                SizedBox(
                  width: w * 0.04,
                ),
                _posBeltsHoses(),
                SizedBox(
                  width: w * 0.04,
                ),
                _rrBeltsHoes(),
                SizedBox(
                  width: w * 0.02,
                ),
                Text('new_inspection_pretrip_check_belts'.tr,
                    style: ThemeWhite().labelCheckbox(Colors.black)),
              ],
            ),
          ),
          SizedBox(height: h * 0.02),

          ///
          SizedBox(
            //color: Colors.red,
            width: w,
            child: Row(
              children: [
                _prtBody(),
                SizedBox(
                  width: w * 0.04,
                ),
                _posBody(),
                SizedBox(
                  width: w * 0.04,
                ),
                _rrBody(),
                SizedBox(
                  width: w * 0.02,
                ),
                Text('new_inspection_pretrip_check_body'.tr, style: ThemeWhite().labelCheckbox(Colors.black)),
              ],
            ),
          ),
          //
          SizedBox(height: h * 0.02),
          SizedBox(
            //color: Colors.red,
            width: w,
            child: Row(
              children: [
                _prtBrakeAccesories(),
                SizedBox(
                  width: w * 0.04,
                ),
                _posBrakeAccesories(),
                SizedBox(
                  width: w * 0.04,
                ),
                _rrBrakeAccesories(),
                SizedBox(
                  width: w * 0.02,
                ),
                Text('new_inspection_pretrip_check_brake_accesories'.tr,
                    style: ThemeWhite().labelCheckbox(Colors.black)),
              ],
            ),
          ),
          //
          SizedBox(height: h * 0.02),
          SizedBox(
            //color: Colors.red,
            width: w,
            child: Row(
              children: [
                _prtBrakesParking(),
                SizedBox(
                  width: w * 0.04,
                ),
                _posBrakesParking(),
                SizedBox(
                  width: w * 0.04,
                ),
                _rrBrakesParking(),
                SizedBox(
                  width: w * 0.02,
                ),
                Text('new_inspection_pretrip_check_brakes_parking'.tr,
                    style: ThemeWhite().labelCheckbox(Colors.black)),
              ],
            ),
          ),
          SizedBox(height: h * 0.02),
          SizedBox(
            //color: Colors.red,
            width: w,
            child: Row(
              children: [
                _prtBrakesService(),
                SizedBox(
                  width: w * 0.04,
                ),
                _posBrakesService(),
                SizedBox(
                  width: w * 0.04,
                ),
                _rrBrakesService(),
                SizedBox(
                  width: w * 0.02,
                ),
                Text('new_inspection_pretrip_check_brakes_service'.tr,
                    style: ThemeWhite().labelCheckbox(Colors.black)),
              ],
            ),
          ),
          SizedBox(height: h * 0.02),
          SizedBox(
            //color: Colors.red,
            width: w,
            child: Row(
              children: [
                _prtClutch(),
                SizedBox(
                  width: w * 0.04,
                ),
                _posClutch(),
                SizedBox(
                  width: w * 0.04,
                ),
                _rrClutch(),
                SizedBox(
                  width: w * 0.02,
                ),
                Text('new_inspection_pretrip_check_clutch'.tr, style: ThemeWhite().labelCheckbox(Colors.black)),
              ],
            ),
          ),

          SizedBox(height: h * 0.02),
          SizedBox(
            //color: Colors.red,
            width: w,
            child: Row(
              children: [
                _prtCouplingDevices(),
                SizedBox(
                  width: w * 0.04,
                ),
                _posCouplingDevices(),
                SizedBox(
                  width: w * 0.04,
                ),
                _rrCouplingDevices(),
                SizedBox(
                  width: w * 0.02,
                ),
                Text('new_inspection_pretrip_check_coupling'.tr,
                    style: ThemeWhite().labelCheckbox(Colors.black)),
              ],
            ),
          ),
          SizedBox(height: h * 0.02),
          SizedBox(
            //color: Colors.red,
            width: w,
            child: Row(
              children: [
                _prtDefrosterHeater(),
                SizedBox(
                  width: w * 0.04,
                ),
                _posDefrosterHeater(),
                SizedBox(
                  width: w * 0.04,
                ),
                _rrDefrosterHeater(),
                SizedBox(
                  width: w * 0.02,
                ),
                Text('new_inspection_pretrip_check_defroster'.tr,
                    style: ThemeWhite().labelCheckbox(Colors.black)),
              ],
            ),
          ),
          SizedBox(height: h * 0.02),
          SizedBox(
            //color: Colors.red,
            width: w,
            child: Row(
              children: [
                _prtDriveLine(),
                SizedBox(
                  width: w * 0.04,
                ),
                _posDriveLine(),
                SizedBox(
                  width: w * 0.04,
                ),
                _rrDriveLine(),
                SizedBox(
                  width: w * 0.02,
                ),
                Text('new_inspection_pretrip_check_drive'.tr,
                    style: ThemeWhite().labelCheckbox(Colors.black)),
              ],
            ),
          ),
          SizedBox(height: h * 0.02),
          SizedBox(
            //color: Colors.red,
            width: w,
            child: Row(
              children: [
                _prtEngine(),
                SizedBox(
                  width: w * 0.04,
                ),
                _posEngine(),
                SizedBox(
                  width: w * 0.04,
                ),
                _rrEngine(),
                SizedBox(
                  width: w * 0.02,
                ),
                Text('new_inspection_pretrip_check_engine'.tr, style: ThemeWhite().labelCheckbox(Colors.black)),
              ],
            ),
          ),
          SizedBox(height: h * 0.02),
          SizedBox(
            //color: Colors.red,
            width: w,
            child: Row(
              children: [
                _prtFifthWeel(),
                SizedBox(
                  width: w * 0.04,
                ),
                _posFifthWeel(),
                SizedBox(
                  width: w * 0.04,
                ),
                _rrFifthWeel(),
                SizedBox(
                  width: w * 0.02,
                ),
                Text('new_inspection_pretrip_check_fifth'.tr,
                    style: ThemeWhite().labelCheckbox(Colors.black)),
              ],
            ),
          ),
          SizedBox(height: h * 0.02),
          SizedBox(
            //color: Colors.red,
            width: w,
            child: Row(
              children: [
                _prtExhaust(),
                SizedBox(
                  width: w * 0.04,
                ),
                _posExhaust(),
                SizedBox(
                  width: w * 0.04,
                ),
                _rrExhaust(),
                SizedBox(
                  width: w * 0.02,
                ),
                Text('new_inspection_pretrip_check_exhaust'.tr,
                    style: ThemeWhite().labelCheckbox(Colors.black)),
              ],
            ),
          ),
          SizedBox(height: h * 0.02),
          SizedBox(
            //color: Colors.red,
            width: w,
            child: Row(
              children: [
                _prtFluidLevels(),
                SizedBox(
                  width: w * 0.04,
                ),
                _posFluidLevels(),
                SizedBox(
                  width: w * 0.04,
                ),
                _rrFluidLevels(),
                SizedBox(
                  width: w * 0.02,
                ),
                Text('new_inspection_pretrip_check_fluid'.tr,
                    style: ThemeWhite().labelCheckbox(Colors.black)),
              ],
            ),
          ),
          SizedBox(height: h * 0.02),
          SizedBox(
            //color: Colors.red,
            width: w,
            child: Row(
              children: [
                _prtFrameAndAssembly(),
                SizedBox(
                  width: w * 0.04,
                ),
                _posFrameAndAssembly(),
                SizedBox(
                  width: w * 0.04,
                ),
                _rrFrameAndAssembly(),
                SizedBox(
                  width: w * 0.02,
                ),
                Text('new_inspection_pretrip_check_frame'.tr,
                    style: ThemeWhite().labelCheckbox(Colors.black)),
              ],
            ),
          ),
          SizedBox(height: h * 0.02),
          SizedBox(
            //color: Colors.red,
            width: w,
            child: Row(
              children: [
                _prtFrontAxle(),
                SizedBox(
                  width: w * 0.04,
                ),
                _posFrontAxle(),
                SizedBox(
                  width: w * 0.04,
                ),
                _rrFrontAxle(),
                SizedBox(
                  width: w * 0.02,
                ),
                Text('new_inspection_pretrip_check_front'.tr,
                    style: ThemeWhite().labelCheckbox(Colors.black)),
              ],
            ),
          ),
          SizedBox(height: h * 0.02),
          SizedBox(
            //color: Colors.red,
            width: w,
            child: Row(
              children: [
                _prtFuelTanks(),
                SizedBox(
                  width: w * 0.04,
                ),
                _posFuelTanks(),
                SizedBox(
                  width: w * 0.04,
                ),
                _rrFuelTanks(),
                SizedBox(
                  width: w * 0.02,
                ),
                Text('new_inspection_pretrip_check_fuel'.tr,
                    style: ThemeWhite().labelCheckbox(Colors.black)),
              ],
            ),
          ),

          SizedBox(height: h * 0.02),
          SizedBox(
            //color: Colors.red,
            width: w,
            child: Row(
              children: [
                _prtGenerator(),
                SizedBox(
                  width: w * 0.04,
                ),
                _posGenerator(),
                SizedBox(
                  width: w * 0.04,
                ),
                _rrGenerator(),
                SizedBox(
                  width: w * 0.02,
                ),
                Text('new_inspection_pretrip_check_generator'.tr,
                    style: ThemeWhite().labelCheckbox(Colors.black)),
              ],
            ),
          ),

          SizedBox(height: h * 0.02),
          SizedBox(
            //color: Colors.red,
            width: w,
            child: Row(
              children: [
                _prtHorn(),
                SizedBox(
                  width: w * 0.04,
                ),
                _posHorn(),
                SizedBox(
                  width: w * 0.04,
                ),
                _rrHorn(),
                SizedBox(
                  width: w * 0.02,
                ),
                Text('new_inspection_pretrip_check_horn'.tr, style: ThemeWhite().labelCheckbox(Colors.black)),
              ],
            ),
          ),

          SizedBox(height: h * 0.02),
          SizedBox(
            //color: Colors.red,
            width: w,
            child: Row(
              children: [
                _prtLights(),
                SizedBox(
                  width: w * 0.04,
                ),
                _posLights(),
                SizedBox(
                  width: w * 0.04,
                ),
                _rrLights(),
                SizedBox(
                  width: w * 0.02,
                ),
                Text('new_inspection_pretrip_check_lights'.tr,
                    style: ThemeWhite().labelCheckbox(Colors.black)),
              ],
            ),
          ),
          SizedBox(height: h * 0.02),
          SizedBox(
            //color: Colors.red,
            width: w,
            child: Row(
              children: [
                _prtMirrors(),
                SizedBox(
                  width: w * 0.04,
                ),
                _posMirrors(),
                SizedBox(
                  width: w * 0.04,
                ),
                _rrMirrors(),
                SizedBox(
                  width: w * 0.02,
                ),
                Text('new_inspection_pretrip_check_mirrors'.tr,
                    style: ThemeWhite().labelCheckbox(Colors.black)),
              ],
            ),
          ),
          SizedBox(height: h * 0.02),
          SizedBox(
            //color: Colors.red,
            width: w,
            child: Row(
              children: [
                _prtMuffler(),
                SizedBox(
                  width: w * 0.04,
                ),
                _posMuffler(),
                SizedBox(
                  width: w * 0.04,
                ),
                _rrMuffler(),
                SizedBox(
                  width: w * 0.02,
                ),
                Text('new_inspection_pretrip_check_muffler'.tr,
                    style: ThemeWhite().labelCheckbox(Colors.black)),
              ],
            ),
          ),

          SizedBox(height: h * 0.02),
          SizedBox(
            //color: Colors.red,
            width: w,
            child: Row(
              children: [
                _prtOilLevel(),
                SizedBox(
                  width: w * 0.04,
                ),
                _posOilLevel(),
                SizedBox(
                  width: w * 0.04,
                ),
                _rrOilLevel(),
                SizedBox(
                  width: w * 0.02,
                ),
                Text('new_inspection_pretrip_check_oil'.tr,
                    style: ThemeWhite().labelCheckbox(Colors.black)),
              ],
            ),
          ),

          SizedBox(height: h * 0.02),
          SizedBox(
            //color: Colors.red,
            width: w,
            child: Row(
              children: [
                _prtRadiatorLevel(),
                SizedBox(
                  width: w * 0.04,
                ),
                _posRadiatorLevel(),
                SizedBox(
                  width: w * 0.04,
                ),
                _rrRadiatorLevel(),
                SizedBox(
                  width: w * 0.02,
                ),
                Text('new_inspection_pretrip_check_radiator'.tr,
                    style: ThemeWhite().labelCheckbox(Colors.black)),
              ],
            ),
          ),
          SizedBox(height: h * 0.02),
          SizedBox(
            //color: Colors.red,
            width: w,
            child: Row(
              children: [
                _prtRearEnd(),
                SizedBox(
                  width: w * 0.04,
                ),
                _posRearEnd(),
                SizedBox(
                  width: w * 0.04,
                ),
                _rrRearEnd(),
                SizedBox(
                  width: w * 0.02,
                ),
                Text('new_inspection_pretrip_check_rear'.tr,
                    style: ThemeWhite().labelCheckbox(Colors.black)),
              ],
            ),
          ),

          SizedBox(height: h * 0.02),
          SizedBox(
            //color: Colors.red,
            width: w,
            child: Row(
              children: [
                _prtReflectors(),
                SizedBox(
                  width: w * 0.04,
                ),
                _posReflectors(),
                SizedBox(
                  width: w * 0.04,
                ),
                _rrReflectors(),
                SizedBox(
                  width: w * 0.02,
                ),
                Text('new_inspection_pretrip_check_reflectors'.tr,
                    style: ThemeWhite().labelCheckbox(Colors.black)),
              ],
            ),
          ),

          SizedBox(height: h * 0.02),
          SizedBox(
            //color: Colors.red,
            width: w,
            child: Row(
              children: [
                _prtSafetyEquipment(),
                SizedBox(
                  width: w * 0.04,
                ),
                _posSafetyEquipment(),
                SizedBox(
                  width: w * 0.04,
                ),
                _rrSafetyEquipment(),
                SizedBox(
                  width: w * 0.02,
                ),
                Text(
                    'new_inspection_pretrip_check_safety'.tr,
                    style: ThemeWhite().labelCheckbox(Colors.black)),
              ],
            ),
          ),

          SizedBox(height: h * 0.02),
          SizedBox(
            //color: Colors.red,
            width: w,
            child: Row(
              children: [
                _prtStarter(),
                SizedBox(
                  width: w * 0.04,
                ),
                _posStarter(),
                SizedBox(
                  width: w * 0.04,
                ),
                _rrStarter(),
                SizedBox(
                  width: w * 0.02,
                ),
                Text('new_inspection_pretrip_check_starter'.tr,
                    style: ThemeWhite().labelCheckbox(Colors.black)),
              ],
            ),
          ),

          SizedBox(height: h * 0.02),
          SizedBox(
            //color: Colors.red,
            width: w,
            child: Row(
              children: [
                _prtSteering(),
                SizedBox(
                  width: w * 0.04,
                ),
                _posSteering(),
                SizedBox(
                  width: w * 0.04,
                ),
                _rrSteering(),
                SizedBox(
                  width: w * 0.02,
                ),
                Text('new_inspection_pretrip_check_steering'.tr,
                    style: ThemeWhite().labelCheckbox(Colors.black)),
              ],
            ),
          ),

          SizedBox(height: h * 0.02),
          SizedBox(
            //color: Colors.red,
            width: w,
            child: Row(
              children: [
                _prtSuspensionSystem(),
                SizedBox(
                  width: w * 0.04,
                ),
                _posSuspensionSystem(),
                SizedBox(
                  width: w * 0.04,
                ),
                _rrSuspensionSystem(),
                SizedBox(
                  width: w * 0.02,
                ),
                Text('new_inspection_pretrip_check_suspension'.tr,
                    style: ThemeWhite().labelCheckbox(Colors.black)),
              ],
            ),
          ),
          SizedBox(height: h * 0.02),
          SizedBox(
            //color: Colors.red,
            width: w,
            child: Row(
              children: [
                _prtTireChains(),
                SizedBox(
                  width: w * 0.04,
                ),
                _posTireChains(),
                SizedBox(
                  width: w * 0.04,
                ),
                _rrTireChains(),
                SizedBox(
                  width: w * 0.02,
                ),
                Text('new_inspection_pretrip_check_tirechains'.tr,
                    style: ThemeWhite().labelCheckbox(Colors.black)),
              ],
            ),
          ),
          SizedBox(height: h * 0.02),
          SizedBox(
            //color: Colors.red,
            width: w,
            child: Row(
              children: [
                _prtTires(),
                SizedBox(
                  width: w * 0.04,
                ),
                _posTires(),
                SizedBox(
                  width: w * 0.04,
                ),
                _rrTires(),
                SizedBox(
                  width: w * 0.02,
                ),
                Text('new_inspection_pretrip_check_tires'.tr, style: ThemeWhite().labelCheckbox(Colors.black)),
              ],
            ),
          ),
          SizedBox(height: h * 0.02),
          SizedBox(
            //color: Colors.red,
            width: w,
            child: Row(
              children: [
                _prtTransmission(),
                SizedBox(
                  width: w * 0.04,
                ),
                _posTransmission(),
                SizedBox(
                  width: w * 0.04,
                ),
                _rrTransmission(),
                SizedBox(
                  width: w * 0.02,
                ),
                Text('new_inspection_pretrip_check_transmission'.tr,
                    style: ThemeWhite().labelCheckbox(Colors.black)),
              ],
            ),
          ),
          SizedBox(height: h * 0.02),
          SizedBox(
            //color: Colors.red,
            width: w,
            child: Row(
              children: [
                _prtTripRecorder(),
                SizedBox(
                  width: w * 0.04,
                ),
                _posTripRecorder(),
                SizedBox(
                  width: w * 0.04,
                ),
                _rrTripRecorder(),
                SizedBox(
                  width: w * 0.02,
                ),
                Text('new_inspection_pretrip_check_trip'.tr,
                    style: ThemeWhite().labelCheckbox(Colors.black)),
              ],
            ),
          ),
          SizedBox(height: h * 0.02),
          SizedBox(
            //color: Colors.red,
            width: w,
            child: Row(
              children: [
                _prtWheelsAndRims(),
                SizedBox(
                  width: w * 0.04,
                ),
                _posWheelsAndRims(),
                SizedBox(
                  width: w * 0.04,
                ),
                _rrWheelsAndRims(),
                SizedBox(
                  width: w * 0.02,
                ),
                Text('new_inspection_pretrip_check_wheels'.tr,
                    style: ThemeWhite().labelCheckbox(Colors.black)),
              ],
            ),
          ),

          SizedBox(height: h * 0.02),
          SizedBox(
            //color: Colors.red,
            width: w,
            child: Row(
              children: [
                _prtWindows(),
                SizedBox(
                  width: w * 0.04,
                ),
                _posWindows(),
                SizedBox(
                  width: w * 0.04,
                ),
                _rrWindows(),
                SizedBox(
                  width: w * 0.02,
                ),
                Text('new_inspection_pretrip_check_windows'.tr,
                    style: ThemeWhite().labelCheckbox(Colors.black)),
              ],
            ),
          ),
          SizedBox(height: h * 0.02),
          SizedBox(
            //color: Colors.red,
            width: w,
            child: Row(
              children: [
                _prtWindshieldWipers(),
                SizedBox(
                  width: w * 0.04,
                ),
                _posWindshieldWipers(),
                SizedBox(
                  width: w * 0.04,
                ),
                _rrWindshieldWipers(),
                SizedBox(
                  width: w * 0.02,
                ),
                Text('new_inspection_pretrip_check_windshield'.tr,
                    style: ThemeWhite().labelCheckbox(Colors.black)),
              ],
            ),
          ),
          SizedBox(height: h * 0.02),
          SizedBox(
            //color: Colors.red,
            width: w,
            child: Row(
              children: [
                _prtOther(),
                SizedBox(
                  width: w * 0.04,
                ),
                _posOther(),
                SizedBox(
                  width: w * 0.04,
                ),
                _rrOther(),
                SizedBox(
                  width: w * 0.02,
                ),
                Text('utils_other'.tr, style: ThemeWhite().labelCheckbox(Colors.black)),
              ],
            ),
          ),
          SizedBox(height: h * 0.01),
        ],
      ),
    );
  }

  _prtAirCompressor() {
    return SizedBox(
      width: 25,
      height: 25,
      child: Checkbox(
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        value: controller.prtAirCompressor,
        onChanged: (value) {
          if (controller.prePost == 1) {
            controller.checkboxes('ptrAirCompressor', value!);
          }

          //controller.updateCheck(value!, 'fallPotencial');
        },
        checkColor: Colors.white,
        activeColor: Colors.black,
      ),
    );
  }

  _posAirCompressor() {
    return SizedBox(
      width: 25,
      height: 25,
      child: Checkbox(
        value: controller.potAirCompressor,
        onChanged: (value) {
          if (controller.prePost == 2) {
            controller.checkboxes('potAirCompressor', value!);
          }
          //controller.updateCheck(value!, 'fallPotencial');
        },
        checkColor: Colors.white,
        activeColor: Colors.black,
      ),
    );
  }

  _rrAirCompressor() {
    return SizedBox(
      width: 25,
      height: 25,
      child: Checkbox(
        value: controller.rrAirCompressor,
        onChanged: (value) {
          controller.checkboxes('rrAirCompressor', value!);
          //controller.updateCheck(value!, 'fallPotencial');
        },
        checkColor: Colors.white,
        activeColor: Colors.black,
      ),
    );
  } ////

  _prtAirLines() {
    return SizedBox(
      width: 25,
      height: 25,
      child: Checkbox(
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        value: controller.prtAirLines,
        onChanged: (value) {
          if (controller.prePost == 1) {
            controller.checkboxes('ptrAirLines', value!);
          }
          //controller.updateCheck(value!, 'fallPotencial');
        },
        checkColor: Colors.white,
        activeColor: Colors.black,
      ),
    );
  }

  _posAirLines() {
    return SizedBox(
      width: 25,
      height: 25,
      child: Checkbox(
        value: controller.potAirLine,
        onChanged: (value) {
          if (controller.prePost == 2) {
            controller.checkboxes('potAirLines', value!);
          }
          //controller.updateCheck(value!, 'fallPotencial');
        },
        checkColor: Colors.white,
        activeColor: Colors.black,
      ),
    );
  }

  _rrAirLines() {
    return SizedBox(
      width: 25,
      height: 25,
      child: Checkbox(
        value: controller.rrAirLine,
        onChanged: (value) {
          controller.checkboxes('rrAirLines', value!);
          //controller.updateCheck(value!, 'fallPotencial');
        },
        checkColor: Colors.white,
        activeColor: Colors.black,
      ),
    );
  }

  ////////
  _prtBattery() {
    return SizedBox(
      width: 25,
      height: 25,
      child: Checkbox(
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        value: controller.prtBattery,
        onChanged: (value) {
          if (controller.prePost == 1) {
            controller.checkboxes('ptrBattery', value!);
          }
          //controller.updateCheck(value!, 'fallPotencial');
        },
        checkColor: Colors.white,
        activeColor: Colors.black,
      ),
    );
  }

  _posBattery() {
    return SizedBox(
      width: 25,
      height: 25,
      child: Checkbox(
        value: controller.potBattery,
        onChanged: (value) {
          if (controller.prePost == 2) {
            controller.checkboxes('potBattery', value!);
          }
          //controller.updateCheck(value!, 'fallPotencial');
        },
        checkColor: Colors.white,
        activeColor: Colors.black,
      ),
    );
  }

  _rrBattery() {
    return SizedBox(
      width: 25,
      height: 25,
      child: Checkbox(
        value: controller.rrBattery,
        onChanged: (value) {
          controller.checkboxes('rrBattery', value!);
          //controller.updateCheck(value!, 'fallPotencial');
        },
        checkColor: Colors.white,
        activeColor: Colors.black,
      ),
    );
  }

  ////////
  _prtBeltsHoses() {
    return SizedBox(
      width: 25,
      height: 25,
      child: Checkbox(
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        value: controller.prtBeltsAndHoses,
        onChanged: (value) {
          if (controller.prePost == 1) {
            controller.checkboxes('ptrBeltsAndHoses', value!);
          }
          //controller.updateCheck(value!, 'fallPotencial');
        },
        checkColor: Colors.white,
        activeColor: Colors.black,
      ),
    );
  }

  _posBeltsHoses() {
    return SizedBox(
      width: 25,
      height: 25,
      child: Checkbox(
        value: controller.potBeltsAndHoses,
        onChanged: (value) {
          if (controller.prePost == 2) {
            controller.checkboxes('potBeltsAndHoses', value!);
          }
          //controller.updateCheck(value!, 'fallPotencial');
        },
        checkColor: Colors.white,
        activeColor: Colors.black,
      ),
    );
  }

  _rrBeltsHoes() {
    return SizedBox(
      width: 25,
      height: 25,
      child: Checkbox(
        value: controller.rrBeltsAndHoses,
        onChanged: (value) {
          controller.checkboxes('rrBeltsAndHoses', value!);

          //controller.updateCheck(value!, 'fallPotencial');
        },
        checkColor: Colors.white,
        activeColor: Colors.black,
      ),
    );
  }

  ////////
  _prtBody() {
    return SizedBox(
      width: 25,
      height: 25,
      child: Checkbox(
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        value: controller.prtBody,
        onChanged: (value) {
          if (controller.prePost == 1) {
            controller.checkboxes('ptrBody', value!);
          }
          //controller.updateCheck(value!, 'fallPotencial');
        },
        checkColor: Colors.white,
        activeColor: Colors.black,
      ),
    );
  }

  _posBody() {
    return SizedBox(
      width: 25,
      height: 25,
      child: Checkbox(
        value: controller.potBody,
        onChanged: (value) {
          if (controller.prePost == 2) {
            controller.checkboxes('potBody', value!);
          }
          //controller.updateCheck(value!, 'fallPotencial');
        },
        checkColor: Colors.white,
        activeColor: Colors.black,
      ),
    );
  }

  _rrBody() {
    return SizedBox(
      width: 25,
      height: 25,
      child: Checkbox(
        value: controller.rrBody,
        onChanged: (value) {
          controller.checkboxes('rrBody', value!);

          //controller.updateCheck(value!, 'fallPotencial');
        },
        checkColor: Colors.white,
        activeColor: Colors.black,
      ),
    );
  }

  ///////
  _prtBrakeAccesories() {
    return SizedBox(
      width: 25,
      height: 25,
      child: Checkbox(
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        value: controller.prtBrakeAcessories,
        onChanged: (value) {
          //controller.updateCheck(value!, 'fallPotencial');
          if (controller.prePost == 1) {
            controller.checkboxes('ptrBrakeAccessories', value!);
          }
        },
        checkColor: Colors.white,
        activeColor: Colors.black,
      ),
    );
  }

  _posBrakeAccesories() {
    return SizedBox(
      width: 25,
      height: 25,
      child: Checkbox(
        value: controller.potBrakeAcessories,
        onChanged: (value) {
          if (controller.prePost == 2) {
            controller.checkboxes('potBrakeAccesories', value!);
          }
          //controller.updateCheck(value!, 'fallPotencial');
        },
        checkColor: Colors.white,
        activeColor: Colors.black,
      ),
    );
  }

  _rrBrakeAccesories() {
    return SizedBox(
      width: 25,
      height: 25,
      child: Checkbox(
        value: controller.rrBrakeAcessories,
        onChanged: (value) {
          controller.checkboxes('rrBrakeAccesories', value!);
          //controller.updateCheck(value!, 'fallPotencial');
        },
        checkColor: Colors.white,
        activeColor: Colors.black,
      ),
    );
  }

  _prtBrakesParking() {
    return SizedBox(
      width: 25,
      height: 25,
      child: Checkbox(
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        value: controller.prtBrakesParking,
        onChanged: (value) {
          //controller.updateCheck(value!, 'fallPotencial');
          if (controller.prePost == 1) {
            controller.checkboxes('ptrBrakesParking', value!);
          }
        },
        checkColor: Colors.white,
        activeColor: Colors.black,
      ),
    );
  }

  _posBrakesParking() {
    return SizedBox(
      width: 25,
      height: 25,
      child: Checkbox(
        value: controller.potBrakesParking,
        onChanged: (value) {
          if (controller.prePost == 2) {
            controller.checkboxes('potBrakesParking', value!);
          }
          //controller.updateCheck(value!, 'fallPotencial');
        },
        checkColor: Colors.white,
        activeColor: Colors.black,
      ),
    );
  }

  _rrBrakesParking() {
    return SizedBox(
      width: 25,
      height: 25,
      child: Checkbox(
        value: controller.rrBrakesParking,
        onChanged: (value) {
          controller.checkboxes('rrBrakesParking', value!);
          //controller.updateCheck(value!, 'fallPotencial');
        },
        checkColor: Colors.white,
        activeColor: Colors.black,
      ),
    );
  }

  ///
  _prtBrakesService() {
    return SizedBox(
      width: 25,
      height: 25,
      child: Checkbox(
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        value: controller.prtBrakesService,
        onChanged: (value) {
          //controller.updateCheck(value!, 'fallPotencial');ptrBrakesService
          if (controller.prePost == 1) {
            controller.checkboxes('ptrBrakesService', value!);
          }
        },
        checkColor: Colors.white,
        activeColor: Colors.black,
      ),
    );
  }

  _posBrakesService() {
    return SizedBox(
      width: 25,
      height: 25,
      child: Checkbox(
        value: controller.potBrakesService,
        onChanged: (value) {
          if (controller.prePost == 2) {
            controller.checkboxes('potBrakesService', value!);
          }
          //controller.updateCheck(value!, 'fallPotencial');
        },
        checkColor: Colors.white,
        activeColor: Colors.black,
      ),
    );
  }

  _rrBrakesService() {
    return SizedBox(
      width: 25,
      height: 25,
      child: Checkbox(
        value: controller.rrBrakesService,
        onChanged: (value) {
          controller.checkboxes('rrBrakesService', value!);
          //controller.updateCheck(value!, 'fallPotencial');
        },
        checkColor: Colors.white,
        activeColor: Colors.black,
      ),
    );
  }

  ///////
  _prtClutch() {
    return SizedBox(
      width: 25,
      height: 25,
      child: Checkbox(
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        value: controller.prtClutch,
        onChanged: (value) {
          //controller.updateCheck(value!, 'fallPotencial');
          if (controller.prePost == 1) {
            controller.checkboxes('ptrClutch', value!);
          }
        },
        checkColor: Colors.white,
        activeColor: Colors.black,
      ),
    );
  }

  _posClutch() {
    return SizedBox(
      width: 25,
      height: 25,
      child: Checkbox(
        value: controller.potClutch,
        onChanged: (value) {
          if (controller.prePost == 2) {
            controller.checkboxes('potClutch', value!);
          }
          //controller.updateCheck(value!, 'fallPotencial');
        },
        checkColor: Colors.white,
        activeColor: Colors.black,
      ),
    );
  }

  _rrClutch() {
    return SizedBox(
      width: 25,
      height: 25,
      child: Checkbox(
        value: controller.rrClutch,
        onChanged: (value) {
          controller.checkboxes('rrClutch', value!);

          //controller.updateCheck(value!, 'fallPotencial');
        },
        checkColor: Colors.white,
        activeColor: Colors.black,
      ),
    );
  }

  //////
  _prtCouplingDevices() {
    return SizedBox(
      width: 25,
      height: 25,
      child: Checkbox(
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        value: controller.prtCouplingDevices,
        onChanged: (value) {
          if (controller.prePost == 1) {
            controller.checkboxes('ptrCouplingDevices', value!);
          }
          //controller.updateCheck(value!, 'fallPotencial');
        },
        checkColor: Colors.white,
        activeColor: Colors.black,
      ),
    );
  }

  _posCouplingDevices() {
    return SizedBox(
      width: 25,
      height: 25,
      child: Checkbox(
        value: controller.potCouplingDevices,
        onChanged: (value) {
          if (controller.prePost == 1) {
            controller.checkboxes('potCouplingDevices', value!);
          }
          //controller.updateCheck(value!, 'fallPotencial');
        },
        checkColor: Colors.white,
        activeColor: Colors.black,
      ),
    );
  }

  _rrCouplingDevices() {
    return SizedBox(
      width: 25,
      height: 25,
      child: Checkbox(
        value: controller.rrCouplingDevices,
        onChanged: (value) {
          controller.checkboxes('rrCouplingDevices', value!);

          //controller.updateCheck(value!, 'fallPotencial');
        },
        checkColor: Colors.white,
        activeColor: Colors.black,
      ),
    );
  }

  //////
  _prtDefrosterHeater() {
    return SizedBox(
      width: 25,
      height: 25,
      child: Checkbox(
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        value: controller.prtDefrosterHeater,
        onChanged: (value) {
          if (controller.prePost == 1) {
            controller.checkboxes('ptrDefrosterHeater', value!);
          }
          //controller.updateCheck(value!, 'fallPotencial');
        },
        checkColor: Colors.white,
        activeColor: Colors.black,
      ),
    );
  }

  _posDefrosterHeater() {
    return SizedBox(
      width: 25,
      height: 25,
      child: Checkbox(
        value: controller.potDefrosterHeater,
        onChanged: (value) {
          if (controller.prePost == 2) {
            controller.checkboxes('potDefrosterHeater', value!);
          }
          //controller.updateCheck(value!, 'fallPotencial');
        },
        checkColor: Colors.white,
        activeColor: Colors.black,
      ),
    );
  }

  _rrDefrosterHeater() {
    return SizedBox(
      width: 25,
      height: 25,
      child: Checkbox(
        value: controller.rrDefrosterHeater,
        onChanged: (value) {
          controller.checkboxes('rrDefrosterHeater', value!);

          //controller.updateCheck(value!, 'fallPotencial');
        },
        checkColor: Colors.white,
        activeColor: Colors.black,
      ),
    );
  }

  _prtDriveLine() {
    return SizedBox(
      width: 25,
      height: 25,
      child: Checkbox(
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        value: controller.prtDriveLine,
        onChanged: (value) {
          if (controller.prePost == 1) {
            controller.checkboxes('ptrDriveLine', value!);
          }
          //controller.updateCheck(value!, 'fallPotencial');
        },
        checkColor: Colors.white,
        activeColor: Colors.black,
      ),
    );
  }

  _posDriveLine() {
    return SizedBox(
      width: 25,
      height: 25,
      child: Checkbox(
        value: controller.potDriveLine,
        onChanged: (value) {
          if (controller.prePost == 2) {
            controller.checkboxes('potDriveLine', value!);
          }
          //controller.updateCheck(value!, 'fallPotencial');
        },
        checkColor: Colors.white,
        activeColor: Colors.black,
      ),
    );
  }

  _rrDriveLine() {
    return SizedBox(
      width: 25,
      height: 25,
      child: Checkbox(
        value: controller.rrDriveLine,
        onChanged: (value) {
          controller.checkboxes('rrDriveLine', value!);

          //controller.updateCheck(value!, 'fallPotencial');
        },
        checkColor: Colors.white,
        activeColor: Colors.black,
      ),
    );
  }

  ///
  _prtEngine() {
    return SizedBox(
      width: 25,
      height: 25,
      child: Checkbox(
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        value: controller.prtEngine,
        onChanged: (value) {
          if (controller.prePost == 1) {
            controller.checkboxes('ptrEngine', value!);
          }
          //controller.updateCheck(value!, 'fallPotencial');
        },
        checkColor: Colors.white,
        activeColor: Colors.black,
      ),
    );
  }

  _posEngine() {
    return SizedBox(
      width: 25,
      height: 25,
      child: Checkbox(
        value: controller.potEngine,
        onChanged: (value) {
          if (controller.prePost == 2) {
            controller.checkboxes('potEngine', value!);
          }
          //controller.updateCheck(value!, 'fallPotencial');
        },
        checkColor: Colors.white,
        activeColor: Colors.black,
      ),
    );
  }

  _rrEngine() {
    return SizedBox(
      width: 25,
      height: 25,
      child: Checkbox(
        value: controller.rrEngine,
        onChanged: (value) {
          controller.checkboxes('potEngine', value!);

          //controller.updateCheck(value!, 'fallPotencial');
        },
        checkColor: Colors.white,
        activeColor: Colors.black,
      ),
    );
  }

  _prtExhaust() {
    return SizedBox(
      width: 25,
      height: 25,
      child: Checkbox(
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        value: controller.prtExhaust,
        onChanged: (value) {
          if (controller.prePost == 1) {
            controller.checkboxes('ptrExhaust', value!);
          }
          //controller.updateCheck(value!, 'fallPotencial');
        },
        checkColor: Colors.white,
        activeColor: Colors.black,
      ),
    );
  }

  _posExhaust() {
    return SizedBox(
      width: 25,
      height: 25,
      child: Checkbox(
        value: controller.potExhaust,
        onChanged: (value) {
          if (controller.prePost == 2) {
            controller.checkboxes('potExhaust', value!);
          }
          //controller.updateCheck(value!, 'fallPotencial');
        },
        checkColor: Colors.white,
        activeColor: Colors.black,
      ),
    );
  }

  _rrExhaust() {
    return SizedBox(
      width: 25,
      height: 25,
      child: Checkbox(
        value: controller.rrExhaust,
        onChanged: (value) {
          controller.checkboxes('rrExhaust', value!);

          //controller.updateCheck(value!, 'fallPotencial');
        },
        checkColor: Colors.white,
        activeColor: Colors.black,
      ),
    );
  }

  _prtFifthWeel() {
    return SizedBox(
      width: 25,
      height: 25,
      child: Checkbox(
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        value: controller.prtFifthWeel,
        onChanged: (value) {
          if (controller.prePost == 1) {
            controller.checkboxes('ptrFifthWeel', value!);
          }
          //controller.updateCheck(value!, 'fallPotencial');
        },
        checkColor: Colors.white,
        activeColor: Colors.black,
      ),
    );
  }

  _posFifthWeel() {
    return SizedBox(
      width: 25,
      height: 25,
      child: Checkbox(
        value: controller.potFifthWeel,
        onChanged: (value) {
          if (controller.prePost == 2) {
            controller.checkboxes('potFifthWeel', value!);
          }
          //controller.updateCheck(value!, 'fallPotencial');
        },
        checkColor: Colors.white,
        activeColor: Colors.black,
      ),
    );
  }

  _rrFifthWeel() {
    return SizedBox(
      width: 25,
      height: 25,
      child: Checkbox(
        value: controller.rrFifthWeel,
        onChanged: (value) {
          controller.checkboxes('rrFifthWeel', value!);

          //controller.updateCheck(value!, 'fallPotencial');
        },
        checkColor: Colors.white,
        activeColor: Colors.black,
      ),
    );
  }

  _prtFluidLevels() {
    return SizedBox(
      width: 25,
      height: 25,
      child: Checkbox(
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        value: controller.prtFluidLevels,
        onChanged: (value) {
          if (controller.prePost == 1) {
            controller.checkboxes('ptrFluidLevels', value!);
          }
          //controller.updateCheck(value!, 'fallPotencial');
        },
        checkColor: Colors.white,
        activeColor: Colors.black,
      ),
    );
  }

  _posFluidLevels() {
    return SizedBox(
      width: 25,
      height: 25,
      child: Checkbox(
        value: controller.potFluidLevels,
        onChanged: (value) {
          if (controller.prePost == 2) {
            controller.checkboxes('potFluidLevels', value!);
          }
          //controller.updateCheck(value!, 'fallPotencial');
        },
        checkColor: Colors.white,
        activeColor: Colors.black,
      ),
    );
  }

  _rrFluidLevels() {
    return SizedBox(
      width: 25,
      height: 25,
      child: Checkbox(
        value: controller.rrFluidLevels,
        onChanged: (value) {
          controller.checkboxes('rrFluidLevels', value!);

          //controller.updateCheck(value!, 'fallPotencial');
        },
        checkColor: Colors.white,
        activeColor: Colors.black,
      ),
    );
  }

  _prtFrameAndAssembly() {
    return SizedBox(
      width: 25,
      height: 25,
      child: Checkbox(
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        value: controller.prtFrameAndAssembly,
        onChanged: (value) {
          if (controller.prePost == 1) {
            controller.checkboxes('ptrFrameAndAssembly', value!);
          }
          //controller.updateCheck(value!, 'fallPotencial');
        },
        checkColor: Colors.white,
        activeColor: Colors.black,
      ),
    );
  }

  _posFrameAndAssembly() {
    return SizedBox(
      width: 25,
      height: 25,
      child: Checkbox(
        value: controller.potFrameAndAssembly,
        onChanged: (value) {
          if (controller.prePost == 2) {
            controller.checkboxes('potFrameAndAssembly', value!);
          }
          //controller.updateCheck(value!, 'fallPotencial');
        },
        checkColor: Colors.white,
        activeColor: Colors.black,
      ),
    );
  }

  _rrFrameAndAssembly() {
    return SizedBox(
      width: 25,
      height: 25,
      child: Checkbox(
        value: controller.rrFrameAndAssembly,
        onChanged: (value) {
          controller.checkboxes('rrFrameAndAssembly', value!);

          //controller.updateCheck(value!, 'fallPotencial');
        },
        checkColor: Colors.white,
        activeColor: Colors.black,
      ),
    );
  }

  _prtFrontAxle() {
    return SizedBox(
      width: 25,
      height: 25,
      child: Checkbox(
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        value: controller.prtFrontAxle,
        onChanged: (value) {
          if (controller.prePost == 1) {
            controller.checkboxes('ptrFrontAxle', value!);
          }
          //controller.updateCheck(value!, 'fallPotencial');
        },
        checkColor: Colors.white,
        activeColor: Colors.black,
      ),
    );
  }

  _posFrontAxle() {
    return SizedBox(
      width: 25,
      height: 25,
      child: Checkbox(
        value: controller.potFrontAxle,
        onChanged: (value) {
          //controller.updateCheck(value!, 'fallPotencial'); ptrFrontAxle
          if (controller.prePost == 2) {
            controller.checkboxes('potFrontAxle', value!);
          }
        },
        checkColor: Colors.white,
        activeColor: Colors.black,
      ),
    );
  }

  _rrFrontAxle() {
    return SizedBox(
      width: 25,
      height: 25,
      child: Checkbox(
        value: controller.rrFrontAxle,
        onChanged: (value) {
          controller.checkboxes('rrFrontAxle', value!);

          //controller.updateCheck(value!, 'fallPotencial');
        },
        checkColor: Colors.white,
        activeColor: Colors.black,
      ),
    );
  }

  _prtFuelTanks() {
    return SizedBox(
      width: 25,
      height: 25,
      child: Checkbox(
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        value: controller.prtFuelTanks,
        onChanged: (value) {
          if (controller.prePost == 1) {
            controller.checkboxes('ptrFuelTanks', value!);
          }

          //controller.updateCheck(value!, 'fallPotencial');
        },
        checkColor: Colors.white,
        activeColor: Colors.black,
      ),
    );
  }

  _posFuelTanks() {
    return SizedBox(
      width: 25,
      height: 25,
      child: Checkbox(
        value: controller.potFlueTanks,
        onChanged: (value) {
          if (controller.prePost == 2) {
            controller.checkboxes('potFuelTanks', value!);
          }
          //controller.updateCheck(value!, 'fallPotencial');
        },
        checkColor: Colors.white,
        activeColor: Colors.black,
      ),
    );
  }

  _rrFuelTanks() {
    return SizedBox(
      width: 25,
      height: 25,
      child: Checkbox(
        value: controller.rrFlueTanks,
        onChanged: (value) {
          controller.checkboxes('rrFuelTanks', value!);

          //controller.updateCheck(value!, 'fallPotencial'); ptrFuelTanks
        },
        checkColor: Colors.white,
        activeColor: Colors.black,
      ),
    );
  }

  _prtGenerator() {
    return SizedBox(
      width: 25,
      height: 25,
      child: Checkbox(
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        value: controller.prtGenerator,
        onChanged: (value) {
          if (controller.prePost == 1) {
            controller.checkboxes('ptrGenerator', value!);
          }
          //controller.updateCheck(value!, 'fallPotencial');
        },
        checkColor: Colors.white,
        activeColor: Colors.black,
      ),
    );
  }

  _posGenerator() {
    return SizedBox(
      width: 25,
      height: 25,
      child: Checkbox(
        value: controller.potGenerator,
        onChanged: (value) {
          if (controller.prePost == 2) {
            controller.checkboxes('potGenerator', value!);
          }
          //controller.updateCheck(value!, 'fallPotencial');
        },
        checkColor: Colors.white,
        activeColor: Colors.black,
      ),
    );
  }

  _rrGenerator() {
    return SizedBox(
      width: 25,
      height: 25,
      child: Checkbox(
        value: controller.rrGenerator,
        onChanged: (value) {
          controller.checkboxes('rrGenerator', value!);

          //controller.updateCheck(value!, 'fallPotencial');
        },
        checkColor: Colors.white,
        activeColor: Colors.black,
      ),
    );
  }

  _prtHorn() {
    return SizedBox(
      width: 25,
      height: 25,
      child: Checkbox(
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        value: controller.prtHorn,
        onChanged: (value) {
          if (controller.prePost == 1) {
            controller.checkboxes('ptrHorn', value!);
          }
          //controller.updateCheck(value!, 'fallPotencial');
        },
        checkColor: Colors.white,
        activeColor: Colors.black,
      ),
    );
  }

  _posHorn() {
    return SizedBox(
      width: 25,
      height: 25,
      child: Checkbox(
        value: controller.potHorn,
        onChanged: (value) {
          if (controller.prePost == 2) {
            controller.checkboxes('potHorn', value!);
          }
          //controller.updateCheck(value!, 'fallPotencial');
        },
        checkColor: Colors.white,
        activeColor: Colors.black,
      ),
    );
  }

  _rrHorn() {
    return SizedBox(
      width: 25,
      height: 25,
      child: Checkbox(
        value: controller.rrHorn,
        onChanged: (value) {
          controller.checkboxes('rrHorn', value!);

          //controller.updateCheck(value!, 'fallPotencial');
        },
        checkColor: Colors.white,
        activeColor: Colors.black,
      ),
    );
  }

  _prtLights() {
    return SizedBox(
      width: 25,
      height: 25,
      child: Checkbox(
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        value: controller.prtLights,
        onChanged: (value) {
          if (controller.prePost == 1) {
            controller.checkboxes('ptrLights', value!);
          }
          //controller.updateCheck(value!, 'fallPotencial');
        },
        checkColor: Colors.white,
        activeColor: Colors.black,
      ),
    );
  }

  _posLights() {
    return SizedBox(
      width: 25,
      height: 25,
      child: Checkbox(
        value: controller.potLights,
        onChanged: (value) {
          if (controller.prePost == 2) {
            controller.checkboxes('potLights', value!);
          }
          //controller.updateCheck(value!, 'fallPotencial');
        },
        checkColor: Colors.white,
        activeColor: Colors.black,
      ),
    );
  }

  _rrLights() {
    return SizedBox(
      width: 25,
      height: 25,
      child: Checkbox(
        value: controller.rrLights,
        onChanged: (value) {
          controller.checkboxes('rrLights', value!);

          //controller.updateCheck(value!, 'fallPotencial');
        },
        checkColor: Colors.white,
        activeColor: Colors.black,
      ),
    );
  }

  _prtMirrors() {
    return SizedBox(
      width: 25,
      height: 25,
      child: Checkbox(
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        value: controller.prtMirros,
        onChanged: (value) {
          if (controller.prePost == 1) {
            controller.checkboxes('ptrMirrors', value!);
          }
          //controller.updateCheck(value!, 'fallPotencial');
        },
        checkColor: Colors.white,
        activeColor: Colors.black,
      ),
    );
  }

  _posMirrors() {
    return SizedBox(
      width: 25,
      height: 25,
      child: Checkbox(
        value: controller.potMirros,
        onChanged: (value) {
          if (controller.prePost == 2) {
            controller.checkboxes('potMirrors', value!);
          }
          //controller.updateCheck(value!, 'fallPotencial');
        },
        checkColor: Colors.white,
        activeColor: Colors.black,
      ),
    );
  }

  _rrMirrors() {
    return SizedBox(
      width: 25,
      height: 25,
      child: Checkbox(
        value: controller.rrMirros,
        onChanged: (value) {
          controller.checkboxes('rrMirrors', value!);

          //controller.updateCheck(value!, 'fallPotencial');
        },
        checkColor: Colors.white,
        activeColor: Colors.black,
      ),
    );
  }

  _prtMuffler() {
    return SizedBox(
      width: 25,
      height: 25,
      child: Checkbox(
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        value: controller.prtMuffler,
        onChanged: (value) {
          if (controller.prePost == 1) {
            controller.checkboxes('ptrMuffler', value!);
          }
          //controller.updateCheck(value!, 'fallPotencial');
        },
        checkColor: Colors.white,
        activeColor: Colors.black,
      ),
    );
  }

  _posMuffler() {
    return SizedBox(
      width: 25,
      height: 25,
      child: Checkbox(
        value: controller.potMuffler,
        onChanged: (value) {
          if (controller.prePost == 2) {
            controller.checkboxes('potMuffler', value!);
          }
          //controller.updateCheck(value!, 'fallPotencial');
        },
        checkColor: Colors.white,
        activeColor: Colors.black,
      ),
    );
  }

  _rrMuffler() {
    return SizedBox(
      width: 25,
      height: 25,
      child: Checkbox(
        value: controller.rrMuffler,
        onChanged: (value) {
          controller.checkboxes('rrMuffler', value!);

          //controller.updateCheck(value!, 'fallPotencial');
        },
        checkColor: Colors.white,
        activeColor: Colors.black,
      ),
    );
  }

  _prtOilLevel() {
    return SizedBox(
      width: 25,
      height: 25,
      child: Checkbox(
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        value: controller.prtOilLevel,
        onChanged: (value) {
          //controller.updateCheck(value!, 'fallPotencial');
          if (controller.prePost == 1) {
            controller.checkboxes('ptrOilLevel', value!);
          }
        },
        checkColor: Colors.white,
        activeColor: Colors.black,
      ),
    );
  }

  _posOilLevel() {
    return SizedBox(
      width: 25,
      height: 25,
      child: Checkbox(
        value: controller.potOilLevel,
        onChanged: (value) {
          if (controller.prePost == 2) {
            controller.checkboxes('potOilLevel', value!);
          }
          //controller.updateCheck(value!, 'fallPotencial');
        },
        checkColor: Colors.white,
        activeColor: Colors.black,
      ),
    );
  }

  _rrOilLevel() {
    return SizedBox(
      width: 25,
      height: 25,
      child: Checkbox(
        value: controller.rrOilLevel,
        onChanged: (value) {
          controller.checkboxes('rrOilLevel', value!);

          //controller.updateCheck(value!, 'fallPotencial');
        },
        checkColor: Colors.white,
        activeColor: Colors.black,
      ),
    );
  }

  _prtRadiatorLevel() {
    return SizedBox(
      width: 25,
      height: 25,
      child: Checkbox(
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        value: controller.prtRadiatorLeverl,
        onChanged: (value) {
          //controller.updateCheck(value!, 'fallPotencial');
          if (controller.prePost == 1) {
            controller.checkboxes('ptrRadiatorLevel', value!);
          }
        },
        checkColor: Colors.white,
        activeColor: Colors.black,
      ),
    );
  }

  _posRadiatorLevel() {
    return SizedBox(
      width: 25,
      height: 25,
      child: Checkbox(
        value: controller.potRadiatorLeverl,
        onChanged: (value) {
          if (controller.prePost == 2) {
            controller.checkboxes('potRadiatorLevel', value!);
          }
          //controller.updateCheck(value!, 'fallPotencial');
        },
        checkColor: Colors.white,
        activeColor: Colors.black,
      ),
    );
  }

  _rrRadiatorLevel() {
    return SizedBox(
      width: 25,
      height: 25,
      child: Checkbox(
        value: controller.rrRadiatorLeverl,
        onChanged: (value) {
          controller.checkboxes('rrRadiatorLevel', value!);

          //controller.updateCheck(value!, 'fallPotencial');
        },
        checkColor: Colors.white,
        activeColor: Colors.black,
      ),
    );
  }

  _prtRearEnd() {
    return SizedBox(
      width: 25,
      height: 25,
      child: Checkbox(
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        value: controller.prtRearEnd,
        onChanged: (value) {
          if (controller.prePost == 1) {
            controller.checkboxes('ptrRearEnd', value!);
          }
          //controller.updateCheck(value!, 'fallPotencial');
        },
        checkColor: Colors.white,
        activeColor: Colors.black,
      ),
    );
  }

  _posRearEnd() {
    return SizedBox(
      width: 25,
      height: 25,
      child: Checkbox(
        value: controller.potRearEnd,
        onChanged: (value) {
          if (controller.prePost == 2) {
            controller.checkboxes('potRearEnd', value!);
          }
          //controller.updateCheck(value!, 'fallPotencial');
        },
        checkColor: Colors.white,
        activeColor: Colors.black,
      ),
    );
  }

  _rrRearEnd() {
    return SizedBox(
      width: 25,
      height: 25,
      child: Checkbox(
        value: controller.rrRearEnd,
        onChanged: (value) {
          controller.checkboxes('rrRearEnd', value!);

          //controller.updateCheck(value!, 'fallPotencial');
        },
        checkColor: Colors.white,
        activeColor: Colors.black,
      ),
    );
  }

  _prtReflectors() {
    return SizedBox(
      width: 25,
      height: 25,
      child: Checkbox(
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        value: controller.prtReflectors,
        onChanged: (value) {
          if (controller.prePost == 1) {
            controller.checkboxes('ptrReflectors', value!);
          }
          //controller.updateCheck(value!, 'fallPotencial');
        },
        checkColor: Colors.white,
        activeColor: Colors.black,
      ),
    );
  }

  _posReflectors() {
    return SizedBox(
      width: 25,
      height: 25,
      child: Checkbox(
        value: controller.potReflectors,
        onChanged: (value) {
          if (controller.prePost == 2) {
            controller.checkboxes('potReflectors', value!);
          }
          //controller.updateCheck(value!, 'fallPotencial');
        },
        checkColor: Colors.white,
        activeColor: Colors.black,
      ),
    );
  }

  _rrReflectors() {
    return SizedBox(
      width: 25,
      height: 25,
      child: Checkbox(
        value: controller.rrReflectors,
        onChanged: (value) {
          controller.checkboxes('rrReflectors', value!);

          //controller.updateCheck(value!, 'fallPotencial');
        },
        checkColor: Colors.white,
        activeColor: Colors.black,
      ),
    );
  }

  _prtSafetyEquipment() {
    return SizedBox(
      width: 25,
      height: 25,
      child: Checkbox(
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        value: controller.prtSafetyEquipment,
        onChanged: (value) {
          if (controller.prePost == 1) {
            controller.checkboxes('ptrSafetyEquipment', value!);
          }
          //controller.updateCheck(value!, 'fallPotencial');
        },
        checkColor: Colors.white,
        activeColor: Colors.black,
      ),
    );
  }

  _posSafetyEquipment() {
    return SizedBox(
      width: 25,
      height: 25,
      child: Checkbox(
        value: controller.potSafetyEquipment,
        onChanged: (value) {
          if (controller.prePost == 2) {
            controller.checkboxes('potSafetyEquipment', value!);
          }
          //controller.updateCheck(value!, 'fallPotencial');
        },
        checkColor: Colors.white,
        activeColor: Colors.black,
      ),
    );
  }

  _rrSafetyEquipment() {
    return SizedBox(
      width: 25,
      height: 25,
      child: Checkbox(
        value: controller.rrSafetyEquipment,
        onChanged: (value) {
          controller.checkboxes('rrSafetyEquipment', value!);

          //controller.updateCheck(value!, 'fallPotencial');
        },
        checkColor: Colors.white,
        activeColor: Colors.black,
      ),
    );
  }

  _prtStarter() {
    return SizedBox(
      width: 25,
      height: 25,
      child: Checkbox(
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        value: controller.prtStarter,
        onChanged: (value) {
          if (controller.prePost == 1) {
            controller.checkboxes('ptrStarter', value!);
          }
          //controller.updateCheck(value!, 'fallPotencial');
        },
        checkColor: Colors.white,
        activeColor: Colors.black,
      ),
    );
  }

  _posStarter() {
    return SizedBox(
      width: 25,
      height: 25,
      child: Checkbox(
        value: controller.potStarter,
        onChanged: (value) {
          if (controller.prePost == 2) {
            controller.checkboxes('potStarter', value!);
          }
          //controller.updateCheck(value!, 'fallPotencial');
        },
        checkColor: Colors.white,
        activeColor: Colors.black,
      ),
    );
  }

  _rrStarter() {
    return SizedBox(
      width: 25,
      height: 25,
      child: Checkbox(
        value: controller.rrStarter,
        onChanged: (value) {
          controller.checkboxes('rrStarter', value!);

          //controller.updateCheck(value!, 'fallPotencial');
        },
        checkColor: Colors.white,
        activeColor: Colors.black,
      ),
    );
  }

  _prtSteering() {
    return SizedBox(
      width: 25,
      height: 25,
      child: Checkbox(
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        value: controller.prtSteering,
        onChanged: (value) {
          if (controller.prePost == 1) {
            controller.checkboxes('ptrSteering', value!);
          }
          //controller.updateCheck(value!, 'fallPotencial');
        },
        checkColor: Colors.white,
        activeColor: Colors.black,
      ),
    );
  }

  _posSteering() {
    return SizedBox(
      width: 25,
      height: 25,
      child: Checkbox(
        value: controller.potSteering,
        onChanged: (value) {
          if (controller.prePost == 2) {
            controller.checkboxes('potSteering', value!);
          }
          //controller.updateCheck(value!, 'fallPotencial');
        },
        checkColor: Colors.white,
        activeColor: Colors.black,
      ),
    );
  }

  _rrSteering() {
    return SizedBox(
      width: 25,
      height: 25,
      child: Checkbox(
        value: controller.rrSteering,
        onChanged: (value) {
          controller.checkboxes('rrSteering', value!);

          //controller.updateCheck(value!, 'fallPotencial');
        },
        checkColor: Colors.white,
        activeColor: Colors.black,
      ),
    );
  }

  _prtSuspensionSystem() {
    return SizedBox(
      width: 25,
      height: 25,
      child: Checkbox(
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        value: controller.prtSuspensionSystem,
        onChanged: (value) {
          if (controller.prePost == 1) {
            controller.checkboxes('ptrSuspensionSystem', value!);
          }
          //controller.updateCheck(value!, 'fallPotencial');
        },
        checkColor: Colors.white,
        activeColor: Colors.black,
      ),
    );
  }

  _posSuspensionSystem() {
    return SizedBox(
      width: 25,
      height: 25,
      child: Checkbox(
        value: controller.potSuspensionSystem,
        onChanged: (value) {
          if (controller.prePost == 2) {
            controller.checkboxes('potSuspensionSystem', value!);
          }
          //controller.updateCheck(value!, 'fallPotencial');
        },
        checkColor: Colors.white,
        activeColor: Colors.black,
      ),
    );
  }

  _rrSuspensionSystem() {
    return SizedBox(
      width: 25,
      height: 25,
      child: Checkbox(
        value: controller.rrSuspensionSystem,
        onChanged: (value) {
          controller.checkboxes('rrSuspensionSystem', value!);

          //controller.updateCheck(value!, 'fallPotencial');
        },
        checkColor: Colors.white,
        activeColor: Colors.black,
      ),
    );
  }

  _prtTires() {
    return SizedBox(
      width: 25,
      height: 25,
      child: Checkbox(
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        value: controller.prtTires,
        onChanged: (value) {
          if (controller.prePost == 1) {
            controller.checkboxes('ptrTires', value!);
          }
          //controller.updateCheck(value!, 'fallPotencial');
        },
        checkColor: Colors.white,
        activeColor: Colors.black,
      ),
    );
  }

  _posTires() {
    return SizedBox(
      width: 25,
      height: 25,
      child: Checkbox(
        value: controller.potTires,
        onChanged: (value) {
          if (controller.prePost == 2) {
            controller.checkboxes('potTires', value!);
          }
          //controller.updateCheck(value!, 'fallPotencial');
        },
        checkColor: Colors.white,
        activeColor: Colors.black,
      ),
    );
  }

  _rrTires() {
    return SizedBox(
      width: 25,
      height: 25,
      child: Checkbox(
        value: controller.rrTires,
        onChanged: (value) {
          controller.checkboxes('rrTires', value!);

          //controller.updateCheck(value!, 'fallPotencial');
        },
        checkColor: Colors.white,
        activeColor: Colors.black,
      ),
    );
  }

  _rrTireChains() {
    return SizedBox(
      width: 25,
      height: 25,
      child: Checkbox(
        value: controller.rrTireChains,
        onChanged: (value) {
          if (controller.prePost == 1) {
            controller.checkboxes('ptrTireChains', value!);
          }
          //controller.updateCheck(value!, 'fallPotencial');
        },
        checkColor: Colors.white,
        activeColor: Colors.black,
      ),
    );
  }

  _prtTireChains() {
    return SizedBox(
      width: 25,
      height: 25,
      child: Checkbox(
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        value: controller.prtTireChains,
        onChanged: (value) {
          if (controller.prePost == 2) {
            controller.checkboxes('potTireChains', value!);
          }
          //controller.updateCheck(value!, 'fallPotencial');
        },
        checkColor: Colors.white,
        activeColor: Colors.black,
      ),
    );
  }

  _posTireChains() {
    return SizedBox(
      width: 25,
      height: 25,
      child: Checkbox(
        value: controller.potTireChains,
        onChanged: (value) {
          controller.checkboxes('rrTireChains', value!);

          //controller.updateCheck(value!, 'fallPotencial');
        },
        checkColor: Colors.white,
        activeColor: Colors.black,
      ),
    );
  }

  _prtTransmission() {
    return SizedBox(
      width: 25,
      height: 25,
      child: Checkbox(
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        value: controller.prtTransmission,
        onChanged: (value) {
          if (controller.prePost == 1) {
            controller.checkboxes('ptrTransmission', value!);
          }
          //controller.updateCheck(value!, 'fallPotencial');
        },
        checkColor: Colors.white,
        activeColor: Colors.black,
      ),
    );
  }

  _posTransmission() {
    return SizedBox(
      width: 25,
      height: 25,
      child: Checkbox(
        value: controller.potTransmission,
        onChanged: (value) {
          if (controller.prePost == 2) {
            controller.checkboxes('potTransmission', value!);
          }
          //controller.updateCheck(value!, 'fallPotencial');
        },
        checkColor: Colors.white,
        activeColor: Colors.black,
      ),
    );
  }

  _rrTransmission() {
    return SizedBox(
      width: 25,
      height: 25,
      child: Checkbox(
        value: controller.rrTransmission,
        onChanged: (value) {
          controller.checkboxes('rrTransmission', value!);

          //controller.updateCheck(value!, 'fallPotencial');
        },
        checkColor: Colors.white,
        activeColor: Colors.black,
      ),
    );
  }

  _prtTripRecorder() {
    return SizedBox(
      width: 25,
      height: 25,
      child: Checkbox(
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        value: controller.prtTripRecorder,
        onChanged: (value) {
          if (controller.prePost == 1) {
            controller.checkboxes('ptrTripRecorder', value!);
          }
          //controller.updateCheck(value!, 'fallPotencial');
        },
        checkColor: Colors.white,
        activeColor: Colors.black,
      ),
    );
  }

  _posTripRecorder() {
    return SizedBox(
      width: 25,
      height: 25,
      child: Checkbox(
        value: controller.potTripRecorder,
        onChanged: (value) {
          if (controller.prePost == 2) {
            controller.checkboxes('potTripRecorder', value!);
          }
          //controller.updateCheck(value!, 'fallPotencial');
        },
        checkColor: Colors.white,
        activeColor: Colors.black,
      ),
    );
  }

  _rrTripRecorder() {
    return SizedBox(
      width: 25,
      height: 25,
      child: Checkbox(
        value: controller.rrTripRecorder,
        onChanged: (value) {
          controller.checkboxes('rrTripRecorder', value!);

          //controller.updateCheck(value!, 'fallPotencial');
        },
        checkColor: Colors.white,
        activeColor: Colors.black,
      ),
    );
  }

  _prtWheelsAndRims() {
    return SizedBox(
      width: 25,
      height: 25,
      child: Checkbox(
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        value: controller.prtWheelsAndRims,
        onChanged: (value) {
          if (controller.prePost == 1) {
            controller.checkboxes('ptrWheelsAndRims', value!);
          }
          //controller.updateCheck(value!, 'fallPotencial');
        },
        checkColor: Colors.white,
        activeColor: Colors.black,
      ),
    );
  }

  _posWheelsAndRims() {
    return SizedBox(
      width: 25,
      height: 25,
      child: Checkbox(
        value: controller.potWheelsAndRims,
        onChanged: (value) {
          if (controller.prePost == 2) {
            controller.checkboxes('potWheelsAndRims', value!);
          }
          //controller.updateCheck(value!, 'fallPotencial');
        },
        checkColor: Colors.white,
        activeColor: Colors.black,
      ),
    );
  }

  _rrWheelsAndRims() {
    return SizedBox(
      width: 25,
      height: 25,
      child: Checkbox(
        value: controller.rrWheelsAndRims,
        onChanged: (value) {
          controller.checkboxes('rrWheelsAndRims', value!);

          //controller.updateCheck(value!, 'fallPotencial');
        },
        checkColor: Colors.white,
        activeColor: Colors.black,
      ),
    );
  }

  _prtWindows() {
    return SizedBox(
      width: 25,
      height: 25,
      child: Checkbox(
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        value: controller.prtWindows,
        onChanged: (value) {
          if (controller.prePost == 1) {
            controller.checkboxes('ptrWindows', value!);
          }
          //controller.updateCheck(value!, 'fallPotencial');
        },
        checkColor: Colors.white,
        activeColor: Colors.black,
      ),
    );
  }

  _posWindows() {
    return SizedBox(
      width: 25,
      height: 25,
      child: Checkbox(
        value: controller.potWindows,
        onChanged: (value) {
          if (controller.prePost == 2) {
            controller.checkboxes('potWindows', value!);
          }
          //controller.updateCheck(value!, 'fallPotencial');
        },
        checkColor: Colors.white,
        activeColor: Colors.black,
      ),
    );
  }

  _rrWindows() {
    return SizedBox(
      width: 25,
      height: 25,
      child: Checkbox(
        value: controller.rrWindows,
        onChanged: (value) {
          controller.checkboxes('rrWindows', value!);

          //controller.updateCheck(value!, 'fallPotencial');
        },
        checkColor: Colors.white,
        activeColor: Colors.black,
      ),
    );
  }

  _prtWindshieldWipers() {
    return SizedBox(
      width: 25,
      height: 25,
      child: Checkbox(
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        value: controller.prtWindshieldWipers,
        onChanged: (value) {
          if (controller.prePost == 1) {
            controller.checkboxes('ptrWindshieldWipers', value!);
          }
          //controller.updateCheck(value!, 'fallPotencial');
        },
        checkColor: Colors.white,
        activeColor: Colors.black,
      ),
    );
  }

  _posWindshieldWipers() {
    return SizedBox(
      width: 25,
      height: 25,
      child: Checkbox(
        value: controller.potWindshieldWipers,
        onChanged: (value) {
          if (controller.prePost == 2) {
            controller.checkboxes('potWindshieldWipers', value!);
          }
          //controller.updateCheck(value!, 'fallPotencial');
        },
        checkColor: Colors.white,
        activeColor: Colors.black,
      ),
    );
  }

  _rrWindshieldWipers() {
    return SizedBox(
      width: 25,
      height: 25,
      child: Checkbox(
        value: controller.rrWindshieldWipers,
        onChanged: (value) {
          controller.checkboxes('rrWindshieldWipers', value!);

          //controller.updateCheck(value!, 'fallPotencial');
        },
        checkColor: Colors.white,
        activeColor: Colors.black,
      ),
    );
  }

  _prtOther() {
    return SizedBox(
      width: 25,
      height: 25,
      child: Checkbox(
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        value: controller.prtOther,
        onChanged: (value) {
          if (controller.prePost == 1) {
            controller.checkboxes('ptrOther', value!);
          }
          //controller.updateCheck(value!, 'fallPotencial');
        },
        checkColor: Colors.white,
        activeColor: Colors.black,
      ),
    );
  }

  _posOther() {
    return SizedBox(
      width: 25,
      height: 25,
      child: Checkbox(
        value: controller.potOther,
        onChanged: (value) {
          if (controller.prePost == 2) {
            controller.checkboxes('potOther', value!);
          }
          //controller.updateCheck(value!, 'fallPotencial');
        },
        checkColor: Colors.white,
        activeColor: Colors.black,
      ),
    );
  }

  _rrOther() {
    return SizedBox(
      width: 25,
      height: 25,
      child: Checkbox(
        value: controller.rrOther,
        onChanged: (value) {
          controller.checkboxes('rrOther', value!);

          //controller.updateCheck(value!, 'fallPotencial');
        },
        checkColor: Colors.white,
        activeColor: Colors.black,
      ),
    );
  }
}
