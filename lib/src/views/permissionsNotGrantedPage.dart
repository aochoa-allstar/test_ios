// ignore_for_file: prefer_const_constructors_in_immutables, library_private_types_in_public_api, library_prefixes

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:location/location.dart';
// import 'package:onax_app/app.dart';
import 'package:onax_app/src/controllers/pagesController.dart';
import 'package:onax_app/src/repositories/services/locationPermision.dart';
import 'package:permission_handler/permission_handler.dart'
    as PermissionHandler;
import 'components/button_widget.dart';

class PermissionsNotGrantedPage extends StatefulWidget {
  //final PagesConroller controller;
  PermissionsNotGrantedPage({
    Key? key,
  }) : super(key: key);

  @override
  State<PermissionsNotGrantedPage> createState() =>
      _PermissionsNotGrantedPageState();
}

class _PermissionsNotGrantedPageState extends State<PermissionsNotGrantedPage> {
  bool _permissionGranted = false;
  bool _locationEnabled = false;
  PermissionStatus newStatus = PermissionStatus.denied;

  PagesConroller pgs = Get.put(PagesConroller());

  @override
  void initState() {
    isLocationPermissionGranted().then((value) {
      print('isLocationPermissionGranted => $value');
      setState(() {
        _permissionGranted = value;
      });
    });

    isLocationEnabled().then((value) {
      setState(() {
        _locationEnabled = value;
      });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Padding(padding: EdgeInsets.fromLTRB(24, 64, 24, 32)),
            Image.asset(
              'assets/img/splashLogo.png',
              height: 64,
            ),
            const SizedBox(
              height: 32,
            ),
            const Text(
              "Error with location service",
              style: TextStyle(fontSize: 21, color: Colors.red),
            ),
            const SizedBox(
              height: 12,
            ),
            Text(
              _locationEnabled == false
                  ? "You must keep your location on and provide location permissions to use OnaxApp!"
                  : "Please provide the acces Allow always the location for a better experince to use OnaxApp.",
              style: TextStyle(fontSize: 16),
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 32,
            ),
            if (_permissionGranted == false)
              /**!controller.permissionGranted */
              ButtonWidget("Grant Permissions", () {
                if (_permissionGranted == false) {
                  PermissionHandler.openAppSettings();
                  return;
                } else if (_locationEnabled && _permissionGranted == true) {
                  Get.offNamed('/pages');
                } else {
                  Get.snackbar('Success',
                      'Permission granted, turn on location service to continue',
                      backgroundColor: Colors.black38,
                      colorText: Colors.white,
                      snackPosition: SnackPosition.BOTTOM);
                }

                //await controller.pageaskForLocationPermission();
                //controller.onInit();
                // askForLocationPermission().then((status) {
                //   setState(() {
                //     _permissionGranted = status == PermissionStatus.granted;
                //     //newStatus = PermissionStatus.granted;
                //   });

                //   if (status == PermissionStatus.deniedForever) {
                //     PermissionHandler.openAppSettings();
                //     return;
                //   } else if (status == PermissionStatus.denied) {
                //     Get.snackbar(
                //         'Error', 'Grant location permissions to continue',
                //         backgroundColor: Colors.black38,
                //         colorText: Colors.white,
                //         snackPosition: SnackPosition.BOTTOM);

                //     return;
                //   } else if (_locationEnabled) {
                //     Get.offNamed('/pages');
                //   } else {
                //     Get.snackbar('Success',
                //         'Permission granted, turn on location service to continue',
                //         backgroundColor: Colors.black38,
                //         colorText: Colors.white,
                //         snackPosition: SnackPosition.BOTTOM);
                //   }
                // });
              }),
            if (_locationEnabled ==
                false) //!controller.locationEnabledUpdate.value
              ButtonWidget("Turn on Location", () async {
                // await controller.pageaskForLocationService();
                //await controller.pageaskForLocationService();
                //controller.onInit();
                askForLocationService().then((enabled) {
                  setState(() {
                    _locationEnabled = enabled;
                  });

                  if (!enabled) {
                    Get.snackbar(
                        'Success', 'Enable location service to continue',
                        backgroundColor: Colors.black38,
                        colorText: Colors.white,
                        snackPosition: SnackPosition.BOTTOM);

                    return;
                  } else if (_permissionGranted) {
                    Get.offNamed('/pages');
                    //Navigator.pushReplacementNamed(context, appPaths["dashboard"]!);
                  } else {
                    Get.snackbar('Success',
                        'Location enabled, grant location permissions to continue',
                        backgroundColor: Colors.black38,
                        colorText: Colors.white,
                        snackPosition: SnackPosition.BOTTOM);
                  }
                });
              }),
          ],
        ),
      ),
    );
  }
}
