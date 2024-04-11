import 'dart:convert';
import 'dart:io' as Io;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hand_signature/signature.dart';
import 'package:intl/intl.dart';
import 'package:location/location.dart';
import 'package:onax_app/src/controllers/connectionManagerController.dart';
import 'package:onax_app/src/repositories/models/customerModel.dart';
import 'package:onax_app/src/repositories/models/desty_origin_Model.dart';
import 'package:onax_app/src/repositories/models/projectModel.dart';
import 'package:onax_app/src/repositories/models/ticketModel.dart';
import 'package:onax_app/src/services/sqlite/sqlite_customer.dart';
import 'package:onax_app/src/services/sqlite/sqlite_destinations.dart';
import 'package:onax_app/src/services/sqlite/sqlite_jsas.dart';
import 'package:onax_app/src/services/sqlite/sqlite_project.dart';
import 'package:onax_app/src/services/sqlite/sqlite_tickets.dart';
import 'package:onax_app/src/services/sqlite/sqlite_workers.dart';
import 'package:onax_app/src/utils/sharePrefs/accountPrefs.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:http/http.dart' as http;
import '../repositories/models/workersModel.dart';
import '../utils/urlApi/globalApi.dart';

class JsasSteperFormController extends GetxController {
  final GlobalApi api = GlobalApi();
  late int currentSteperIndex;
  late RoundedLoadingButtonController btnNext;
  late int counterNextTimes;
  //general Info
  late List<WorkerModel> listWorkersHelpers;
  late TextEditingController location;
  late TextEditingController jobDescription;
  late TextEditingController company;
  late TextEditingController gps;
  late TextEditingController tasks;
  late TextEditingController hazards;
  late TextEditingController controls;
  late int pusherID, helperID, helperID2, companyID, projectID;
  late List<CustomerModel> companiesList;
  late List<ProjectModel> projectsList;
  //equipment safety
  late bool steelShoes;
  late bool hardHat;
  late bool safetyGlasses;
  late bool h2hMonitor;
  late bool frClothing;
  late bool fallProtection;
  late bool hearingProtection;
  late bool respirator;
  late bool otherEquipment;
  late TextEditingController otherEquipmentText;
  late bool moveScroll;
  //Hazards
  late bool fallPotencial;
  late bool overHeadLift;
  late bool h2s;
  late bool pinchPoints;
  late bool splipTrip;
  late bool sharpObjects;
  late bool powerTools;
  late bool hotClodSurface;
  late bool pressure;
  late bool droppedObjects;
  late bool heavyLifting;
  late bool weather;
  late bool flammables;
  late bool chemicals;
  late bool otherHazard;
  late TextEditingController otherHazardText;
  //permits Required
  late bool confinedSpacePermit;
  late bool hotWorkPermit;
  late bool excavationTrenching;
  late bool otherPermitRequiredCall;
  late TextEditingController otherPermitRequiredCallText;
  //checkAndReview
  late bool lockOutTagOut;
  late bool ladder;
  late bool fireExtinguisher;
  late bool permmits;
  late bool inspectionEquipment;
  late bool msdsReview;
  late bool otherCheckReview;
  late TextEditingController otherCheckReviewText;
  //Enviromental Concerns
  late bool weatherCondition;
  late bool windDirection;
  late TextEditingController otherWeatherContition;
  late TextEditingController otherWindDirection;
  //RecomendedActions
  late TextEditingController recomendedActions;
//signatures
  late HandSignatureControl handMusterPointsControl;
  late HandSignatureControl singnature1Control;
  late HandSignatureControl singnature2Control;
  late HandSignatureControl singnature3Control;
  late RoundedLoadingButtonController btnSave;
  //to convert to image
  late dynamic musterPointsPic;
  late dynamic singnature1Pic;
  late dynamic singnature2Pic;
  late dynamic singnature3Pic;
  final Location locations = Location();
  //late LocationData coordenates;
  late String sendCoords;
  late ConnectionManagerController connectionManagerController;
  late List<DestinyOriginModel> listDestinations;
  late String helperName, helperName2, companyName, projectName;

  late int locationSelected;
  late String locationSelectedTxt;

  int? ticketId = Get.arguments['ticketId'] ?? null;

