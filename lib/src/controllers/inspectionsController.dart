import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:hand_signature/signature.dart';
import 'package:intl/intl.dart';
import 'package:location/location.dart';
import 'package:onax_app/src/controllers/connectionManagerController.dart';
import 'package:onax_app/src/repositories/models/checkItemInspectionModel.dart';
import 'package:onax_app/src/repositories/models/desty_origin_Model.dart';
import 'package:onax_app/src/repositories/models/equipmentModel.dart';
import 'package:onax_app/src/services/sqlite/sqlite_destinations.dart';
import 'package:onax_app/src/services/sqlite/sqlite_equipment.dart';
import 'package:onax_app/src/services/sqlite/sqlite_inspections.dart';

import 'package:onax_app/src/utils/sharePrefs/accountPrefs.dart';
import 'package:onax_app/src/utils/urlApi/globalApi.dart';

import 'package:onax_app/src/views/pages_screen.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:http/http.dart' as http;

class InspectionController extends GetxController {
  late int currentSteperIndex;
  late int prePost;
  late int counterNextTimes;
  late GlobalApi api = GlobalApi();
  late RoundedLoadingButtonController btnSave;
  //variables general info
  late bool moveScroll;
  late ScrollController scrollController;
  late TextEditingController locationTxt;
  late String locationName;
  late int tractorID, trailer1ID, trailer2ID, locationID;
  late TextEditingController odoMeterbeginTxt;
  late TextEditingController odoMeterEndText;
  late List<EquipmentModel> listEquipment;
  late List<EquipmentModel> listTrailers;
  late List<DestinyOriginModel> listDestinations;
  late List<CheckboxItemInspectionModel> checkBoxItems;
  late bool vehicleConditionSatisfacotry,
      aboveDefectsCorrected,
      aboveDefectsNeedCorrected;
  //variables Trip
  late bool prtAirCompressor;
  late bool potAirCompressor;
  late bool rrAirCompressor;

  late bool prtAirLines;
  late bool potAirLine;
  late bool rrAirLine;

  late bool prtBattery;
  late bool potBattery;
  late bool rrBattery;

  late bool prtBeltsAndHoses;
  late bool potBeltsAndHoses;
  late bool rrBeltsAndHoses;

  late bool prtBody;
  late bool potBody;
  late bool rrBody;

  late bool prtBrakeAcessories;
  late bool potBrakeAcessories;
  late bool rrBrakeAcessories;

  late bool prtBrakesParking;
  late bool potBrakesParking;
  late bool rrBrakesParking;

  late bool prtBrakesService;
  late bool potBrakesService;
  late bool rrBrakesService;

  late bool prtClutch;
  late bool potClutch;
  late bool rrClutch;

  late bool prtCouplingDevices;
  late bool potCouplingDevices;
  late bool rrCouplingDevices;

  late bool prtDefrosterHeater;
  late bool potDefrosterHeater;
  late bool rrDefrosterHeater;

  late bool prtDriveLine;
  late bool potDriveLine;
  late bool rrDriveLine;

  late bool prtEngine;
  late bool potEngine;
  late bool rrEngine;

  late bool prtExhaust;
  late bool potExhaust;
  late bool rrExhaust;

  late bool prtFifthWeel;
  late bool potFifthWeel;
  late bool rrFifthWeel;

  late bool prtFluidLevels;
  late bool potFluidLevels;
  late bool rrFluidLevels;

  late bool prtFrameAndAssembly;
  late bool potFrameAndAssembly;
  late bool rrFrameAndAssembly;

  late bool prtFrontAxle;
  late bool potFrontAxle;
  late bool rrFrontAxle;

  late bool prtFuelTanks;
  late bool potFlueTanks;
  late bool rrFlueTanks;

  late bool prtGenerator;
  late bool potGenerator;
  late bool rrGenerator;

  late bool prtHorn;
  late bool potHorn;
  late bool rrHorn;

  late bool prtLights;
  late bool potLights;
  late bool rrLights;

  late bool prtMirros;
  late bool potMirros;
  late bool rrMirros;

  late bool prtMuffler;
  late bool potMuffler;
  late bool rrMuffler;

  late bool prtOilLevel;
  late bool potOilLevel;
  late bool rrOilLevel;

  late bool prtRadiatorLeverl;
  late bool potRadiatorLeverl;
  late bool rrRadiatorLeverl;

  late bool prtRearEnd;
  late bool potRearEnd;
  late bool rrRearEnd;

  late bool prtReflectors;
  late bool potReflectors;
  late bool rrReflectors;

  late bool prtSafetyEquipment;
  late bool potSafetyEquipment;
  late bool rrSafetyEquipment;

  late bool prtStarter;
  late bool potStarter;
  late bool rrStarter;

  late bool prtSteering;
  late bool potSteering;
  late bool rrSteering;

  late bool prtSuspensionSystem;
  late bool potSuspensionSystem;
  late bool rrSuspensionSystem;

  late bool prtTireChains;
  late bool potTireChains;
  late bool rrTireChains;

  late bool prtTires;
  late bool potTires;
  late bool rrTires;

  late bool prtTransmission;
  late bool potTransmission;
  late bool rrTransmission;

  late bool prtTripRecorder;
  late bool potTripRecorder;
  late bool rrTripRecorder;

  late bool prtWheelsAndRims;
  late bool potWheelsAndRims;
  late bool rrWheelsAndRims;

  late bool prtWindows;
  late bool potWindows;
  late bool rrWindows;

  late bool prtWindshieldWipers;
  late bool potWindshieldWipers;
  late bool rrWindshieldWipers;

  late bool prtOther;
  late bool potOther;
  late bool rrOther;

  //variables Trailer1
  late TextEditingController trailer1Txt; //change to int selector
  late TextEditingController trailer2Txt; //change to int selector
  late bool prtTBrakeConnections;
  late bool potTBrakeConnections;
  late bool rrTBrakeConnections;

  late bool prtTBrakes;
  late bool potTBrakes;
  late bool rrTBrakes;

  late bool prtTCouplingDevice;
  late bool potTCouplingDevice;
  late bool rrTCouplingDevice;

  late bool prtTCouplingKingPin;
  late bool potTCouplingKingPin;
  late bool rrTCouplingKingPin;

  late bool prtTDorrs;
  late bool potTDorrs;
  late bool rrTDorrs;

  late bool prtTHitch;
  late bool potTHitch;
  late bool rrTHitch;

  late bool prtTLandingGear;
  late bool potTLandingGear;
  late bool rrTLandingGear;

  late bool prtTLightsAll;
  late bool potTLightsAll;
  late bool rrTLightsAll;

  late bool prtTReflectorsReflective;
  late bool potTReflectorsReflective;
  late bool rrTReflectorsReflective;

  late bool prtTRoof;
  late bool potTRoof;
  late bool rrTRoof;

  late bool prtTSuspencionSystem;
  late bool potTSuspencionSystem;
  late bool rrTSuspencionSystem;

  late bool prtTStraps;
  late bool potTStraps;
  late bool rrTStraps;

  late bool prtTTarpaulin;
  late bool potTTarpaulin;
  late bool rrTTarpaulin;

  late bool prtTTires;
  late bool potTTires;
  late bool rrTTires;

  late bool prtTWheelsRims;
  late bool potTWheelsRims;
  late bool rrTWheelsRims;

  late bool prtTOther;
  late bool potTOther;
  late bool rrTOther;
//variables Coditon Remarks
  late TextEditingController remarksTxt;
  late bool conditionOfAbove;
//signature variables
  late HandSignatureControl singnature1Control;
  late HandSignatureControl singnature2Control;
  late dynamic singnature1Pic;
  late dynamic singnature2Pic;
  late bool aboveDefectsCorrect;
  late bool aboveDefectsNeedNotBeCorrected;

  late ConnectionManagerController connectionManagerController;

