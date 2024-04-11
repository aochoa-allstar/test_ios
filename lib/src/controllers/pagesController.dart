// ignore_for_file: unrelated_type_equality_checks

import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:location/location.dart';
import 'package:onax_app/src/controllers/addNewTicketController.dart';
import 'package:onax_app/src/controllers/connectionManagerController.dart';
import 'package:onax_app/src/controllers/homeController.dart';
import 'package:onax_app/src/repositories/models/customerModel.dart';
import 'package:onax_app/src/repositories/models/equipmentModel.dart';
import 'package:onax_app/src/repositories/models/projectModel.dart';
import 'package:onax_app/src/repositories/models/ticketModel.dart';
import 'package:onax_app/src/repositories/models/workersModel.dart';
import 'package:onax_app/src/services/sqlite/sqlite_customer.dart';
import 'package:onax_app/src/services/sqlite/sqlite_destinations.dart';
import 'package:onax_app/src/services/sqlite/sqlite_equipment.dart';
import 'package:onax_app/src/services/sqlite/sqlite_inspections.dart';
import 'package:onax_app/src/services/sqlite/sqlite_jsas.dart';
import 'package:onax_app/src/services/sqlite/sqlite_origins.dart';
import 'package:onax_app/src/services/sqlite/sqlite_project.dart';
import 'package:onax_app/src/services/sqlite/sqlite_tickets.dart';
import 'package:onax_app/src/services/sqlite/sqlite_workers.dart';
import 'package:onax_app/src/utils/sharePrefs/accountPrefs.dart';
import 'package:onax_app/src/utils/urlApi/globalApi.dart';

import '../repositories/models/desty_origin_Model.dart';
import '../services/checkNetwork.dart';
import 'createShiftController.dart';
// import 'package:permission_handler/permission_handler.dart'
//     as PermissionsHandler;

class PagesConroller extends GetxController {
  final GlobalApi api = GlobalApi();
  late int selectedIndex;
  late PageController _pageController;
  PageController get pageController => _pageController;
  // Map _source = {ConnectivityResult.none: false};
  // late bool? statusConnection;
  // late NetworkConnectivity? _networkConnectivity;
  //late int intPage;
  // late bool locationEnabled;
  // late PermissionStatus statusLocation;
  // late bool permissionGranted;
  // late RxBool permissionUpdated;
  // late RxBool locationEnabledUpdate;
  // late RxBool backgrounLocation;

  // late Timer? locationTimer;

  Location location = Location();
  late ConnectionManagerController connectionManagerController;
  @override
  void onInit() async {
    // connectionManagerController = Get.find<ConnectionManagerController>();
    //intPage = Get.arguments['page'] ?? 0;
    selectedIndex = 0;
    _pageController = PageController(
      initialPage: 0,
      keepPage: true,
    );
    connectionManagerController = Get.put(ConnectionManagerController());
    // checkNetWokr();
    //await initLocation();
    super.onInit();
  }

  @override
  void onReady() async {
    // isLocationPermissionGranted().then((value) {
    //   permissionGranted = value;
    //   update();
    // });
    // isLocationEnabled().then((value) {
    //   locationEnabled = value;
    //   update();
    // });
    //ever(statusLocation, callback)
    super.onReady();
  }

  @override
  void onClose() {
    Get.delete<PagesConroller>();
    super.onClose();
  }

  void selectBtmItemMenu(int index) {
    selectedIndex = index;
    update();
  }

  sendToViewTicketTosing() {
    Get.back();
    return Get.offNamed('/ticketToSignature');
  }

  sendToViewToSaveDestiantion() {
    Get.back();
    return Get.offAllNamed('/addDestination');
  }

  sendToViewToSaveProject() {
    Get.back();
    return Get.offAllNamed('/addProject');
  }
}
