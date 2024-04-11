import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:location/location.dart';
import 'package:onax_app/src/services/sqlite/sqlite_location.dart';
import 'package:onax_app/src/utils/sharePrefs/accountPrefs.dart';
import 'package:onax_app/src/views/permissionsNotGrantedPage.dart';
import 'package:permission_handler/permission_handler.dart'
    as PermissionHandler;

Location location = Location();
late Timer? locationTimer = null;
Future<dynamic> initLocation() async {
  // Enable this line if you want to enable background location in the future
  //location.enableBackgroundMode(enable: true);
  late bool flagLocation = false;
  bool locationEnabled = await isLocationEnabled();

  if (locationEnabled) {
    //bool enable = await askForLocationService();
    bool permissionGranted = await isLocationPermissionGranted();
    if (!permissionGranted) {
      flagLocation = false;
      return Future.error('Location services are disabled.');
    } else {
      flagLocation = true;
    }
  }

  bool permissionGranted = await isLocationPermissionGranted();
  if (!permissionGranted) {
    // PermissionStatus statusLocation = await askForLocationPermission();

    // if (statusLocation != PermissionStatus.granted) {
    //   flagLocation = false;
    //   return Future.error('Location permissions are denied');
    // } else {
    //   flagLocation = true;
    // }
    flagLocation = false;
  } else {
    flagLocation = true;
  }
  return flagLocation;
}

Future<bool> isLocationEnabled() async {
  return await location.serviceEnabled();
  //return await Permission.locationAlways.serviceStatus.isEnabled;
}

Future<bool> askForLocationService() async {
  return await location.requestService();
  //return await Permission.locationAlways.request();
}

Future<bool> isLocationPermissionGranted() async {
  //location.enableBackgroundMode(enable: true);
  return await location.hasPermission() == PermissionStatus.granted;
}

Future<PermissionStatus> askForLocationPermission() async {
  return await location.requestPermission();
}

Future<bool> backgroundModeCheck() async {
  location.enableBackgroundMode(enable: true);
  return await location.isBackgroundModeEnabled();
}

startStreamLocation() async {
  Location location = new Location();

  int updateFrecuency = _getLocationUpdateFrecuency();

  locationTimer =
      Timer.periodic(Duration(seconds: updateFrecuency), (Timer t) async {
    if (await isLocationEnabled() && await isLocationPermissionGranted()) {
      _sendLocation(location);
    }
    // else {
    //   PermissionsNotGrantedPage();
    // }
  });
}

_getLocationUpdateFrecuency() {
  // List appConfigs =
  //     _prefs.appConfigs != null ? jsonDecode(_prefs.appConfigs!) : [];
  var streamFrecuency = 30;

  // // if (appConfigs.isNotEmpty) {
  //   dynamic locationUpdateFrecuency = appConfigs
  //       .firstWhere((element) => element['key'] == 'location_update_frecuency');

  //   if (locationUpdateFrecuency['value'] != null)
  //     streamFrecuency = locationUpdateFrecuency['value'];
  // // }

  return streamFrecuency;
}

createLocation(double latitude, double longitude, double speed) async {
  try {
    //
    Map<String, dynamic> body = {
      'latitude': latitude,
      'longitude': longitude,
      'speed': speed,
      'status': AccountPrefs.statusTicket,
      'ticket_id': AccountPrefs.hasOpenTicke,
      'worker_id': AccountPrefs.idUser,
    };
    await LocationSQL().updateLastLocation(body);
  } catch (e) {
    //
    Get.snackbar(
        'Error', 'There was a problem connecting to the server. Send location',
        colorText: Colors.white,
        backgroundColor: Colors.redAccent,
        snackPosition: SnackPosition.BOTTOM);
  }
}

_sendLocation(Location location, [lastRequest = false]) async {
  bool flag = false;
  //Map<String, dynamic> locationStatus = userProvider.getCurrentStatus();
  LocationData locationData = await location.getLocation();
  //logic to verify if local variable has info and send location to server
  // if (_prefs.locationServer == '') {

  // }
  if (AccountPrefs.locationServer != '') {
    //calulate the current location with the save location and make sure if we have out in the range of 10mts
    //es mayor a 10mts setear variable local con la nueva location and set bool flag true
    double _maxDistance = 10;
    var previousLocations = AccountPrefs.locationServer.split(',');
    double previousLatitude = double.parse(previousLocations[0]);
    double previousLongitude = double.parse(previousLocations[1]);
    double currentLatitude = double.parse(locationData.latitude.toString());
    double currentLongitude = double.parse(locationData.longitude.toString());
    var _distanceBetweenLastTwoLocations = Geolocator.distanceBetween(
      previousLatitude,
      previousLongitude,
      currentLatitude,
      currentLongitude,
    );
    if (_distanceBetweenLastTwoLocations >= _maxDistance) {
      flag = true;
      AccountPrefs.locationServer = '$currentLatitude,$currentLongitude';
    }
  } else {
    AccountPrefs.locationServer =
        '${locationData.latitude},${locationData.longitude}';
    flag = true;
  }

  if (flag) {
    //update last register with finalDate and create newOne
    await createLocation(
        locationData.latitude!, locationData.longitude!, locationData.speed!);
    await LocationSQL().uploadToServer();
  }
}