  @override
  void onInit() {
    connectionManagerController = Get.put(ConnectionManagerController());
    locationName = '';
    scrollController = ScrollController();
    listDestinations = [];
    moveScroll = true;
    singnature2Pic = null;
    listTrailers = [];
    checkBoxItems = [];
    singnature1Pic = null;
    btnSave = RoundedLoadingButtonController();
    currentSteperIndex = 0;
    counterNextTimes = 0;
    prePost = Get.arguments['flag']; //where 1 => is preTrip or 2 => is PosTTrip
    locationTxt = TextEditingController();
    tractorID = 0;
    trailer1ID = 0;
    trailer2ID = 0;
    locationID = 0;
    odoMeterbeginTxt = TextEditingController();
    odoMeterEndText = TextEditingController();
    trailer1Txt = TextEditingController();
    trailer2Txt = TextEditingController();
    remarksTxt = TextEditingController();
    listEquipment = [];
    singnature1Control = HandSignatureControl(
      threshold: 3.0,
      smoothRatio: 0.3,
      velocityRange: 2.0,
    );
    singnature2Control = HandSignatureControl(
      threshold: 3.0,
      smoothRatio: 0.3,
      velocityRange: 2.0,
    );

    aboveDefectsCorrect = false;
    aboveDefectsNeedNotBeCorrected = false;
    conditionOfAbove = false;
    //variables trip
    prtAirCompressor = prePost == 1 ? false : false;
    potAirCompressor = prePost == 2 ? false : false;
    rrAirCompressor = false;

    prtAirLines = prePost == 1 ? false : false;
    potAirLine = prePost == 2 ? false : false;
    rrAirLine = false;

    prtBattery = prePost == 1 ? false : false;
    potBattery = prePost == 2 ? false : false;
    rrBattery = false;

    prtBeltsAndHoses = prePost == 1 ? false : false;
    potBeltsAndHoses = prePost == 2 ? false : false;
    rrBeltsAndHoses = false;

    prtBody = prePost == 1 ? false : false;
    potBody = prePost == 2 ? false : false;
    rrBody = false;

    prtBrakeAcessories = prePost == 1 ? false : false;
    potBrakeAcessories = prePost == 2 ? false : false;
    rrBrakeAcessories = false;

    prtBrakesParking = prePost == 1 ? false : false;
    potBrakesParking = prePost == 2 ? false : false;
    rrBrakesParking = false;

    prtBrakesService = prePost == 1 ? false : false;
    potBrakesService = prePost == 2 ? false : false;
    rrBrakesService = false;

    prtClutch = prePost == 1 ? false : false;
    potClutch = prePost == 2 ? false : false;
    rrClutch = false;

    prtCouplingDevices = prePost == 1 ? false : false;
    potCouplingDevices = prePost == 2 ? false : false;
    rrCouplingDevices = false;

    prtDefrosterHeater = prePost == 1 ? false : false;
    potDefrosterHeater = prePost == 2 ? false : false;
    rrDefrosterHeater = false;

    prtDriveLine = prePost == 1 ? false : false;
    potDriveLine = prePost == 2 ? false : false;
    rrDriveLine = false;

    prtEngine = prePost == 1 ? false : false;
    potEngine = prePost == 2 ? false : false;
    rrEngine = false;

    prtExhaust = prePost == 1 ? false : false;
    potExhaust = prePost == 2 ? false : false;
    rrExhaust = false;

    prtFifthWeel = prePost == 1 ? false : false;
    potFifthWeel = prePost == 2 ? false : false;
    rrFifthWeel = false;

    prtFluidLevels = prePost == 1 ? false : false;
    potFluidLevels = prePost == 2 ? false : false;
    rrFluidLevels = false;

    prtFrameAndAssembly = prePost == 1 ? false : false;
    potFrameAndAssembly = prePost == 2 ? false : false;
    rrFrameAndAssembly = false;

    prtFrontAxle = prePost == 1 ? false : false;
    potFrontAxle = prePost == 2 ? false : false;
    rrFrontAxle = false;

    prtFuelTanks = prePost == 1 ? false : false;
    potFlueTanks = prePost == 2 ? false : false;
    rrFlueTanks = false;

    prtGenerator = prePost == 1 ? false : false;
    potGenerator = prePost == 2 ? false : false;
    rrGenerator = false;

    prtHorn = prePost == 1 ? false : false;
    potHorn = prePost == 2 ? false : false;
    rrHorn = false;

    prtLights = prePost == 1 ? false : false;
    potLights = prePost == 2 ? false : false;
    rrLights = false;

    prtMirros = prePost == 1 ? false : false;
    potMirros = prePost == 2 ? false : false;
    rrMirros = false;

    prtMuffler = prePost == 1 ? false : false;
    potMuffler = prePost == 2 ? false : false;
    rrMuffler = false;

    prtOilLevel = prePost == 1 ? false : false;
    potOilLevel = prePost == 2 ? false : false;
    rrOilLevel = false;

    prtRadiatorLeverl = prePost == 1 ? false : false;
    potRadiatorLeverl = prePost == 2 ? false : false;
    rrRadiatorLeverl = false;

    prtRearEnd = prePost == 1 ? false : false;
    potRearEnd = prePost == 2 ? false : false;
    rrRearEnd = false;

    prtReflectors = prePost == 1 ? false : false;
    potReflectors = prePost == 2 ? false : false;
    rrReflectors = false;

    prtSafetyEquipment = prePost == 1 ? false : false;
    potSafetyEquipment = prePost == 2 ? false : false;
    rrSafetyEquipment = false;

    prtStarter = prePost == 1 ? false : false;
    potStarter = prePost == 2 ? false : false;
    rrStarter = false;

    prtSteering = prePost == 1 ? false : false;
    potSteering = prePost == 2 ? false : false;
    rrSteering = false;

    prtSuspensionSystem = prePost == 1 ? false : false;
    potSuspensionSystem = prePost == 2 ? false : false;
    rrSuspensionSystem = false;

    prtTireChains = prePost == 1 ? false : false;
    potTireChains = prePost == 2 ? false : false;
    rrTireChains = false;

    prtTires = prePost == 1 ? false : false;
    potTires = prePost == 2 ? false : false;
    rrTires = false;

    prtTransmission = prePost == 1 ? false : false;
    potTransmission = prePost == 2 ? false : false;
    rrTransmission = false;

    prtTripRecorder = prePost == 1 ? false : false;
    potTripRecorder = prePost == 2 ? false : false;
    rrTripRecorder = false;

    prtWheelsAndRims = prePost == 1 ? false : false;
    potWheelsAndRims = prePost == 2 ? false : false;
    rrWheelsAndRims = false;

    prtWindows = prePost == 1 ? false : false;
    potWindows = prePost == 2 ? false : false;
    rrWindows = false;

    prtWindshieldWipers = prePost == 1 ? false : false;
    potWindshieldWipers = prePost == 2 ? false : false;
    rrWindshieldWipers = false;

    prtOther = prePost == 1 ? false : false;
    potOther = prePost == 2 ? false : false;
    rrOther = false;

    //variables Trailers
    prtTBrakeConnections = prePost == 1 ? false : false;
    potTBrakeConnections = prePost == 2 ? false : false;
    rrTBrakeConnections = false;

    prtTBrakes = prePost == 1 ? false : false;
    potTBrakes = prePost == 2 ? false : false;
    rrTBrakes = false;

    prtTCouplingDevice = prePost == 1 ? false : false;
    potTCouplingDevice = prePost == 2 ? false : false;
    rrTCouplingDevice = false;

    prtTCouplingKingPin = prePost == 1 ? false : false;
    potTCouplingKingPin = prePost == 2 ? false : false;
    rrTCouplingKingPin = false;

    prtTDorrs = prePost == 1 ? false : false;
    potTDorrs = prePost == 2 ? false : false;
    rrTDorrs = false;

    prtTHitch = prePost == 1 ? false : false;
    potTHitch = prePost == 2 ? false : false;
    rrTHitch = false;

    prtTLandingGear = prePost == 1 ? false : false;
    potTLandingGear = prePost == 2 ? false : false;
    rrTLandingGear = false;

    prtTLightsAll = prePost == 1 ? false : false;
    potTLightsAll = prePost == 2 ? false : false;
    rrTLightsAll = false;

    prtTReflectorsReflective = prePost == 1 ? false : false;
    potTReflectorsReflective = prePost == 2 ? false : false;
    rrTReflectorsReflective = false;

    prtTRoof = prePost == 1 ? false : false;
    potTRoof = prePost == 2 ? false : false;
    rrTRoof = false;

    prtTSuspencionSystem = prePost == 1 ? false : false;
    potTSuspencionSystem = prePost == 2 ? false : false;
    rrTSuspencionSystem = false;

    prtTStraps = prePost == 1 ? false : false;
    potTStraps = prePost == 2 ? false : false;
    rrTStraps = false;

    prtTTarpaulin = prePost == 1 ? false : false;
    potTTarpaulin = prePost == 2 ? false : false;
    rrTTarpaulin = false;

    prtTTires = prePost == 1 ? false : false;
    potTTires = prePost == 2 ? false : false;
    rrTTires = false;

    prtTWheelsRims = prePost == 1 ? false : false;
    potTWheelsRims = prePost == 2 ? false : false;
    rrTWheelsRims = false;

    prtTOther = prePost == 1 ? false : false;
    potTOther = prePost == 2 ? false : false;
    rrTOther = false;

    super.onInit();
  }

