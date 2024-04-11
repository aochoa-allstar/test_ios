import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:onax_app/src/controllers/inspectionsController.dart';
import 'package:onax_app/src/controllers/jsasSteperFormController.dart';
import 'package:onax_app/src/utils/styles/inputStyles.dart';
import 'package:onax_app/src/utils/styles/themWhite.dart';

import 'dropDownEquipment.dart';

class TrailersSteper extends StatelessWidget {
  final InspectionController controller;
  TrailersSteper({Key? key, required this.controller}) : super(key: key);
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
          Container(
            height: h * 0.055,
            width: w * 0.7,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
            ),
            child: PhysicalModel(
              color: Colors.white,
              elevation: 2,
              borderRadius: BorderRadius.circular(15),
              child: CustomeDropDownEquipment(
                type: 'trailer1',
                controller: controller,
                hint: 'new_inspection_pretrip_trailers_hint1'.tr,
                listItems: controller.listTrailers, // listTriler
                validator: 'new_inspection_pretrip_trailers_validator1'.tr,
                typeSelect: 0,
              ),
            ),
          ),
          SizedBox(height: h * 0.02),
          Container(
            height: h * 0.055,
            width: w * 0.7,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
            ),
            child: PhysicalModel(
              color: Colors.white,
              elevation: 2,
              borderRadius: BorderRadius.circular(15),
              child: CustomeDropDownEquipment(
                type: 'trailer2',
                controller: controller,
                hint: 'new_inspection_pretrip_trailers_hint2'.tr,
                listItems: controller.listTrailers, //listTrailer
                validator: 'new_inspection_pretrip_trailers_validator2'.tr,
                typeSelect: 0,
              ),
            ),
          ),
          // Container(
          //   decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
          //   height: h * 0.055,
          //   width: w * 0.65,
          //   child: PhysicalModel(
          //     color: Colors.white,
          //     elevation: 2,
          //     borderRadius: BorderRadius.circular(10),
          //     child: TextFormField(
          //       controller: controller.trailer1Txt,
          //       style: ThemeWhite().labelHomeTitles(Colors.black),
          //       onChanged: (value) {
          //         if (controller.trailer1Txt.text.isEmpty) {
          //           FocusManager.instance.primaryFocus?.unfocus();
          //         }
          //       },
          //       inputFormatters: [
          //         LengthLimitingTextInputFormatter(255),
          //       ],
          //       keyboardType: TextInputType.text,
          //       autofocus: false,
          //       decoration:
          //           StyleInput().inputTextSyle('Trailer No.1', Colors.white),
          //     ),
          //   ),
          // ),
          // SizedBox(height: h * 0.02),
          // Container(
          //   decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
          //   height: h * 0.055,
          //   width: w * 0.65,
          //   child: PhysicalModel(
          //     color: Colors.white,
          //     elevation: 2,
          //     borderRadius: BorderRadius.circular(10),
          //     child: TextFormField(
          //       controller: controller.trailer2Txt,
          //       style: ThemeWhite().labelHomeTitles(Colors.black),
          //       onChanged: (value) {
          //         if (controller.trailer2Txt.text.isEmpty) {
          //           FocusManager.instance.primaryFocus?.unfocus();
          //         }
          //       },
          //       inputFormatters: [
          //         LengthLimitingTextInputFormatter(255),
          //       ],
          //       keyboardType: TextInputType.text,
          //       autofocus: false,
          //       decoration:
          //           StyleInput().inputTextSyle('Trailer No.2', Colors.white),
          //     ),
          //   ),
          // ),
          //Checkbox
          SizedBox(height: h * 0.02),
          SizedBox(
            //color: Colors.red,
            width: w,
            child: Row(
              children: [
                _prtBrakeConnections(),
                SizedBox(
                  width: w * 0.04,
                ),
                _posBrakeConnections(),
                SizedBox(
                  width: w * 0.04,
                ),
                _rrBrakeConnections(),
                SizedBox(
                  width: w * 0.02,
                ),
                Text('new_inspection_pretrip_trailers_brake'.tr,
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
                _prtBrakes(),
                SizedBox(
                  width: w * 0.04,
                ),
                _posBrakes(),
                SizedBox(
                  width: w * 0.04,
                ),
                _rrBrakes(),
                SizedBox(
                  width: w * 0.02,
                ),
                Text('new_inspection_pretrip_trailers_brakes'.tr, style: ThemeWhite().labelCheckbox(Colors.black)),
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
                Text('new_inspection_pretrip_trailers_coupling'.tr,
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
                _prtCouplingKingPin(),
                SizedBox(
                  width: w * 0.04,
                ),
                _posCouplingKingPin(),
                SizedBox(
                  width: w * 0.04,
                ),
                _rrCouplingKingPin(),
                SizedBox(
                  width: w * 0.02,
                ),
                Text('new_inspection_pretrip_trailers_coupling_king'.tr,
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
                _prtDoors(),
                SizedBox(
                  width: w * 0.04,
                ),
                _posDoors(),
                SizedBox(
                  width: w * 0.04,
                ),
                _rrDoors(),
                SizedBox(
                  width: w * 0.02,
                ),
                Text('new_inspection_pretrip_trailers_doors'.tr, style: ThemeWhite().labelCheckbox(Colors.black)),
              ],
            ),
          ),
          SizedBox(height: h * 0.02),
          SizedBox(
            //color: Colors.red,
            width: w,
            child: Row(
              children: [
                _prtHitch(),
                SizedBox(
                  width: w * 0.04,
                ),
                _posHitch(),
                SizedBox(
                  width: w * 0.04,
                ),
                _rrHitch(),
                SizedBox(
                  width: w * 0.02,
                ),
                Text('new_inspection_pretrip_trailers_hitch'.tr, style: ThemeWhite().labelCheckbox(Colors.black)),
              ],
            ),
          ),
          SizedBox(height: h * 0.02),
          SizedBox(
            //color: Colors.red,
            width: w,
            child: Row(
              children: [
                _prtLandingGear(),
                SizedBox(
                  width: w * 0.04,
                ),
                _posLandingGear(),
                SizedBox(
                  width: w * 0.04,
                ),
                _rrLandingGear(),
                SizedBox(
                  width: w * 0.02,
                ),
                Text('new_inspection_pretrip_trailers_landing'.tr,
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
                _prtLightsAll(),
                SizedBox(
                  width: w * 0.04,
                ),
                _posLightsAll(),
                SizedBox(
                  width: w * 0.04,
                ),
                _rrLightsAll(),
                SizedBox(
                  width: w * 0.02,
                ),
                Text('new_inspection_pretrip_trailers_lights'.tr,
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
                Text('new_inspection_pretrip_trailers_reflectors'.tr,
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
                _prtRoof(),
                SizedBox(
                  width: w * 0.04,
                ),
                _posRoof(),
                SizedBox(
                  width: w * 0.04,
                ),
                _rrRoof(),
                SizedBox(
                  width: w * 0.02,
                ),
                Text('new_inspection_pretrip_trailers_roof'.tr, style: ThemeWhite().labelCheckbox(Colors.black)),
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
                Text('new_inspection_pretrip_trailers_suspension'.tr,
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
                _prtStraps(),
                SizedBox(
                  width: w * 0.04,
                ),
                _posStraps(),
                SizedBox(
                  width: w * 0.04,
                ),
                _rrStraps(),
                SizedBox(
                  width: w * 0.02,
                ),
                Text('new_inspection_pretrip_trailers_straps'.tr, style: ThemeWhite().labelCheckbox(Colors.black)),
              ],
            ),
          ),

          SizedBox(height: h * 0.02),
          SizedBox(
            //color: Colors.red,
            width: w,
            child: Row(
              children: [
                _prtTarpaulin(),
                SizedBox(
                  width: w * 0.04,
                ),
                _posTarpaulin(),
                SizedBox(
                  width: w * 0.04,
                ),
                _rrTarpaulin(),
                SizedBox(
                  width: w * 0.02,
                ),
                Text('new_inspection_pretrip_trailers_tarpaulin'.tr,
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
                Text('new_inspection_pretrip_trailers_tires'.tr, style: ThemeWhite().labelCheckbox(Colors.black)),
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
                Text('new_inspection_pretrip_trailers_wheels'.tr,
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
          //
          SizedBox(height: h * 0.01),
        ],
      ),
    );
  }

  _prtBrakeConnections() {
    return SizedBox(
      width: 25,
      height: 25,
      child: Checkbox(
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        value: controller.prtTBrakeConnections,
        onChanged: (value) {
          if (controller.prePost == 1) {
            controller.checkboxes('ptrTBrakeConnections', value!);
          }
          //controller.updateCheck(value!, 'fallPotencial');
        },
        checkColor: Colors.white,
        activeColor: Colors.black,
      ),
    );
  }

  _posBrakeConnections() {
    return SizedBox(
      width: 25,
      height: 25,
      child: Checkbox(
        value: controller.potTBrakeConnections,
        onChanged: (value) {
          if (controller.prePost == 2) {
            controller.checkboxes('potTBrakeConnections', value!);
          }
          //controller.updateCheck(value!, 'fallPotencial');
        },
        checkColor: Colors.white,
        activeColor: Colors.black,
      ),
    );
  }

  _rrBrakeConnections() {
    return SizedBox(
      width: 25,
      height: 25,
      child: Checkbox(
        value: controller.rrTBrakeConnections,
        onChanged: (value) {
          controller.checkboxes('rrTBrakeConnections', value!);

          //controller.updateCheck(value!, 'fallPotencial');
        },
        checkColor: Colors.white,
        activeColor: Colors.black,
      ),
    );
  }

  _prtBrakes() {
    return SizedBox(
      width: 25,
      height: 25,
      child: Checkbox(
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        value: controller.prtTBrakes,
        onChanged: (value) {
          if (controller.prePost == 1) {
            controller.checkboxes('ptrTBrakes', value!);
          }
          //controller.updateCheck(value!, 'fallPotencial');
        },
        checkColor: Colors.white,
        activeColor: Colors.black,
      ),
    );
  }

  _posBrakes() {
    return SizedBox(
      width: 25,
      height: 25,
      child: Checkbox(
        value: controller.potTBrakes,
        onChanged: (value) {
          if (controller.prePost == 2) {
            controller.checkboxes('potTBrakes', value!);
          }
          //controller.updateCheck(value!, 'fallPotencial');
        },
        checkColor: Colors.white,
        activeColor: Colors.black,
      ),
    );
  }

  _rrBrakes() {
    return SizedBox(
      width: 25,
      height: 25,
      child: Checkbox(
        value: controller.rrTBrakes,
        onChanged: (value) {
          controller.checkboxes('rrTBrakes', value!);

          //controller.updateCheck(value!, 'fallPotencial');
        },
        checkColor: Colors.white,
        activeColor: Colors.black,
      ),
    );
  }

  _prtCouplingDevices() {
    return SizedBox(
      width: 25,
      height: 25,
      child: Checkbox(
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        value: controller.prtTCouplingDevice,
        onChanged: (value) {
          if (controller.prePost == 1) {
            controller.checkboxes('ptrTCouplingDevice', value!);
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
        value: controller.potTCouplingDevice,
        onChanged: (value) {
          if (controller.prePost == 2) {
            controller.checkboxes('potTCouplingDevice', value!);
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
        value: controller.rrTCouplingDevice,
        onChanged: (value) {
          controller.checkboxes('rrTCouplingDevice', value!);

          //controller.updateCheck(value!, 'fallPotencial');
        },
        checkColor: Colors.white,
        activeColor: Colors.black,
      ),
    );
  }

  _prtCouplingKingPin() {
    return SizedBox(
      width: 25,
      height: 25,
      child: Checkbox(
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        value: controller.prtTCouplingKingPin,
        onChanged: (value) {
          if (controller.prePost == 1) {
            controller.checkboxes('ptrTCouplingKingPin', value!);
          }
          //controller.updateCheck(value!, 'fallPotencial');
        },
        checkColor: Colors.white,
        activeColor: Colors.black,
      ),
    );
  }

  _posCouplingKingPin() {
    return SizedBox(
      width: 25,
      height: 25,
      child: Checkbox(
        value: controller.potTCouplingKingPin,
        onChanged: (value) {
          if (controller.prePost == 2) {
            controller.checkboxes('potTCouplingKingPin', value!);
          }
          //controller.updateCheck(value!, 'fallPotencial');
        },
        checkColor: Colors.white,
        activeColor: Colors.black,
      ),
    );
  }

  _rrCouplingKingPin() {
    return SizedBox(
      width: 25,
      height: 25,
      child: Checkbox(
        value: controller.rrTCouplingKingPin,
        onChanged: (value) {
          controller.checkboxes('rrTCouplingKingPin', value!);

          //controller.updateCheck(value!, 'fallPotencial');
        },
        checkColor: Colors.white,
        activeColor: Colors.black,
      ),
    );
  }

  _prtDoors() {
    return SizedBox(
      width: 25,
      height: 25,
      child: Checkbox(
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        value: controller.prtTDorrs,
        onChanged: (value) {
          if (controller.prePost == 1) {
            controller.checkboxes('ptrTDoors', value!);
          }
          //controller.updateCheck(value!, 'fallPotencial');
        },
        checkColor: Colors.white,
        activeColor: Colors.black,
      ),
    );
  }

  _posDoors() {
    return SizedBox(
      width: 25,
      height: 25,
      child: Checkbox(
        value: controller.potTDorrs,
        onChanged: (value) {
          if (controller.prePost == 2) {
            controller.checkboxes('potTDoors', value!);
          }
          //controller.updateCheck(value!, 'fallPotencial');
        },
        checkColor: Colors.white,
        activeColor: Colors.black,
      ),
    );
  }

  _rrDoors() {
    return SizedBox(
      width: 25,
      height: 25,
      child: Checkbox(
        value: controller.rrTDorrs,
        onChanged: (value) {
          controller.checkboxes('rrTDoors', value!);

          //controller.updateCheck(value!, 'fallPotencial');
        },
        checkColor: Colors.white,
        activeColor: Colors.black,
      ),
    );
  }

  _prtHitch() {
    return SizedBox(
      width: 25,
      height: 25,
      child: Checkbox(
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        value: controller.prtTHitch,
        onChanged: (value) {
          if (controller.prePost == 1) {
            controller.checkboxes('ptrTHitch', value!);
          }
          //controller.updateCheck(value!, 'fallPotencial');
        },
        checkColor: Colors.white,
        activeColor: Colors.black,
      ),
    );
  }

  _posHitch() {
    return SizedBox(
      width: 25,
      height: 25,
      child: Checkbox(
        value: controller.potTHitch,
        onChanged: (value) {
          if (controller.prePost == 2) {
            controller.checkboxes('potTHitch', value!);
          }
          //controller.updateCheck(value!, 'fallPotencial');
        },
        checkColor: Colors.white,
        activeColor: Colors.black,
      ),
    );
  }

  _rrHitch() {
    return SizedBox(
      width: 25,
      height: 25,
      child: Checkbox(
        value: controller.rrTHitch,
        onChanged: (value) {
          controller.checkboxes('rrTHitch', value!);

          //controller.updateCheck(value!, 'fallPotencial');
        },
        checkColor: Colors.white,
        activeColor: Colors.black,
      ),
    );
  }

  _prtLandingGear() {
    return SizedBox(
      width: 25,
      height: 25,
      child: Checkbox(
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        value: controller.prtTLandingGear,
        onChanged: (value) {
          if (controller.prePost == 1) {
            controller.checkboxes('ptrTLandingGear', value!);
          }
          //controller.updateCheck(value!, 'fallPotencial');
        },
        checkColor: Colors.white,
        activeColor: Colors.black,
      ),
    );
  }

  _posLandingGear() {
    return SizedBox(
      width: 25,
      height: 25,
      child: Checkbox(
        value: controller.potTLandingGear,
        onChanged: (value) {
          if (controller.prePost == 2) {
            controller.checkboxes('potTLandingGear', value!);
          }
          //controller.updateCheck(value!, 'fallPotencial');
        },
        checkColor: Colors.white,
        activeColor: Colors.black,
      ),
    );
  }

  _rrLandingGear() {
    return SizedBox(
      width: 25,
      height: 25,
      child: Checkbox(
        value: controller.rrTLandingGear,
        onChanged: (value) {
          controller.checkboxes('rrTLandingGear', value!);

          //controller.updateCheck(value!, 'fallPotencial');
        },
        checkColor: Colors.white,
        activeColor: Colors.black,
      ),
    );
  }

  _prtLightsAll() {
    return SizedBox(
      width: 25,
      height: 25,
      child: Checkbox(
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        value: controller.prtTLightsAll,
        onChanged: (value) {
          if (controller.prePost == 1) {
            controller.checkboxes('ptrTLightsAll', value!);
          }
          //controller.updateCheck(value!, 'fallPotencial');
        },
        checkColor: Colors.white,
        activeColor: Colors.black,
      ),
    );
  }

  _posLightsAll() {
    return SizedBox(
      width: 25,
      height: 25,
      child: Checkbox(
        value: controller.potTLightsAll,
        onChanged: (value) {
          if (controller.prePost == 2) {
            controller.checkboxes('potTLightsAll', value!);
          }
          //controller.updateCheck(value!, 'fallPotencial');
        },
        checkColor: Colors.white,
        activeColor: Colors.black,
      ),
    );
  }

  _rrLightsAll() {
    return SizedBox(
      width: 25,
      height: 25,
      child: Checkbox(
        value: controller.rrTLightsAll,
        onChanged: (value) {
          controller.checkboxes('rrTLightsAll', value!);

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
        value: controller.prtTReflectorsReflective,
        onChanged: (value) {
          if (controller.prePost == 1) {
            controller.checkboxes('ptrTReflectorsReflective', value!);
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
        value: controller.potTReflectorsReflective,
        onChanged: (value) {
          if (controller.prePost == 2) {
            controller.checkboxes('potTReflectorsReflective', value!);
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
        value: controller.rrTReflectorsReflective,
        onChanged: (value) {
          controller.checkboxes('rrTReflectorsReflective', value!);

          //controller.updateCheck(value!, 'fallPotencial');
        },
        checkColor: Colors.white,
        activeColor: Colors.black,
      ),
    );
  }

  _prtRoof() {
    return SizedBox(
      width: 25,
      height: 25,
      child: Checkbox(
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        value: controller.prtTRoof,
        onChanged: (value) {
          if (controller.prePost == 1) {
            controller.checkboxes('ptrTRoof', value!);
          }
          //controller.updateCheck(value!, 'fallPotencial');
        },
        checkColor: Colors.white,
        activeColor: Colors.black,
      ),
    );
  }

  _posRoof() {
    return SizedBox(
      width: 25,
      height: 25,
      child: Checkbox(
        value: controller.potTRoof,
        onChanged: (value) {
          if (controller.prePost == 2) {
            controller.checkboxes('potTRoof', value!);
          }
          //controller.updateCheck(value!, 'fallPotencial');
        },
        checkColor: Colors.white,
        activeColor: Colors.black,
      ),
    );
  }

  _rrRoof() {
    return SizedBox(
      width: 25,
      height: 25,
      child: Checkbox(
        value: controller.rrTRoof,
        onChanged: (value) {
          controller.checkboxes('rrTRoof', value!);

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
        value: controller.prtTSuspencionSystem,
        onChanged: (value) {
          if (controller.prePost == 1) {
            controller.checkboxes('ptrTSuspensionSystem', value!);
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
        value: controller.potTSuspencionSystem,
        onChanged: (value) {
          if (controller.prePost == 2) {
            controller.checkboxes('potTSuspensionSystem', value!);
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
        value: controller.rrTSuspencionSystem,
        onChanged: (value) {
          controller.checkboxes('rrTSuspensionSystem', value!);

          //controller.updateCheck(value!, 'fallPotencial');
        },
        checkColor: Colors.white,
        activeColor: Colors.black,
      ),
    );
  }

  _prtStraps() {
    return SizedBox(
      width: 25,
      height: 25,
      child: Checkbox(
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        value: controller.prtTStraps,
        onChanged: (value) {
          if (controller.prePost == 1) {
            controller.checkboxes('ptrTStraps', value!);
          }
          //controller.updateCheck(value!, 'fallPotencial');
        },
        checkColor: Colors.white,
        activeColor: Colors.black,
      ),
    );
  }

  _posStraps() {
    return SizedBox(
      width: 25,
      height: 25,
      child: Checkbox(
        value: controller.potTStraps,
        onChanged: (value) {
          if (controller.prePost == 2) {
            controller.checkboxes('potTStraps', value!);
          }
          //controller.updateCheck(value!, 'fallPotencial');
        },
        checkColor: Colors.white,
        activeColor: Colors.black,
      ),
    );
  }

  _rrStraps() {
    return SizedBox(
      width: 25,
      height: 25,
      child: Checkbox(
        value: controller.rrTStraps,
        onChanged: (value) {
          controller.checkboxes('rrTStraps', value!);

          //controller.updateCheck(value!, 'fallPotencial');
        },
        checkColor: Colors.white,
        activeColor: Colors.black,
      ),
    );
  }

  _prtTarpaulin() {
    return SizedBox(
      width: 25,
      height: 25,
      child: Checkbox(
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        value: controller.prtTTarpaulin,
        onChanged: (value) {
          if (controller.prePost == 1) {
            controller.checkboxes('ptrTTarpaulin', value!);
          }
          //controller.updateCheck(value!, 'fallPotencial');
        },
        checkColor: Colors.white,
        activeColor: Colors.black,
      ),
    );
  }

  _posTarpaulin() {
    return SizedBox(
      width: 25,
      height: 25,
      child: Checkbox(
        value: controller.potTTarpaulin,
        onChanged: (value) {
          if (controller.prePost == 2) {
            controller.checkboxes('potTTarpaulin', value!);
          }
          //controller.updateCheck(value!, 'fallPotencial');
        },
        checkColor: Colors.white,
        activeColor: Colors.black,
      ),
    );
  }

  _rrTarpaulin() {
    return SizedBox(
      width: 25,
      height: 25,
      child: Checkbox(
        value: controller.rrTTarpaulin,
        onChanged: (value) {
          controller.checkboxes('rrTTarpaulin', value!);

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
        value: controller.prtTTires,
        onChanged: (value) {
          if (controller.prePost == 1) {
            controller.checkboxes('ptrTTires', value!);
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
        value: controller.potTTires,
        onChanged: (value) {
          if (controller.prePost == 2) {
            controller.checkboxes('potTTires', value!);
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
        value: controller.rrTTires,
        onChanged: (value) {
          controller.checkboxes('rrTTires', value!);

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
        value: controller.prtTWheelsRims,
        onChanged: (value) {
          if (controller.prePost == 1) {
            controller.checkboxes('ptrTWheelsAndRims', value!);
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
        value: controller.potTWheelsRims,
        onChanged: (value) {
          if (controller.prePost == 2) {
            controller.checkboxes('potTWheelsAndRims', value!);
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
        value: controller.rrTWheelsRims,
        onChanged: (value) {
          controller.checkboxes('rrTWheelsAndRims', value!);

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
        value: controller.prtTOther,
        onChanged: (value) {
          if (controller.prePost == 1) {
            controller.checkboxes('ptrTOther', value!);
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
        value: controller.potTOther,
        onChanged: (value) {
          if (controller.prePost == 2) {
            controller.checkboxes('potTOther', value!);
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
        value: controller.rrTOther,
        onChanged: (value) {
          controller.checkboxes('rrTOther', value!);

          //controller.updateCheck(value!, 'fallPotencial');
        },
        checkColor: Colors.white,
        activeColor: Colors.black,
      ),
    );
  }
}