  @override
  void onInit() async {
    helperName = '';
    helperName2 = '';
    companyID = 0;
    companyName = '';
    companiesList = [];
    projectID = 0;
    projectName = '';
    projectsList = [];
    listDestinations = [];
    sendCoords = '';
    locationSelected = 0;
    locationSelectedTxt = '';
    moveScroll = true;
    musterPointsPic = null;
    singnature1Pic = null;
    singnature2Pic = null;
    singnature3Pic = null;
    pusherID = 0;
    helperID = 0;
    helperID2 = 0;
    currentSteperIndex = 0;
    counterNextTimes = 0;
    location = TextEditingController();
    jobDescription = TextEditingController();
    company = TextEditingController();
    gps = TextEditingController();
    tasks = TextEditingController();
    controls = TextEditingController();
    hazards = TextEditingController();
    otherEquipmentText = TextEditingController();
    otherHazardText = TextEditingController();
    otherPermitRequiredCallText = TextEditingController();
    otherCheckReviewText = TextEditingController();
    otherWindDirection = TextEditingController();
    otherWeatherContition = TextEditingController();
    recomendedActions = TextEditingController();
    btnSave = RoundedLoadingButtonController();
    handMusterPointsControl = HandSignatureControl(
      threshold: 3.0,
      smoothRatio: 0.65,
      velocityRange: 2.0,
    );
    singnature1Control = HandSignatureControl(
      threshold: 3.0,
      smoothRatio: 0.3,
      velocityRange: 2.0,
    );
    singnature2Control = HandSignatureControl(
      threshold: 3.0,
      smoothRatio: 0.65,
      velocityRange: 2.0,
    );
    singnature3Control = HandSignatureControl(
      threshold: 3.0,
      smoothRatio: 0.65,
      velocityRange: 2.0,
    );
    listWorkersHelpers = [];
    btnNext = RoundedLoadingButtonController();
    steelShoes = false;
    hardHat = false;
    safetyGlasses = false;
    h2hMonitor = false;
    frClothing = false;
    fallProtection = false;
    hearingProtection = false;
    respirator = false;
    otherEquipment = false;
    fallPotencial = false;
    overHeadLift = false;
    h2s = false;
    pinchPoints = false;
    splipTrip = false;
    sharpObjects = false;
    powerTools = false;
    hotClodSurface = false;
    pressure = false;
    droppedObjects = false;
    heavyLifting = false;
    weather = false;
    flammables = false;
    chemicals = false;
    otherHazard = false;
    confinedSpacePermit = false;
    hotWorkPermit = false;
    excavationTrenching = false;
    otherPermitRequiredCall = false;
    lockOutTagOut = false;
    ladder = false;
    fireExtinguisher = false;
    permmits = false;
    inspectionEquipment = false;
    msdsReview = false;
    otherCheckReview = false;
    weatherCondition = false;
    windDirection = false;
    connectionManagerController = Get.put(ConnectionManagerController());
    // TODO: implement onInit
    super.onInit();
  }

  onStartPadDraw() {
    moveScroll = false;
    update();
  }

  onEndPadDraw() {
    moveScroll = true;
    update();
  }

  @override
  void onReady() async {
    LocationData coordenates = await locations.getLocation();
    sendCoords = '${coordenates.latitude}, ${coordenates.longitude}';
    gps.text = sendCoords;
    update();
    // TODO: implement onReady
    if (AccountPrefs.statusConnection == true) {
      await getHelpers();
      await _getTicketActive();
      await _getDestinations();
      await getCompanies();
      await getProjects();
    } else {
      await _getHelpersNotWIFI();
      await _getTicketActiveNotWifi();
      await getDestinationsNOTWIFI();
      await getCompaniesNOTWIFI();
      await getProjectsNOTWIFI();
    }

    super.onReady();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    Get.delete<JsasSteperFormController>();
    super.onClose();
  }

  _updateInfoTicket(TicketModel ticket) {
    locationSelected = ticket.destinationId > 0 ? ticket.destinationId : 1;

    update();
  }

  selectedLocation(String name) {
    locationSelectedTxt = name;
    update();
  }

  selectCompany(id) {
    var datos = id.toString().split(',');
    companyID = int.parse(datos[0].toString());
    companyName = datos[1];
    print(companyName);
    update();
  }

  selectProject(id) {
    var datos = id.toString().split(',');
    projectID = int.parse(datos[0].toString());
    projectName = datos[1];
    print(projectName);
    update();
  }