  selectEquimpent(id) {
    tractorID = id;
    update();
  }

  selectTrailer1(id) {
    trailer1ID = id;
    update();
  }

  selectTrailer2(id) {
    trailer2ID = id;
    update();
  }

  selectDestination(name) {
    // locationID = id;
    locationName = name;
    update();
  }

  steperCompleted(int step) {
    print(step);
    if (2 == currentSteperIndex) {
      if (trailer1ID == trailer2ID && (trailer1ID != 0 && trailer2ID != 0)) {
        Get.snackbar('Warning',
            'You cannot continue, the Trailer 1 and 2 will be different.',
            colorText: Colors.black,
            backgroundColor: Colors.yellow,
            snackPosition: SnackPosition.BOTTOM,
            duration: const Duration(seconds: 5));
        currentSteperIndex = 2;
      } else {
        if (step > currentSteperIndex) {
          currentSteperIndex = step;
          counterNextTimes++;
        }
      }
    } else {
      if (step > currentSteperIndex) {
        currentSteperIndex = step;
        counterNextTimes++;
      }
    }

    update();
  }

  steperTapByonlyBack(int step) {
    if (step < currentSteperIndex) {
      currentSteperIndex = step;
      counterNextTimes--;
    }
    // print(counterNextTimes);
    update();
  }

  @override
  void onReady() async {
    if (AccountPrefs.statusConnection == true) {
      await getEquipments();
      await _getDestinations();
      await getTrailers();
    } else {
      await getEquipmentsNotWIfi();
      await getTrailersNotWIfi();
      await getDestinationsNOTWIFI();
    }
  }

  @override
  void onClose() {
    super.onClose();
  }

  checkboxes(String nameCheckbox, bool value) {
    switch (nameCheckbox) {
      //AirCompressor
      case 'ptrAirCompressor':
        prtAirCompressor = value;
        break;
      case 'potAirCompressor':
        potAirCompressor = value;
        break;
      case 'rrAirCompressor':
        rrAirCompressor = value;
        break;
      //Air Lines
      case 'ptrAirLines':
        prtAirLines = value;
        break;
      case 'potAirLines':
        potAirLine = value;
        break;
      case 'rrAirLines':
        rrAirLine = value;
        break;
      //Battery
      case 'ptrBattery':
        prtBattery = value;
        break;
      case 'potBattery':
        potBattery = value;
        break;
      case 'rrBattery':
        rrBattery = value;
        break;
      //Belts and Hoses
      case 'ptrBeltsAndHoses':
        prtBeltsAndHoses = value;
        break;
      case 'potBeltsAndHoses':
        potBeltsAndHoses = value;
        break;
      case 'rrBeltsAndHoses':
        rrBeltsAndHoses = value;
        break;
      //Body
      case 'ptrBody':
        prtBody = value;
        break;
      case 'potBody':
        potBody = value;
        break;
      case 'rrBody':
        rrBody = value;
        break;
      //BrakeAccessories
      case 'ptrBrakeAccessories':
        prtBrakeAcessories = value;
        break;
      case 'potBrakeAccesories':
        potBrakeAcessories = value;
        break;
      case 'rrBrakeAccesories':
        rrBrakeAcessories = value;
        break;
      //Brakes parking
      case 'ptrBrakesParking':
        prtBrakesParking = value;
        break;
      case 'potBrakesParking':
        potBrakesParking = value;
        break;
      case 'rrBrakesParking':
        rrBrakesParking = value;
        break;
      //BrakesService
      case 'ptrBrakesService':
        prtBrakesService = value;
        break;
      case 'potBrakesService':
        potBrakesService = value;
        break;
      case 'rrBrakesService':
        rrBrakesService = value;
        break;
      //Clutch
      case 'ptrClutch':
        prtClutch = value;
        break;
      case 'potClutch':
        potClutch = value;
        break;
      case 'rrClutch':
        rrClutch = value;
        break;
      //CouplingDevices
      case 'ptrCouplingDevices':
        prtCouplingDevices = value;
        break;
      case 'potCouplingDevices':
        potCouplingDevices = value;
        break;
      case 'rrCouplingDevices':
        rrCouplingDevices = value;
        break;
      //Defroster/Heater
      case 'ptrDefrosterHeater':
        prtDefrosterHeater = value;
        break;
      case 'potDefrosterHeater':
        potDefrosterHeater = value;
        break;
      case 'rrDefrosterHeater':
        rrDefrosterHeater = value;
        break;
      //Drive Line
      case 'ptrDriveLine':
        prtDriveLine = value;
        break;
      case 'potDriveLine':
        potDriveLine = value;
        break;
      case 'rrDriveLine':
        rrDriveLine = value;
        break;
      //Engine
      case 'ptrEngine':
        prtEngine = value;
        break;
      case 'potEngine':
        potEngine = value;
        break;
      case 'rrEngine':
        rrEngine = value;
        break;
      //Exhaust
      case 'ptrExhaust':
        prtExhaust = value;
        break;
      case 'potExhaust':
        potExhaust = value;
        break;
      case 'rrExhaust':
        rrExhaust = value;
        break;
      //Fifth Wheel
      case 'ptrFifthWeel':
        prtFifthWeel = value;
        break;
      case 'potFifthWeel':
        potFifthWeel = value;
        break;
      case 'rrFifthWeel':
        rrFifthWeel = value;
        break;
      //Fluid Levels
      case 'ptrFluidLevels':
        prtFluidLevels = value;
        break;
      case 'potFluidLevels':
        potFluidLevels = value;
        break;
      case 'rrFluidLevels':
        rrFluidLevels = value;
        break;
      //Frame and Assembly
      case 'ptrFrameAndAssembly':
        prtFrameAndAssembly = value;
        break;
      case 'potFrameAndAssembly':
        potFrameAndAssembly = value;
        break;
      case 'rrFrameAndAssembly':
        rrFrameAndAssembly = value;
        break;
      //Front Axle
      case 'ptrFrontAxle':
        prtFrontAxle = value;
        break;
      case 'potFrontAxle':
        potFrontAxle = value;
        break;
      case 'rrFrontAxle':
        rrFrontAxle = value;
        break;
      //Fuel Tanks
      case 'ptrFuelTanks':
        prtFuelTanks = value;
        break;
      case 'potFuelTanks':
        potFlueTanks = value;
        break;
      case 'rrFuelTanks':
        rrFlueTanks = value;
        break;
      //Generator
      case 'ptrGenerator':
        prtGenerator = value;
        break;
      case 'potGenerator':
        potGenerator = value;
        break;
      case 'rrGenerator':
        rrGenerator = value;
        break;
      //Horn
      case 'ptrHorn':
        prtHorn = value;
        break;
      case 'potHorn':
        potHorn = value;
        break;
      case 'rrHorn':
        rrHorn = value;
        break;
      //Lights
      case 'ptrLights':
        prtLights = value;
        break;
      case 'potLights':
        potLights = value;
        break;
      case 'rrLights':
        rrLights = value;
        break;
      //Mirrors
      case 'ptrMirrors':
        prtMirros = value;
        break;
      case 'potMirrors':
        potMirros = value;
        break;
      case 'rrMirrors':
        rrMirros = value;
        break;
      //Muffler
      case 'ptrMuffler':
        prtMuffler = value;
        break;
      case 'potMuffler':
        potMuffler = value;
        break;
      case 'rrMuffler':
        rrMuffler = value;
        break;
      //Oil Level
      case 'ptrOilLevel':
        prtOilLevel = value;
        break;
      case 'potOilLevel':
        potOilLevel = value;
        break;
      case 'rrOilLevel':
        rrOilLevel = value;
        break;
      //Radiator level
      case 'ptrRadiatorLevel':
        prtRadiatorLeverl = value;
        break;
      case 'potRadiatorLevel':
        potRadiatorLeverl = value;
        break;
      case 'rrRadiatorLevel':
        rrRadiatorLeverl = value;
        break;
      //Rear End
      case 'ptrRearEnd':
        prtRearEnd = value;
        break;
      case 'potRearEnd':
        potRearEnd = value;
        break;
      case 'rrRearEnd':
        rrRearEnd = value;
        break;
      //Reflectors
      case 'ptrReflectors':
        prtReflectors = value;
        break;
      case 'potReflectors':
        potReflectors = value;
        break;
      case 'rrReflectors':
        rrReflectors = value;
        break;
      //Safety Equipment
      case 'ptrSafetyEquipment':
        prtSafetyEquipment = value;
        break;
      case 'potSafetyEquipment':
        potSafetyEquipment = value;
        break;
      case 'rrSafetyEquipment':
        rrSafetyEquipment = value;
        break;
      //Starter
      case 'ptrStarter':
        prtStarter = value;
        break;
      case 'potStarter':
        potStarter = value;
        break;
      case 'rrStarter':
        rrStarter = value;
        break;
      //Steering
      case 'ptrSteering':
        prtSteering = value;
        break;
      case 'potSteering':
        potSteering = value;
        break;
      case 'rrSteering':
        rrSteering = value;
        break;
      //Suspension System
      case 'ptrSuspensionSystem':
        prtSuspensionSystem = value;
        break;
      case 'potSuspensionSystem':
        potSuspensionSystem = value;
        break;
      case 'rrSuspensionSystem':
        rrSuspensionSystem = value;
        break;
      //Tires
      case 'ptrTires':
        prtTires = value;
        break;
      case 'potTires':
        potTires = value;
        break;
      case 'rrTires':
        rrTires = value;
        break;
      //Tire Chains
      case 'ptrTireChains':
        prtTireChains = value;
        break;
      case 'potTireChains':
        potTireChains = value;
        break;
      case 'rrTireChains':
        rrTireChains = value;
        break;
      //Transmission
      case 'ptrTransmission':
        prtTransmission = value;
        break;
      case 'potTransmission':
        potTransmission = value;
        break;
      case 'rrTransmission':
        rrTransmission = value;
        break;
      //TripRecorder
      case 'ptrTripRecorder':
        prtTripRecorder = value;
        break;
      case 'potTripRecorder':
        potTripRecorder = value;
        break;
      case 'rrTripRecorder':
        rrTripRecorder = value;
        break;
      //Wheels and Rims
      case 'ptrWheelsAndRims':
        prtWheelsAndRims = value;
        break;
      case 'potWheelsAndRims':
        potWheelsAndRims = value;
        break;
      case 'rrWheelsAndRims':
        rrWheelsAndRims = value;
        break;
      //Windows
      case 'ptrWindows':
        prtWindows = value;
        break;
      case 'potWindows':
        potWindows = value;
        break;
      case 'rrWindows':
        rrWindows = value;
        break;
      //WindshieldWipers
      case 'ptrWindshieldWipers':
        prtWindshieldWipers = value;
        break;
      case 'potWindshieldWipers':
        potWindshieldWipers = value;
        break;
      case 'rrWindshieldWipers':
        rrWindshieldWipers = value;
        break;
      //Other
      case 'ptrOther':
        prtOther = value;
        break;
      case 'potOther':
        potOther = value;
        break;
      case 'rrOther':
        rrOther = value;
        break;
      /*
          TRAILESR CHECkBOX below
         */
      //BrakeConnections T
      case 'ptrTBrakeConnections':
        prtTBrakeConnections = value;
        break;
      case 'potTBrakeConnections':
        potTBrakeConnections = value;
        break;
      case 'rrTBrakeConnections':
        rrTBrakeConnections = value;
        break;
      //Brakes T
      case 'ptrTBrakes':
        prtTBrakes = value;
        break;
      case 'potTBrakes':
        potTBrakes = value;
        break;
      case 'rrTBrakes':
        rrTBrakes = value;
        break;
      //Coupling Devices T
      case 'ptrTCouplingDevice':
        prtTCouplingDevice = value;
        break;
      case 'potTCouplingDevice':
        potTCouplingDevice = value;
        break;
      case 'rrTCouplingDevice':
        rrTCouplingDevice = value;
        break;
      //Coupling king pin
      case 'ptrTCouplingKingPin':
        prtTCouplingKingPin = value;
        break;
      case 'potTCouplingKingPin':
        potTCouplingKingPin = value;
        break;
      case 'rrTCouplingKingPin':
        rrTCouplingKingPin = value;
        break;
      //Doors
      case 'ptrTDoors':
        prtTDorrs = value;
        break;
      case 'potTDoors':
        potTDorrs = value;
        break;
      case 'rrTDoors':
        rrTDorrs = value;
        break;
      //Hitch
      case 'ptrTHitch':
        prtTHitch = value;
        break;
      case 'potTHitch':
        potTHitch = value;
        break;
      case 'rrTHitch':
        rrTHitch = value;
        break;
      //Landing Gear
      case 'ptrTLandingGear':
        prtTLandingGear = value;
        break;
      case 'potTLandingGear':
        potTLandingGear = value;
        break;
      case 'rrTLandingGear':
        rrTLandingGear = value;
        break;
      //Lights All
      case 'ptrTLightsAll':
        prtTLightsAll = value;
        break;
      case 'potTLightsAll':
        potTLightsAll = value;
        break;
      case 'rrTLightsAll':
        rrTLightsAll = value;
        break;
      //Refletors T
      case 'ptrTReflectorsReflective':
        prtTReflectorsReflective = value;
        break;
      case 'potTReflectorsReflective':
        potTReflectorsReflective = value;
        break;
      case 'rrTReflectorsReflective':
        rrTReflectorsReflective = value;
        break;
      //Roof
      case 'ptrTRoof':
        prtTRoof = value;
        break;
      case 'potTRoof':
        potTRoof = value;
        break;
      case 'rrTRoof':
        rrTRoof = value;
        break;
      //Suspension system T
      case 'ptrTSuspensionSystem':
        prtTSuspencionSystem = value;
        break;
      case 'potTSuspensionSystem':
        potTSuspencionSystem = value;
        break;
      case 'rrTSuspensionSystem':
        rrTSuspencionSystem = value;
        break;
      //Straps
      case 'ptrTStraps':
        prtTStraps = value;
        break;
      case 'potTStraps':
        potTStraps = value;
        break;
      case 'rrTStraps':
        rrTStraps = value;
        break;
      //Tarpaulin
      case 'ptrTTarpaulin':
        prtTTarpaulin = value;
        break;
      case 'potTTarpaulin':
        potTTarpaulin = value;
        break;
      case 'rrTTarpaulin':
        rrTTarpaulin = value;
        break;
      //Tires
      case 'ptrTTires':
        prtTTires = value;
        break;
      case 'potTTires':
        potTTires = value;
        break;
      case 'rrTTires':
        rrTTires = value;
        break;
      //Wheels and Rims T
      case 'ptrTWheelsAndRims':
        prtTWheelsRims = value;
        break;
      case 'potTWheelsAndRims':
        potTWheelsRims = value;
        break;
      case 'rrTWheelsAndRims':
        rrTWheelsRims = value;
        break;
      //Other T
      case 'ptrTOther':
        prtTOther = value;
        break;
      case 'potTOther':
        potTOther = value;
        break;
      case 'rrTOther':
        rrTOther = value;
        break;
      case 'aboveDefectsCorrect':
        aboveDefectsCorrect = value;
        break;
      case 'aboveDefectsNeedNotBeCorrected':
        aboveDefectsNeedNotBeCorrected = value;
        break;
      case 'conditionOfAbove':
        conditionOfAbove = value;
        break;

      default:
    }
    update();
  }