  steperCompleted(int step) {
    print(step);
    if (0 == currentSteperIndex) {
      if (jobDescription.text.isEmpty || gps.text.isEmpty) {
        Get.snackbar('Warning',
            'You cannot continue, all information is required in Job Description.',
            colorText: Colors.black,
            backgroundColor: Colors.yellow,
            snackPosition: SnackPosition.BOTTOM,
            duration: const Duration(seconds: 5));
        currentSteperIndex = 0;
      } else {
        if (step > currentSteperIndex) {
          currentSteperIndex = step;
          counterNextTimes++;
        }
      }
    } else if (currentSteperIndex > 0) {
      switch (currentSteperIndex) {
        case 6:
          if (tasks.text.isEmpty) {
            Get.snackbar(
                'Warning', 'You cannot continue, the tasks are required.',
                colorText: Colors.black,
                backgroundColor: Colors.yellow,
                snackPosition: SnackPosition.BOTTOM,
                duration: const Duration(seconds: 5));
            currentSteperIndex = 6;
          } else {
            if (step > currentSteperIndex) {
              currentSteperIndex = step;
              counterNextTimes++;
            }
          }
          break;
        case 7:
          if (hazards.text.isEmpty) {
            Get.snackbar(
                'Warning', 'You cannot continue, the hazards are required.',
                colorText: Colors.black,
                backgroundColor: Colors.yellow,
                snackPosition: SnackPosition.BOTTOM,
                duration: const Duration(seconds: 5));
            currentSteperIndex = 7;
          } else {
            if (step > currentSteperIndex) {
              currentSteperIndex = step;
              counterNextTimes++;
            }
          }
          break;
        case 8:
          if (controls.text.isEmpty) {
            Get.snackbar(
                'Warning', 'You cannot continue, the controls are required.',
                colorText: Colors.black,
                backgroundColor: Colors.yellow,
                snackPosition: SnackPosition.BOTTOM,
                duration: const Duration(seconds: 5));
            currentSteperIndex = 8;
          } else {
            if (step > currentSteperIndex) {
              currentSteperIndex = step;
              counterNextTimes++;
            }
          }
          break;
        default:
          if (step > currentSteperIndex) {
            currentSteperIndex = step;
            counterNextTimes++;
          }
      }
    }

    //7 => 6

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

  //load helpers and worker
  /*
 * GET the HELPERS
 */
  getHelpers() async {
    try {
      //loading dialog

      final String urlApi = '${api.api}/${api.getHelpers}';

      final header = {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${AccountPrefs.token}',
      };

      final response = await http.get(Uri.parse(urlApi), headers: header);
      // AccountPrefs.statusConnection == true
      //     ?
      //     : await WorkersSQL().getWorkersSQL();

      Map<String, dynamic> decodeResp = json.decode(response.body);

      print(decodeResp);

      if (response.statusCode == 200 && decodeResp['success'] == true) {
        if (decodeResp.containsKey('data') && decodeResp['data'] != '[]') {
          listWorkersHelpers = (decodeResp['data'] as List)
              .map((e) => WorkerModel.fromJson(e))
              .toList();
        } else {
          listWorkersHelpers = [];
        }
      }
      if (response.statusCode == 200 && decodeResp['success'] == false) {
        Get.snackbar(
            'Warning', 'Please try it later, we can not connect with the app.',
            colorText: Colors.white,
            backgroundColor: Colors.redAccent,
            snackPosition: SnackPosition.BOTTOM);
        listWorkersHelpers = [];
      }

      update();
    } catch (e) {
      Get.snackbar('Error', 'There was a problem connecting to the server.',
          colorText: Colors.white,
          backgroundColor: Colors.redAccent,
          snackPosition: SnackPosition.BOTTOM);
      listWorkersHelpers = [];
    }
  }

  _getHelpersNotWIFI() async {
    try {
      final response = await WorkersSQL().getWorkersSQL();

      if (response['statusCode'] == 200 && response['success'] == true) {
        if (response.containsKey('data') && response['data'] != null) {
          List listWorkCome = response['data'] as List;
          for (var element in listWorkCome) {
            listWorkersHelpers.add(element);
          }
          // listWorkersHelpers = (response['data'] as List)
          //     .map((e) => WorkerModel.fromJson(e))
          //     .toList();
        } else {
          listWorkersHelpers = [];
        }
      }
      if (response['statusCode'] == 200 && response['success'] == false) {
        Get.snackbar('Warning', 'Please try it later, we dont found workers.',
            colorText: Colors.white,
            backgroundColor: Colors.redAccent,
            snackPosition: SnackPosition.BOTTOM);
        listWorkersHelpers = [];
      }

      update();
    } catch (e) {
      Get.snackbar('Error', 'There was a problem connecting to the server.',
          colorText: Colors.white,
          backgroundColor: Colors.redAccent,
          snackPosition: SnackPosition.BOTTOM);
      listWorkersHelpers = [];
    }
  }

  //updates the checkboxes
  updateCheck(bool value, String type) {
    switch (type) {
      case 'steelShoes':
        steelShoes = value;
        break;
      case 'hardHat':
        hardHat = value;
        break;
      case 'safetyGlasses':
        safetyGlasses = value;
        break;
      case 'h2hMonitor':
        h2hMonitor = value;
        break;
      case 'frClothing':
        frClothing = value;
        break;
      case 'fallProtection':
        fallProtection = value;
        break;
      case 'hearingProtection':
        hearingProtection = value;
        break;
      case 'respirator':
        respirator = value;
        break;
      case 'otherEquipment':
        otherEquipment = value;
        break;
      case 'fallPotencial':
        fallPotencial = value;
        break;
      case 'overHeadLift':
        overHeadLift = value;
        break;
      case 'h2s':
        h2s = value;
        break;
      case 'pinchPoints':
        pinchPoints = value;
        break;
      case 'splipTrip':
        splipTrip = value;
        break;
      case 'sharpObjects':
        sharpObjects = value;
        break;
      case 'powerTools':
        powerTools = value;
        break;
      case 'hotClodSurface':
        hotClodSurface = value;
        break;
      case 'pressure':
        pressure = value;
        break;
      case 'droppedObjects':
        droppedObjects = value;
        break;
      case 'heavyLifting':
        heavyLifting = value;
        break;
      case 'weather':
        weather = value;
        break;
      case 'flammables':
        flammables = value;
        break;
      case 'chemicals':
        chemicals = value;
        break;
      case 'otherHazard':
        otherHazard = value;
        break;
      case 'confinedSpacePermit':
        confinedSpacePermit = value;
        break;
      case 'hotWorkPermit':
        hotWorkPermit = value;
        break;
      case 'excavationTrenching':
        excavationTrenching = value;
        break;
      case 'otherPermitRequiredCall':
        otherPermitRequiredCall = value;
        break;
      case 'lockOutTagOut':
        lockOutTagOut = value;
        break;
      case 'ladder':
        ladder = value;
        break;
      case 'fireExtinguisher':
        fireExtinguisher = value;
        break;
      case 'permmits':
        permmits = value;
        break;
      case 'inspectionEquipment':
        inspectionEquipment = value;
        break;
      case 'msdsReview':
        msdsReview = value;
        break;
      case 'otherCheckReview':
        otherCheckReview = value;
        break;
      case 'weatherCondition':
        weatherCondition = value;
        break;
      case 'windDirection':
        windDirection = value;
        break;
      default:
    }
    update();
  }

  selectHelper(id) {
    var datos = id.toString().split(',');
    helperID = int.parse(datos[0].toString());
    helperName = datos[1];
    update();
  }

  selectHelper2(id) {
    var datos = id.toString().split(',');
    helperID2 = int.parse(datos[0].toString());
    helperName2 = datos[1];
    //helperID2 = id;
    update();
  }

  ///convert signatures to image first before.
  convertPadToImg() async {
    if (handMusterPointsControl.isFilled) {
      var musterPointImg = await handMusterPointsControl.toImage(
        background: Colors.white,
        color: Colors.black,
        fit: true,
      );
      //print(musterPointImg!.buffer.asUint8List());
      Uint8List? imageBytes = musterPointImg!.buffer.asUint8List();
      final String base64MusterPoint = base64Encode(imageBytes);
      // print(base64);
      musterPointsPic = base64MusterPoint;
    } else {
      musterPointsPic = '';
    }

    if (singnature1Control.isFilled) {
      var singnatureImg = await singnature1Control.toImage(
        background: Colors.white,
        color: Colors.black,
        fit: true,
      );
      Uint8List? imageBytes = singnatureImg!.buffer.asUint8List();
      final String base64Singnature1 = base64Encode(imageBytes);
      // print(base64);
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
      final String base64Singnature2 = base64Encode(imageBytes);
      // print(base64);
      singnature2Pic = base64Singnature2;
    } else {
      singnature2Pic = '';
    }
    if (singnature3Control.isFilled) {
      var singnature3Img = await singnature3Control.toImage(
        background: Colors.white,
        color: Colors.black,
        fit: true,
      );
      Uint8List? imageBytes = singnature3Img!.buffer.asUint8List();
      final String base64Singnature3 = base64Encode(imageBytes);
      // print(base64);
      singnature3Pic = base64Singnature3;
    } else {
      singnature3Pic = '';
    }
  }

  ///Register JSas
  saveJSAs() async {
    try {
      //await _getShift();
      await convertPadToImg();
      // Location locations = Location();
      final String urlApi = '${api.api}/${api.createJSAs}';

      final header = {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${AccountPrefs.token}',
      };

      late DateTime date = DateTime.now().toUtc();
      String formatDate = DateFormat('yyyy-MM-dd').format(date);
      // LocationData coordenates = await locations.getLocation();
      // String sendCoords = '${coordenates.latitude}, ${coordenates.longitude}';
      final body = {
        //'destination_id',
        'customer_id': companyID,
        'project_id': projectID,
        'date': formatDate,
        'hazard': hazards.text.trim(),
        'controls': controls.text.trim(),
        'worker_id': AccountPrefs.idUser, //this references to pusher id
        'job_description': jobDescription.text.trim(),
        // 'company': 'Onax llc', //discarted column currently
        'gps': sendCoords,
        'helper': helperID,
        'helper2_id': helperID2,
        //'other_worker_id':other.text.trim(),
        'steel_toad_shoes': steelShoes == true ? 1 : 0,
        'hard_hat': hardHat == true ? 1 : 0,
        'safety_glasses': safetyGlasses == true ? 1 : 0,
        'h2s_monitor': h2s == true ? 1 : 0,
        'fr_clothing': frClothing == true ? 1 : 0,
        'fall_protection': fallProtection == true ? 1 : 0,
        'hearing_protection': hearingProtection == true ? 1 : 0,
        'respirator': respirator == true ? 1 : 0,
        'other_safety_equipment': otherEquipment == true ? 1 : 0,
        'other_safety_equipment_name': otherEquipmentText.text.trim(),
        'fail_potential': fallPotencial == true ? 1 : 0,
        'overhead_lift': overHeadLift == true ? 1 : 0,
        'h2s': h2s == true ? 1 : 0,
        'pinch_points': pinchPoints == true ? 1 : 0,
        'slip_trip': splipTrip == true ? 1 : 0,
        'sharp_objects': sharpObjects == true ? 1 : 0,
        'power_tools': powerTools == true ? 1 : 0,
        'hot_cold_surface': hotClodSurface == true ? 1 : 0,
        'pressure': pressure == true ? 1 : 0,
        'dropped_objects': droppedObjects == true ? 1 : 0,
        'heavy_lifting': heavyLifting == true ? 1 : 0,
        'weather': weather == true ? 1 : 0,
        'flammables': flammables == true ? 1 : 0,
        'chemicals': chemicals == true ? 1 : 0,
        'other_hazards': otherHazard == true ? 1 : 0,
        'other_hazards_name': otherHazardText.text.trim(),
        'confined_spaces_permits': confinedSpacePermit == true ? 1 : 0,
        'hot_work_permit': hotWorkPermit == true ? 1 : 0,
        'excavation_trenching': excavationTrenching == true ? 1 : 0,
        'one_call': otherPermitRequiredCall == true ? 1 : 0,
        'one_call_num': otherPermitRequiredCallText.text.trim(),
        'lock_out_tag_out': lockOutTagOut == true ? 1 : 0,
        'fire_extinguisher': fireExtinguisher == true ? 1 : 0,
        'inspection_of_equipment': inspectionEquipment == true ? 1 : 0,
        'msds_review': msdsReview == true ? 1 : 0,
        'ladder': ladder == true ? 1 : 0,
        'permits': permmits == true ? 1 : 0,
        'other_check_review': otherCheckReview == true ? 1 : 0,
        'other_check_review_name': otherCheckReviewText.text.trim(),
        'weather_condition': weatherCondition == true ? 1 : 0,
        'weather_condition_description': otherWeatherContition.text.trim(),
        'wind_direction': windDirection == true ? 1 : 0,
        'wind_direction_description': otherWindDirection.text.trim(),
        'task': tasks.text.trim(),
        'muster_points': musterPointsPic,
        'recommended_actions_and_procedures': recomendedActions.text.trim(),
        'signature1': singnature1Pic,
        'signature2': singnature2Pic,
        'signature3': singnature3Pic,
        'coords': sendCoords,
        'location': locationSelectedTxt,
        'ticket_id': ticketId,
      };
      //print(sendCoords);
      if (validateDataRequired()) {
        final response = await http.post(Uri.parse(urlApi),
            headers: header, body: json.encode(body));

        print(response.body);

        Map<String, dynamic> decodeResp = json.decode(response.body);

        print(decodeResp['data']);
        if (response.statusCode == 200 && decodeResp['success'] == true) {
          if (decodeResp['data'].containsKey('jsasID')) {
            //clean the inputs and show snackbar.
            //1show snackbar
            Get.snackbar('Success', 'JSAs has been created.',
                colorText: Colors.black,
                backgroundColor: Colors.greenAccent,
                duration: const Duration(seconds: 4),
                snackPosition: SnackPosition.BOTTOM);
            _cleanVariables();
            Get.back(canPop: true);
          }
        } else {
          Get.snackbar(
              'Warning', 'Please try it later, we not found information.',
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

  saveJSAsNotWIFI() async {
    try {
      //await _getShift();
      await convertPadToImg();
      Location locations = Location();

      late DateTime date = DateTime.now().toUtc();
      String formatDate = DateFormat('yyyy-MM-dd').format(date);
      LocationData coordenates = await locations.getLocation();
      String sendCoords = '${coordenates.latitude}, ${coordenates.longitude}';
      final body = {
        //'destination_id',
        'customer_id': companyID,
        'project_id': projectID,
        'date': formatDate,
        'hazard': hazards.text.trim(),
        'controls': controls.text.trim(),
        'worker_id': AccountPrefs.idUser, //this references to pusher id
        'job_description': jobDescription.text.trim(),
        'company': company.text.trim(),
        'gps': gps.text.trim(),
        'helper': helperID,
        'helper2_id': helperID2,
        //'other_worker_id':other.text.trim(),
        'steel_toad_shoes': steelShoes == true ? 1 : 0,
        'hard_hat': hardHat == true ? 1 : 0,
        'safety_glasses': safetyGlasses == true ? 1 : 0,
        'h2s_monitor': h2s == true ? 1 : 0,
        'fr_clothing': frClothing == true ? 1 : 0,
        'fall_protection': fallProtection == true ? 1 : 0,
        'hearing_protection': hearingProtection == true ? 1 : 0,
        'respirator': respirator == true ? 1 : 0,
        'other_safety_equipment': otherEquipment == true ? 1 : 0,
        'other_safety_equipment_name': otherEquipmentText.text.trim(),
        'fail_potential': fallPotencial == true ? 1 : 0,
        'overhead_lift': overHeadLift == true ? 1 : 0,
        'h2s': h2s == true ? 1 : 0,
        'pinch_points': pinchPoints == true ? 1 : 0,
        'slip_trip': splipTrip == true ? 1 : 0,
        'sharp_objects': sharpObjects == true ? 1 : 0,
        'power_tools': powerTools == true ? 1 : 0,
        'hot_cold_surface': hotClodSurface == true ? 1 : 0,
        'pressure': pressure == true ? 1 : 0,
        'dropped_objects': droppedObjects == true ? 1 : 0,
        'heavy_lifting': heavyLifting == true ? 1 : 0,
        'weather': weather == true ? 1 : 0,
        'flammables': flammables == true ? 1 : 0,
        'chemicals': chemicals == true ? 1 : 0,
        'other_hazards': otherHazard == true ? 1 : 0,
        'other_hazards_name': otherHazardText.text.trim(),
        'confined_spaces_permits': confinedSpacePermit == true ? 1 : 0,
        'hot_work_permit': hotWorkPermit == true ? 1 : 0,
        'excavation_trenching': excavationTrenching == true ? 1 : 0,
        'one_call': otherPermitRequiredCall == true ? 1 : 0,
        'one_call_num': otherPermitRequiredCallText.text.trim(),
        'lock_out_tag_out': lockOutTagOut == true ? 1 : 0,
        'fire_extinguisher': fireExtinguisher == true ? 1 : 0,
        'inspection_of_equipment': inspectionEquipment == true ? 1 : 0,
        'msds_review': msdsReview == true ? 1 : 0,
        'ladder': ladder == true ? 1 : 0,
        'permits': permmits == true ? 1 : 0,
        'other_check_review': otherCheckReview == true ? 1 : 0,
        'other_check_review_name': otherCheckReviewText.text.trim(),
        'weather_condition': weatherCondition == true ? 1 : 0,
        'weather_condition_description': otherWeatherContition.text.trim(),
        'wind_direction': windDirection == true ? 1 : 0,
        'wind_direction_description': otherWindDirection.text.trim(),
        'task': tasks.text.trim(),
        'muster_points': musterPointsPic,
        'recommended_actions_and_procedures': recomendedActions.text.trim(),
        'signature1': singnature1Pic,
        'signature2': singnature2Pic,
        'signature3': singnature3Pic,
        'coords': sendCoords,
        'location': locationSelectedTxt,
        'ticket_id': ticketId
      };
      //print(sendCoords);
      if (validateDataRequired()) {
        final response = await JsasSQL().insertJSAsSQL(body);
        print(response['data']);
        if (response['statusCode'] == 200 && response['success'] == true) {
          if (response['data'].containsKey('jsasID')) {
            //clean the inputs and show snackbar.
            //1show snackbar
            Get.snackbar('Success', 'JSAs has been created.',
                colorText: Colors.black,
                backgroundColor: Colors.greenAccent,
                duration: const Duration(seconds: 4),
                snackPosition: SnackPosition.BOTTOM);
            _cleanVariables();
            Get.back(canPop: true);
          }
        } else {
          Get.snackbar(
              'Warning', 'Please try it later, we not found information.',
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

  _cleanVariables() {
    musterPointsPic = null;
    singnature1Pic = null;
    singnature2Pic = null;
    singnature3Pic = null;
    pusherID = 0;
    helperID = 0;
    helperID2 = 0;
    currentSteperIndex = 0;
    counterNextTimes = 0;
    steelShoes = false;
    hardHat = false;
    safetyGlasses = false;
    h2hMonitor = false;
    frClothing = false;
    fallProtection = false;
    hearingProtection = false;
    respirator = false;
    otherEquipment = false;
    fallPotencial = false;
    overHeadLift = false;
    h2s = false;
    pinchPoints = false;
    splipTrip = false;
    sharpObjects = false;
    powerTools = false;
    hotClodSurface = false;
    pressure = false;
    droppedObjects = false;
    heavyLifting = false;
    weather = false;
    flammables = false;
    chemicals = false;
    otherHazard = false;
    confinedSpacePermit = false;
    hotWorkPermit = false;
    excavationTrenching = false;
    otherPermitRequiredCall = false;
    lockOutTagOut = false;
    ladder = false;
    fireExtinguisher = false;
    permmits = false;
    inspectionEquipment = false;
    msdsReview = false;
    otherCheckReview = false;
    weatherCondition = false;
    windDirection = false;
    location.text = '';
    jobDescription.text = '';
    company.text = '';
    gps.text = '';
    tasks.text = '';
    controls.text = '';
    hazards.text = '';
    otherEquipmentText.text = '';
    otherHazardText.text = '';
    otherPermitRequiredCallText.text = '';
    otherCheckReviewText.text = '';
    otherWindDirection.text = '';
    otherWeatherContition.text = '';
    recomendedActions.text = '';
    btnSave.reset();
    handMusterPointsControl.clear();
    singnature1Control.clear();
    singnature2Control.clear();
    singnature3Control.clear();

    update();
  }

  //validate a require dataObject
  validateDataRequired() {
    late String message = '';
    late bool flag = false;

    if (tasks.text.isEmpty) {
      message += 'The area of Task cannot be empty. Please fill it\n.';
    }
    if (hazards.text.isEmpty) {
      message += 'The area of Hazards cannot be empty. Please fill it\n';
    }
    if (controls.text.isEmpty) {
      message += 'The area of Controls cannot be empty. Please fill it\n';
    }
    if (jobDescription.text.isEmpty) {
      message += 'The Job Description cannot be empty. Please fill it\n';
    }
    if (singnature1Pic.isEmpty) {
      message += 'The JSAs need to be signature by you. Please signature it\n';
    }
    if (helperID > 0 && singnature2Pic.isEmpty) {
      message +=
          'Do you have a Helper please provide the signature of the Helper. Please signature it\n';
    }
    if (helperID2 > 0 && singnature3Pic.isEmpty) {
      message +=
          'Do you have a second Helper please provide the signature of the second Helper. Please signature it\n';
    }
    // if (locationSelectedTxt.isEmpty) {
    //   message += 'The location cannot be empty. Please fill it\n';
    // }
    // if (gps.text.isEmpty) {
    //   message += 'The gps cannot be empty. Please fill it\n';
    // }
    // if (company.text.isEmpty) {
    //   message += 'The company cannot be empty. Please fill it\n';
    // }
    if (musterPointsPic.isEmpty) {
      message +=
          'The JSAs need to be the muster points by you. Please fill it\n';
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

  ///
  _getTicketActive() async {
    try {
      print(AccountPrefs.hasOpenTicke);
      final String urlApi =
          '${api.api}/${api.getTicketActive}${AccountPrefs.hasOpenTicke}';
      //print(urlApi);
      final header = {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${AccountPrefs.token}',
      };

      final response = await http.get(
        Uri.parse(urlApi),
        headers: header,
      );
      Map<String, dynamic> decodeResp = json.decode(response.body);
      if (response.statusCode == 200 && decodeResp['success'] == true) {
        if (decodeResp['data'].length > 0) {
          late List dataObject = decodeResp['data'] as List;
          print(dataObject[0]);
          TicketModel ticket = TicketModel.fromJson(dataObject.first);
          print(ticket.id);
          print(AccountPrefs.hasOpenTicke);

          _updateInfoTicket(ticket);
          update();
        }
      } else {
        Get.snackbar('Warning',
            'Please try it later, we not found information. Of ticket active',
            colorText: Colors.black,
            backgroundColor: Colors.yellow,
            snackPosition: SnackPosition.BOTTOM);
      }
      update();
    } catch (e) {
      print(e.toString());
      Get.snackbar('Error',
          'There was a problem connecting to the server. Get info ticket',
          colorText: Colors.white,
          backgroundColor: Colors.redAccent,
          snackPosition: SnackPosition.BOTTOM);
    }
  }

  _getTicketActiveNotWifi() async {
    try {
      //AccountPrefs.hasOpenTicke
      final response =
          await TicketsSQL().getActiveTicketSQL(AccountPrefs.hasOpenTicke);
      //  Map<String, dynamic> decodeResp = json.decode(response.body);
      if (response['statusCode'] == 200 && response['success'] == true) {
        if (response['data'] != null) {
          // late List dataObject = response['data'] as List;
          // print(dataObject[0]);
          TicketModel ticket =
              response['data']; //TicketModel.fromJson(dataObject.first);
          print(ticket.id);
          print(AccountPrefs.hasOpenTicke);

          _updateInfoTicket(ticket);
          update();
        }
      } else {
        Get.snackbar('Warning',
            'Please try it later, we not found information. Of ticket active',
            colorText: Colors.black,
            backgroundColor: Colors.yellow,
            snackPosition: SnackPosition.BOTTOM);
      }
      update();
    } catch (e) {
      print(e.toString());
      Get.snackbar('Error',
          'There was a problem connecting to the server. Get info ticket',
          colorText: Colors.white,
          backgroundColor: Colors.redAccent,
          snackPosition: SnackPosition.BOTTOM);
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
  }

  getCompanies() async {
    try {
      final String urlApi = '${api.api}/${api.getCustomers}'; //url/api/login

      final header = {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${AccountPrefs.token}',
      };

      final response = await http.get(Uri.parse(urlApi), headers: header);

      Map<String, dynamic> decodeResp = json.decode(response.body);

      print(decodeResp);

      if (response.statusCode == 200 && decodeResp['success'] == true) {
        if (decodeResp.containsKey('data') && decodeResp['data'] != '[]') {
          companiesList = (decodeResp['data'] as List)
              .map((e) => CustomerModel.fromJson(e))
              .toList();
        } else {
          companiesList = [];
        }
      }
      if (response.statusCode == 200 && decodeResp['success'] == false) {
        Get.snackbar(
            'Warning', 'Please try it later, we can not connect with the app.',
            colorText: Colors.white,
            backgroundColor: Colors.redAccent,
            snackPosition: SnackPosition.BOTTOM);
        companiesList = [];
      }

      update();
    } catch (e) {
      Get.snackbar('Error', 'There was a problem connecting to the server.',
          colorText: Colors.white,
          backgroundColor: Colors.redAccent,
          snackPosition: SnackPosition.BOTTOM);
      companiesList = [];
    }
  }

  getCompaniesNOTWIFI() async {
    try {
      //loading dialog

      final response = await CustomerSQL().getCustomersSQL();

      if (response['statusCode'] == 200 && response['success'] == true) {
        if (response.containsKey('data') && response['data'] != null) {
          List customerListCome = response['data'] as List;
          for (var element in customerListCome) {
            companiesList.add(element);
          }
          // companiesList = (response['data'] as List)
          //     .map((e) => DestinyOriginModel.fromJson(e))
          //     .toList();
        } else {
          companiesList = [];
        }
      }
      if (response['statusCode'] == 200 && response['success'] == false) {
        Get.snackbar('Warning', 'Please try it later, we dont found data.',
            colorText: Colors.black,
            backgroundColor: Colors.redAccent,
            snackPosition: SnackPosition.BOTTOM);
        companiesList = [];
      }
      update();
      return companiesList;
    } catch (e) {
      print(e.toString());
      Get.snackbar('Error', 'There was a problem connecting to the server.',
          colorText: Colors.white,
          backgroundColor: Colors.redAccent,
          snackPosition: SnackPosition.BOTTOM);
      return companiesList = [];
    }
  }

  getProjects() async {
    try {
      final String urlApi =
          '${api.api}/${api.getAllProjectsInApp}'; //url/api/login

      final header = {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${AccountPrefs.token}',
      };

      final response = await http.get(Uri.parse(urlApi), headers: header);

      Map<String, dynamic> decodeResp = json.decode(response.body);

      print(decodeResp);

      if (response.statusCode == 200 && decodeResp['success'] == true) {
        if (decodeResp.containsKey('data') && decodeResp['data'] != '[]') {
          projectsList = (decodeResp['data'] as List)
              .map((e) => ProjectModel.fromJson(e))
              .toList();
        } else {
          projectsList = [];
        }
      }
      if (response.statusCode == 200 && decodeResp['success'] == false) {
        Get.snackbar(
            'Warning', 'Please try it later, we can not connect with the app.',
            colorText: Colors.white,
            backgroundColor: Colors.redAccent,
            snackPosition: SnackPosition.BOTTOM);
        projectsList = [];
      }

      update();
    } catch (e) {
      Get.snackbar('Error', 'There was a problem connecting to the server.',
          colorText: Colors.white,
          backgroundColor: Colors.redAccent,
          snackPosition: SnackPosition.BOTTOM);
      projectsList = [];
    }
  }

  getProjectsNOTWIFI() async {
    try {
      //loading dialog

      final response = await ProjectsSQL().getALLProjectsSQL();

      if (response['statusCode'] == 200 && response['success'] == true) {
        if (response.containsKey('data') && response['data'] != null) {
          List projectsListCome = response['data'] as List;
          for (var element in projectsListCome) {
            projectsList.add(element);
          }
          // projectsList = (response['data'] as List)
          //     .map((e) => DestinyOriginModel.fromJson(e))
          //     .toList();
        } else {
          projectsList = [];
        }
      }
      if (response['statusCode'] == 200 && response['success'] == false) {
        Get.snackbar('Warning', 'Please try it later, we dont found data.',
            colorText: Colors.black,
            backgroundColor: Colors.redAccent,
            snackPosition: SnackPosition.BOTTOM);
        projectsList = [];
      }
      update();
      return projectsList;
    } catch (e) {
      print(e.toString());
      Get.snackbar('Error', 'There was a problem connecting to the server.',
          colorText: Colors.white,
          backgroundColor: Colors.redAccent,
          snackPosition: SnackPosition.BOTTOM);
      return projectsList = [];
    }
  }

  clearPad() {
    singnature1Control.clear();
    update();
  }

  clearPad2() {
    singnature2Control.clear();
    update();
  }

  clearPad3() {
    singnature3Control.clear();
    update();
  }

  clearMosterPoints() {
    handMusterPointsControl.clear();
    update();
  }
  //END CLASS
}