  onStartPadDraw() {
    moveScroll = false;
    update();
  }

  onEndPadDraw() {
    moveScroll = true;
    update();
  }

  ///convert signatures to image first before.
  convertPadToImg() async {
    if (singnature1Control.isFilled) {
      var singnatureImg = await singnature1Control.toImage(
        background: Colors.white,
        color: Colors.black,
        fit: true,
      );
      Uint8List? imageBytes = singnatureImg!.buffer.asUint8List();
      final String base64Singnature1 = base64Encode(imageBytes);

      singnature1Pic = base64Singnature1;
    } else {
      singnature1Pic = '';
    }
    if (singnature2Control.isFilled) {
      var singnature2Img = await singnature2Control.toImage(
        background: Colors.white,
        color: Colors.black,
        fit: true,
      );
      Uint8List? imageBytes = singnature2Img!.buffer.asUint8List();
      final String base64Singnature1 = base64Encode(imageBytes);

      singnature2Pic = base64Singnature1;
    } else {
      singnature2Pic = '';
    }
    update();
  }

  ///save Inspection
  saveInspection() async {
    try {
      _fillCheckboxItems();
      await convertPadToImg();
      Location locations = Location();
      final String urlApi = '${api.api}/${api.createInspection}';

      final header = {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${AccountPrefs.token}',
      };

      late DateTime date = DateTime.now().toUtc();
      String formatDate = DateFormat('yyyy-MM-dd').format(date);
      LocationData coordenates = await locations.getLocation();
      String sendCoords = '${coordenates.latitude}, ${coordenates.longitude}';
      final body = {
        //'destination_id',
        'date': formatDate,
        'location': locationName,
        'equipment_id': tractorID,
        'odometer_begin': odoMeterbeginTxt.text.isNotEmpty
            ? double.parse(odoMeterbeginTxt.text.trim())
            : 0,
        'odometer_end': odoMeterEndText.text.isNotEmpty
            ? double.parse(odoMeterEndText.text.trim())
            : 0,
        'remarks': remarksTxt.text.trim(),
        'worker_id': AccountPrefs.idUser, //this references to pusher id
        'vehicle_condition': conditionOfAbove == true ? 1 : 0,
        'defects_corrected': aboveDefectsCorrect == true ? 1 : 0,
        'defects_not_corrected': aboveDefectsNeedNotBeCorrected == true ? 1 : 0,
        'trailer_1_equipment_id': trailer1ID,
        'trailer_2_equipment_id': trailer2ID,
        'v_condition_signature': singnature1Pic,
        'driver_signature': singnature2Pic,
        'checkBoxItems': json.encode(checkBoxItems),
      };

      //print(sendCoords);
      if (validateDataRequired()) {
        //check if we have internet
        final response = await http.post(Uri.parse(urlApi),
            headers: header, body: json.encode(body));
        print(response.body);
        Map<String, dynamic> decodeResp = json.decode(response.body);
        print(decodeResp['data']);
        if (response.statusCode == 200 && decodeResp['success'] == true) {
          if (decodeResp['data'].containsKey('inspectionID')) {
            //clean the inputs and show snackbar.
            //1show snackbar
            Get.snackbar('Succes', 'Inspection has been created.',
                colorText: Colors.black,
                backgroundColor: Colors.greenAccent,
                duration: const Duration(seconds: 4),
                snackPosition: SnackPosition.BOTTOM);
            Get.off(
              () => PagesScreen(),
              arguments: {'page': 2},
              transition: Transition.downToUp,
              duration: const Duration(milliseconds: 250),
            );
            //_cleanVariables();
          }
        } else {
          Get.snackbar(
              'Warning', 'Please try it later, we can not make the action.',
              colorText: Colors.black,
              backgroundColor: Colors.yellow,
              snackPosition: SnackPosition.BOTTOM);
          btnSave.reset();
        }
      }

      update();
      //Get close loading
      //Get back to home,

    } catch (e) {
      print(e.toString());
      Get.snackbar('Error', 'There was a problem connecting to the server.',
          colorText: Colors.white,
          backgroundColor: Colors.redAccent,
          snackPosition: SnackPosition.BOTTOM);
      btnSave.reset();
    }
  }

  ///save Inspection
  saveInspectionNotWifi() async {
    try {
      _fillCheckboxItems();
      await convertPadToImg();
      Location locations = Location();

      late DateTime date = DateTime.now().toUtc();
      String formatDate = DateFormat('yyyy-MM-dd').format(date);
      LocationData coordenates = await locations.getLocation();
      String sendCoords = '${coordenates.latitude}, ${coordenates.longitude}';
      final body = {
        //'destination_id',
        'date': formatDate,
        'location': locationName,
        'equipment_id': tractorID,
        'odometer_begin': odoMeterbeginTxt.text.trim().isNotEmpty
            ? double.parse(odoMeterbeginTxt.text.trim())
            : 0,
        'odometer_end': odoMeterEndText.text.trim().isNotEmpty
            ? double.parse(odoMeterEndText.text.trim())
            : 0,
        'remarks': remarksTxt.text.trim(),
        'worker_id': AccountPrefs.idUser, //this references to pusher id
        'vehicle_condition': conditionOfAbove == true ? 1 : 0,
        'defects_corrected': aboveDefectsCorrect == true ? 1 : 0,
        'defects_not_corrected': aboveDefectsNeedNotBeCorrected == true ? 1 : 0,
        'trailer_1_equipment_id': trailer1ID,
        'trailer_2_equipment_id': trailer2ID,
        'v_condition_signature': singnature1Pic,
        'driver_signature': singnature2Pic,
        'checkBoxItems': json.encode(checkBoxItems),
      };

      //print(sendCoords);
      if (validateDataRequired()) {
        //check if we have internet
        final response = await InspectionsSQL().insertJSAsSQL(body);
        // print(response.body);
        // Map<String, dynamic> decodeResp = json.decode(response.body);
        // print(decodeResp['data']);
        if (response['statusCode'] == 200 && response['success'] == true) {
          if (response['data'].containsKey('inspectionID')) {
            //clean the inputs and show snackbar.
            //1show snackbar
            Get.snackbar('Succes', 'Inspection has been created.',
                colorText: Colors.black,
                backgroundColor: Colors.greenAccent,
                duration: const Duration(seconds: 4),
                snackPosition: SnackPosition.BOTTOM);
            Get.off(
              () => PagesScreen(),
              arguments: {'page': 2},
              transition: Transition.downToUp,
              duration: const Duration(milliseconds: 250),
            );
            //_cleanVariables();
          }
        } else {
          Get.snackbar(
              'Warning', 'Please try it later, we can not make the action.',
              colorText: Colors.black,
              backgroundColor: Colors.yellow,
              snackPosition: SnackPosition.BOTTOM);
          btnSave.reset();
        }
      } else {
        btnSave.reset();
      }

      update();
      //Get close loading
      //Get back to home,

    } catch (e) {
      print(e.toString());
      Get.snackbar('Error', 'There was a problem connecting to the server.',
          colorText: Colors.white,
          backgroundColor: Colors.redAccent,
          snackPosition: SnackPosition.BOTTOM);
      btnSave.reset();
    }
  }

  //validate a require dataObject
  validateDataRequired() {
    late String message = '';
    late bool flag = false;

    // if (locationTxt.text.isEmpty) {
    //   message += 'The location is require. Please fill it\n.';
    // }
    if (tractorID == 0) {
      message += 'The equipment is require. Please fill it\n';
    }
    if (remarksTxt.text.isEmpty) {
      message += 'The remarks are required. Please fill it\n';
    }
    if (singnature1Pic.isEmpty) {
      message += 'The signature of codition is require. Please fill it\n';
    }
    if (singnature2Pic.isEmpty) {
      message += 'The signature of  Conditions satisfacotry is require.\n';
    }

    if (message != '') {
      flag = false;
    } else {
      flag = true;
    }

    if (flag == false) {
      Get.snackbar('Warning', message,
          colorText: Colors.black,
          backgroundColor: Colors.yellow,
          snackPosition: SnackPosition.BOTTOM,
          duration: const Duration(seconds: 6));
      return false;
    } else {
      return true;
    }
  }

  _fillCheckboxItems() {
    checkBoxItems = [
      CheckboxItemInspectionModel(
          preTrip: prtAirCompressor == true ? 1 : 0,
          postTrip: potAirCompressor == true ? 1 : 0,
          requiresRepair: rrAirCompressor == true ? 1 : 0,
          name: "Air Compressor"),
      CheckboxItemInspectionModel(
          preTrip: prtAirLines == true ? 1 : 0,
          postTrip: potAirLine == true ? 1 : 0,
          requiresRepair: rrAirLine == true ? 1 : 0,
          name: "Air Lines"),
      CheckboxItemInspectionModel(
          preTrip: prtBattery == true ? 1 : 0,
          postTrip: potBattery == true ? 1 : 0,
          requiresRepair: rrBattery == true ? 1 : 0,
          name: "Battery"),
      CheckboxItemInspectionModel(
          preTrip: prtBeltsAndHoses == true ? 1 : 0,
          postTrip: potBeltsAndHoses == true ? 1 : 0,
          requiresRepair: rrBeltsAndHoses == true ? 1 : 0,
          name: "Belts and Hoses"),
      CheckboxItemInspectionModel(
          preTrip: prtBody == true ? 1 : 0,
          postTrip: potBody == true ? 1 : 0,
          requiresRepair: rrBody == true ? 1 : 0,
          name: "Body"),
      CheckboxItemInspectionModel(
          preTrip: prtBrakeAcessories == true ? 1 : 0,
          postTrip: potBrakeAcessories == true ? 1 : 0,
          requiresRepair: rrBrakeAcessories == true ? 1 : 0,
          name: "Brake Accessories"),
      CheckboxItemInspectionModel(
          preTrip: prtBrakesParking == true ? 1 : 0,
          postTrip: potBrakesParking == true ? 1 : 0,
          requiresRepair: rrBrakesParking == true ? 1 : 0,
          name: "Brakes, Parking"),
      CheckboxItemInspectionModel(
          preTrip: prtBrakesService == true ? 1 : 0,
          postTrip: potBrakesService == true ? 1 : 0,
          requiresRepair: rrBrakesService == true ? 1 : 0,
          name: "Brakes, Service"),
      CheckboxItemInspectionModel(
          preTrip: prtClutch == true ? 1 : 0,
          postTrip: potClutch == true ? 1 : 0,
          requiresRepair: rrClutch == true ? 1 : 0,
          name: "Clutch"),
      CheckboxItemInspectionModel(
          preTrip: prtCouplingDevices == true ? 1 : 0,
          postTrip: potCouplingDevices == true ? 1 : 0,
          requiresRepair: rrCouplingDevices == true ? 1 : 0,
          name: "Coupling Devices"),
      CheckboxItemInspectionModel(
          preTrip: prtDefrosterHeater == true ? 1 : 0,
          postTrip: potDefrosterHeater == true ? 1 : 0,
          requiresRepair: rrDefrosterHeater == true ? 1 : 0,
          name: "Defroster/Heater"),
      CheckboxItemInspectionModel(
          preTrip: prtDriveLine == true ? 1 : 0,
          postTrip: potDriveLine == true ? 1 : 0,
          requiresRepair: rrDriveLine == true ? 1 : 0,
          name: "Drive Line"),
      CheckboxItemInspectionModel(
          preTrip: prtEngine == true ? 1 : 0,
          postTrip: potEngine == true ? 1 : 0,
          requiresRepair: rrEngine == true ? 1 : 0,
          name: "Engine"),
      CheckboxItemInspectionModel(
          preTrip: prtExhaust == true ? 1 : 0,
          postTrip: potExhaust == true ? 1 : 0,
          requiresRepair: rrExhaust == true ? 1 : 0,
          name: "Exhaust"),
      CheckboxItemInspectionModel(
          preTrip: prtBrakesService == true ? 1 : 0,
          postTrip: potBrakesService == true ? 1 : 0,
          requiresRepair: rrBrakesService == true ? 1 : 0,
          name: "Brakes, Service"),
      CheckboxItemInspectionModel(
          preTrip: prtFifthWeel == true ? 1 : 0,
          postTrip: potFifthWeel == true ? 1 : 0,
          requiresRepair: rrFifthWeel == true ? 1 : 0,
          name: "Fifth Wheel"),
      CheckboxItemInspectionModel(
          preTrip: prtFluidLevels == true ? 1 : 0,
          postTrip: potFluidLevels == true ? 1 : 0,
          requiresRepair: rrFluidLevels == true ? 1 : 0,
          name: "Fluid Levels"),
      CheckboxItemInspectionModel(
          preTrip: prtFrameAndAssembly == true ? 1 : 0,
          postTrip: potFrameAndAssembly == true ? 1 : 0,
          requiresRepair: rrFrameAndAssembly == true ? 1 : 0,
          name: "Frame and Assembly"),
      CheckboxItemInspectionModel(
          preTrip: prtFrontAxle == true ? 1 : 0,
          postTrip: potFrontAxle == true ? 1 : 0,
          requiresRepair: rrFrontAxle == true ? 1 : 0,
          name: "Front Axle"),
      CheckboxItemInspectionModel(
          preTrip: prtFuelTanks == true ? 1 : 0,
          postTrip: potFlueTanks == true ? 1 : 0,
          requiresRepair: rrFlueTanks == true ? 1 : 0,
          name: "Fuel Tanks"),
      CheckboxItemInspectionModel(
          preTrip: prtGenerator == true ? 1 : 0,
          postTrip: potGenerator == true ? 1 : 0,
          requiresRepair: rrGenerator == true ? 1 : 0,
          name: "Generator"),
      CheckboxItemInspectionModel(
          preTrip: prtHorn == true ? 1 : 0,
          postTrip: potHorn == true ? 1 : 0,
          requiresRepair: rrHorn == true ? 1 : 0,
          name: "Horn"),
      CheckboxItemInspectionModel(
          preTrip: prtLights == true ? 1 : 0,
          postTrip: potLights == true ? 1 : 0,
          requiresRepair: rrLights == true ? 1 : 0,
          name: "Lights head - Stop Tail - Dash Turn Indicators"),
      CheckboxItemInspectionModel(
          preTrip: prtMirros == true ? 1 : 0,
          postTrip: potMirros == true ? 1 : 0,
          requiresRepair: rrMirros == true ? 1 : 0,
          name: "Mirrors"),
      CheckboxItemInspectionModel(
          preTrip: prtMuffler == true ? 1 : 0,
          postTrip: potMuffler == true ? 1 : 0,
          requiresRepair: rrMuffler == true ? 1 : 0,
          name: "Muffler"),
      CheckboxItemInspectionModel(
          preTrip: prtOilLevel == true ? 1 : 0,
          postTrip: potOilLevel == true ? 1 : 0,
          requiresRepair: rrOilLevel == true ? 1 : 0,
          name: "Oil Level"),
      CheckboxItemInspectionModel(
          preTrip: prtRadiatorLeverl == true ? 1 : 0,
          postTrip: potRadiatorLeverl == true ? 1 : 0,
          requiresRepair: rrRadiatorLeverl == true ? 1 : 0,
          name: "Radiator Level"),
      CheckboxItemInspectionModel(
          preTrip: prtRearEnd == true ? 1 : 0,
          postTrip: potRearEnd == true ? 1 : 0,
          requiresRepair: rrRearEnd == true ? 1 : 0,
          name: "Rear End"),
      CheckboxItemInspectionModel(
          preTrip: prtReflectors == true ? 1 : 0,
          postTrip: potReflectors == true ? 1 : 0,
          requiresRepair: rrReflectors == true ? 1 : 0,
          name: "Reflectors"),
      CheckboxItemInspectionModel(
          preTrip: prtSafetyEquipment == true ? 1 : 0,
          postTrip: potSafetyEquipment == true ? 1 : 0,
          requiresRepair: rrSafetyEquipment == true ? 1 : 0,
          name:
              "Safety Equipment Fire Extinguisher Flags - Flares - Fusees Reflective Triangles Spare Bulbs and Fuses Spare Seal Beam"),
      CheckboxItemInspectionModel(
          preTrip: prtStarter == true ? 1 : 0,
          postTrip: potStarter == true ? 1 : 0,
          requiresRepair: rrStarter == true ? 1 : 0,
          name: "Starter"),
      CheckboxItemInspectionModel(
          preTrip: prtSteering == true ? 1 : 0,
          postTrip: potSteering == true ? 1 : 0,
          requiresRepair: rrSteering == true ? 1 : 0,
          name: "Steering"),
      CheckboxItemInspectionModel(
          preTrip: prtSuspensionSystem == true ? 1 : 0,
          postTrip: potSuspensionSystem == true ? 1 : 0,
          requiresRepair: rrSuspensionSystem == true ? 1 : 0,
          name: "Suspension System"),
      CheckboxItemInspectionModel(
          preTrip: prtTireChains == true ? 1 : 0,
          postTrip: potTireChains == true ? 1 : 0,
          requiresRepair: rrTireChains == true ? 1 : 0,
          name: "Tire Chains"),
      CheckboxItemInspectionModel(
          preTrip: prtTires == true ? 1 : 0,
          postTrip: potTires == true ? 1 : 0,
          requiresRepair: rrTires == true ? 1 : 0,
          name: "Tires"),
      CheckboxItemInspectionModel(
          preTrip: prtTransmission == true ? 1 : 0,
          postTrip: potTransmission == true ? 1 : 0,
          requiresRepair: rrTransmission == true ? 1 : 0,
          name: "Transmission"),
      CheckboxItemInspectionModel(
          preTrip: prtTripRecorder == true ? 1 : 0,
          postTrip: potTripRecorder == true ? 1 : 0,
          requiresRepair: rrTripRecorder == true ? 1 : 0,
          name: "Trip Recorder"),
      CheckboxItemInspectionModel(
          preTrip: prtWheelsAndRims == true ? 1 : 0,
          postTrip: potWheelsAndRims == true ? 1 : 0,
          requiresRepair: rrWheelsAndRims == true ? 1 : 0,
          name: "Wheels and Rims"),
      CheckboxItemInspectionModel(
          preTrip: prtWindows == true ? 1 : 0,
          postTrip: potWindows == true ? 1 : 0,
          requiresRepair: rrWindows == true ? 1 : 0,
          name: "Windows"),
      CheckboxItemInspectionModel(
          preTrip: prtWindshieldWipers == true ? 1 : 0,
          postTrip: potWindshieldWipers == true ? 1 : 0,
          requiresRepair: rrWindshieldWipers == true ? 1 : 0,
          name: "Windshield Wipers"),
      CheckboxItemInspectionModel(
          preTrip: prtOther == true ? 1 : 0,
          postTrip: potOther == true ? 1 : 0,
          requiresRepair: rrOther == true ? 1 : 0,
          name: "Other"),
      CheckboxItemInspectionModel(
          preTrip: prtTBrakeConnections == true ? 1 : 0,
          postTrip: potTBrakeConnections == true ? 1 : 0,
          requiresRepair: rrTBrakeConnections == true ? 1 : 0,
          name: "TBrake Connections"),
      CheckboxItemInspectionModel(
          preTrip: prtTCouplingDevice == true ? 1 : 0,
          postTrip: potTCouplingDevice == true ? 1 : 0,
          requiresRepair: rrTCouplingDevice == true ? 1 : 0,
          name: "TCoupling Devices"),
      CheckboxItemInspectionModel(
          preTrip: prtTBrakes == true ? 1 : 0,
          postTrip: potTBrakes == true ? 1 : 0,
          requiresRepair: rrTBrakes == true ? 1 : 0,
          name: "TBrakes"),
      CheckboxItemInspectionModel(
          preTrip: prtTCouplingKingPin == true ? 1 : 0,
          postTrip: potTCouplingKingPin == true ? 1 : 0,
          requiresRepair: rrTCouplingKingPin == true ? 1 : 0,
          name: "Coupling (King) Pin"),
      CheckboxItemInspectionModel(
          preTrip: prtTDorrs == true ? 1 : 0,
          postTrip: potTDorrs == true ? 1 : 0,
          requiresRepair: rrTDorrs == true ? 1 : 0,
          name: "Doors"),
      CheckboxItemInspectionModel(
          preTrip: prtTHitch == true ? 1 : 0,
          postTrip: potTHitch == true ? 1 : 0,
          requiresRepair: rrTHitch == true ? 1 : 0,
          name: "Hitch"),
      CheckboxItemInspectionModel(
          preTrip: prtTLandingGear == true ? 1 : 0,
          postTrip: potTLandingGear == true ? 1 : 0,
          requiresRepair: rrTLandingGear == true ? 1 : 0,
          name: "Landing Gear"),
      CheckboxItemInspectionModel(
          preTrip: prtTLightsAll == true ? 1 : 0,
          postTrip: potTLightsAll == true ? 1 : 0,
          requiresRepair: rrTLightsAll == true ? 1 : 0,
          name: "Lights - All"),
      CheckboxItemInspectionModel(
          preTrip: prtTReflectorsReflective == true ? 1 : 0,
          postTrip: potTReflectorsReflective == true ? 1 : 0,
          requiresRepair: rrTReflectorsReflective == true ? 1 : 0,
          name: "Reflectors/Reflective"),
      CheckboxItemInspectionModel(
          preTrip: prtTRoof == true ? 1 : 0,
          postTrip: potTRoof == true ? 1 : 0,
          requiresRepair: rrTRoof == true ? 1 : 0,
          name: "Roof"),
      CheckboxItemInspectionModel(
          preTrip: prtTSuspencionSystem == true ? 1 : 0,
          postTrip: potTSuspencionSystem == true ? 1 : 0,
          requiresRepair: rrTSuspencionSystem == true ? 1 : 0,
          name: "TSuspencion System"),
      CheckboxItemInspectionModel(
          preTrip: prtTStraps == true ? 1 : 0,
          postTrip: potTStraps == true ? 1 : 0,
          requiresRepair: rrTStraps == true ? 1 : 0,
          name: "Straps"),
      CheckboxItemInspectionModel(
          preTrip: prtTTarpaulin == true ? 1 : 0,
          postTrip: potTTarpaulin == true ? 1 : 0,
          requiresRepair: rrTTarpaulin == true ? 1 : 0,
          name: "Tarpaulin"),
      CheckboxItemInspectionModel(
          preTrip: prtTTires == true ? 1 : 0,
          postTrip: potTTires == true ? 1 : 0,
          requiresRepair: rrTTires == true ? 1 : 0,
          name: "TTires"),
      CheckboxItemInspectionModel(
          preTrip: prtTWheelsRims == true ? 1 : 0,
          postTrip: potTWheelsRims == true ? 1 : 0,
          requiresRepair: rrTWheelsRims == true ? 1 : 0,
          name: "Wheels and Rims"),
      CheckboxItemInspectionModel(
          preTrip: prtTOther == true ? 1 : 0,
          postTrip: potTOther == true ? 1 : 0,
          requiresRepair: rrTOther == true ? 1 : 0,
          name: "Trailer Other"),
      //Brakes
    ];
    update();
  }

  getEquipments() async {
    try {
      print(AccountPrefs.type);
      //loading dialog
      // if (AccountPrefs.type == 'driver' || AccountPrefs.type == 'operator') {
      final String urlApi = '${api.api}/${api.equipments}'; //url/api/login

      final header = {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${AccountPrefs.token}',
      };

      final response = await http.get(Uri.parse(urlApi), headers: header);

      Map<String, dynamic> decodeResp = json.decode(response.body);

      if (response.statusCode == 200 && decodeResp['success'] == true) {
        if (decodeResp.containsKey('data') && decodeResp['data'] != '[]') {
          listEquipment = (decodeResp['data'] as List)
              .map((e) => EquipmentModel.fromJson(e))
              .toList();
        } else {
          listEquipment = [];
        }
      }
      if (response.statusCode == 200 && decodeResp['success'] == false) {
        Get.snackbar(
            'Warning', 'Please try it later, we can not connect with the app.',
            colorText: Colors.white,
            backgroundColor: Colors.redAccent,
            snackPosition: SnackPosition.BOTTOM);
        listEquipment = [];
      }
      update();
      // }
    } catch (e) {
      Get.snackbar('Error', 'There was a problem connecting to the server.',
          colorText: Colors.white,
          backgroundColor: Colors.redAccent,
          snackPosition: SnackPosition.BOTTOM);
      listEquipment = [];
    }
  }

  getEquipmentsNotWIfi() async {
    try {
      final response = await EquipmentSQL().getEquipmentTrucksSQL();

      //    Map<String, dynamic> decodeResp = json.decode(response.body);

      if (response['statusCode'] == 200 && response['success'] == true) {
        if (response.containsKey('data') && response['data'] != null) {
          List listEquiCome = response['data'] as List;
          for (var element in listEquiCome) {
            listEquipment.add(element);
          }
        } else {
          listEquipment = [];
        }
      }
      if (response['statusCode'] == 200 && response['success'] == false) {
        Get.snackbar(
            'Warning', 'Please try it later, we can not connect with the app.',
            colorText: Colors.white,
            backgroundColor: Colors.redAccent,
            snackPosition: SnackPosition.BOTTOM);
        listEquipment = [];
      }
      update();
      // }
    } catch (e) {
      Get.snackbar('Error', 'There was a problem connecting to the server.',
          colorText: Colors.white,
          backgroundColor: Colors.redAccent,
          snackPosition: SnackPosition.BOTTOM);
      listEquipment = [];
    }
  }

  //Trailers
  getTrailers() async {
    try {
      //print(AccountPrefs.type);
      //loading dialog
      // if (AccountPrefs.type == 'driver' || AccountPrefs.type == 'operator') {
      final String urlApi = '${api.api}/${api.trailers}'; //url/api/login
      print(urlApi);
      final header = {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${AccountPrefs.token}',
      };

      final response = await http.get(Uri.parse(urlApi), headers: header);

      Map<String, dynamic> decodeResp = json.decode(response.body);
      print('Trailers ==> $decodeResp');
      if (response.statusCode == 200 && decodeResp['success'] == true) {
        if (decodeResp.containsKey('data') && decodeResp['data'] != '[]') {
          listTrailers = (decodeResp['data'] as List)
              .map((e) => EquipmentModel.fromJson(e))
              .toList();
        } else {
          listTrailers = [];
        }
      }
      if (response.statusCode == 200 && decodeResp['success'] == false) {
        Get.snackbar(
            'Warning', 'Please try it later, we can not connect with the app.',
            colorText: Colors.white,
            backgroundColor: Colors.redAccent,
            snackPosition: SnackPosition.BOTTOM);
        listTrailers = [];
      }
      update();
      //  }
    } catch (e) {
      Get.snackbar('Error', 'There was a problem connecting to the server.',
          colorText: Colors.white,
          backgroundColor: Colors.redAccent,
          snackPosition: SnackPosition.BOTTOM);
      listTrailers = [];
    }
  }

  getTrailersNotWIfi() async {
    try {
      final response = await EquipmentSQL().getEquipmentTrailersSQL();

      //    Map<String, dynamic> decodeResp = json.decode(response.body);

      if (response['statusCode'] == 200 && response['success'] == true) {
        if (response.containsKey('data') && response['data'] != null) {
          List listEquiCome = response['data'] as List;
          for (var element in listEquiCome) {
            listTrailers.add(element);
          }
        } else {
          listTrailers = [];
        }
      }
      if (response['statusCode'] == 200 && response['success'] == false) {
        Get.snackbar(
            'Warning', 'Please try it later, we can not connect with the app.',
            colorText: Colors.white,
            backgroundColor: Colors.redAccent,
            snackPosition: SnackPosition.BOTTOM);
        listTrailers = [];
      }
      update();
      // }
    } catch (e) {
      Get.snackbar('Error', 'There was a problem connecting to the server.',
          colorText: Colors.white,
          backgroundColor: Colors.redAccent,
          snackPosition: SnackPosition.BOTTOM);
      listTrailers = [];
    }
  }

  //Destinations
  _getDestinations() async {
    try {
      //loading dialog

      final String urlApi = '${api.api}/${api.destinations}'; //url/api/login

      final header = {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${AccountPrefs.token}',
      };

      final response = await http.get(Uri.parse(urlApi), headers: header);

      Map<String, dynamic> decodeResp = json.decode(response.body);

      if (response.statusCode == 200 && decodeResp['success'] == true) {
        if (decodeResp.containsKey('data') && decodeResp['data'] != '[]') {
          listDestinations = (decodeResp['data'] as List)
              .map((e) => DestinyOriginModel.fromJson(e))
              .toList();
        } else {
          listDestinations = [];
        }
      }
      if (response.statusCode == 200 && decodeResp['success'] == false) {
        Get.snackbar('Warning', 'Please try it later, we dont found data.',
            colorText: Colors.black,
            backgroundColor: Colors.redAccent,
            snackPosition: SnackPosition.BOTTOM);
        listDestinations = [];
      }
      update();
    } catch (e) {
      print(e.toString());
      Get.snackbar('Error', 'There was a problem connecting to the server.',
          colorText: Colors.white,
          backgroundColor: Colors.redAccent,
          snackPosition: SnackPosition.BOTTOM);
      return listDestinations = [];
    }
  }

  getDestinationsNOTWIFI() async {
    try {
      //loading dialog

      final response = await DestinationsSQL().getOriginsSQL();

      if (response['statusCode'] == 200 && response['success'] == true) {
        if (response.containsKey('data') && response['data'] != null) {
          List originListCome = response['data'] as List;
          for (var element in originListCome) {
            listDestinations.add(element);
          }
          // listDestinations = (response['data'] as List)
          //     .map((e) => DestinyOriginModel.fromJson(e))
          //     .toList();
        } else {
          listDestinations = [];
        }
      }
      if (response['statusCode'] == 200 && response['success'] == false) {
        Get.snackbar('Warning', 'Please try it later, we dont found data.',
            colorText: Colors.black,
            backgroundColor: Colors.redAccent,
            snackPosition: SnackPosition.BOTTOM);
        listDestinations = [];
      }
      update();
      return listDestinations;
    } catch (e) {
      print(e.toString());
      Get.snackbar('Error', 'There was a problem connecting to the server.',
          colorText: Colors.white,
          backgroundColor: Colors.redAccent,
          snackPosition: SnackPosition.BOTTOM);
      return listDestinations = [];
    }

    //END FUNC
  }

  // downloadDataToApp() async {
  //   await EquipmentSQL().trucateEquipment();
  //   await DestinationsSQL().trucateOrigins();

  // }

  clearPad() {
    singnature1Control.clear();
    update();
  }

  clearPad2() {
    singnature2Control.clear();
    update();
  }
  //END CLASS
}
