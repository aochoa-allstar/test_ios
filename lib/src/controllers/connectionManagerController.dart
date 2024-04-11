import 'dart:async';
import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

import 'package:onax_app/src/utils/sharePrefs/accountPrefs.dart';
import 'package:http/http.dart' as http;

class ConnectionManagerController extends GetxController {
  int connectionType = 0;
  final Connectivity _connectivity = Connectivity();
  // late bool? statusConnection;
  // // late NetworkConnectivity? _networkConnectivity;

  late StreamSubscription _streamSubscription;

  @override
  void onInit() async {
    getConnectivityType();
    // _checkConnection();
    _streamSubscription =
        _connectivity.onConnectivityChanged.listen(checkNetWokr);
    super.onInit();
  }

  void getConnectivityType() async {
    late ConnectivityResult result;
    try {
      result = await (_connectivity.checkConnectivity());
    } on SocketException catch (_) {
      if (kDebugMode) {
        print(_);
      }
    }

    checkNetWokr(result);
  }

  // void _checkConnection() async {
  //   late ConnectivityResult result;
  //   try {
  //     result = await _connectivity.checkConnectivity();
  //   } on SocketException catch (_) {
  //     if (kDebugMode) {
  //       print(_);
  //     }
  //   }
  //   checkNetWokr(result);
  // }

  checkNetWokr(ConnectivityResult result) async {
    // if (mounted) {
    // bool isOnline = false;
    print(result);

    switch (result) {
      case ConnectivityResult.mobile:
      case ConnectivityResult.wifi:
        const url = 'https://pokeapi.co/api/v2/pokemon/';
        var header = {"Content-Type": "application/json"};
        final response =
            await http.get(Uri.parse(url), headers: header).timeout(
          const Duration(seconds: 10),
          onTimeout: (() {
            return http.Response(
                'Error', 408); // Request Timeout response status code
          }),
        );
        if (response.statusCode == 200) {
          connectionType = result == ConnectivityResult.wifi ? 1 : 2;
          AccountPrefs.statusConnection = true;
          update();
        } else {
          if (response.statusCode == 408 ) {
            Get.snackbar(
                'Slow Network', 'Switching to offline mode.',
                colorText: Colors.black,
                backgroundColor: Colors.yellow,
                snackPosition: SnackPosition.BOTTOM);
          }
          connectionType = 0;
          AccountPrefs.statusConnection = false;
          update();
        }
        break;
      case ConnectivityResult.none:
        connectionType = 0;
        AccountPrefs.statusConnection = false;
        update();
        break;
      default:
        Get.snackbar('NetworkError', 'Cannot get the network status');
        break;
    }
    if (kDebugMode) {
      print('STATUSCONNECTION => ${AccountPrefs.statusConnection}');
    }
  }

  @override
  void onClose() {
    // TODO: implement onClose
    _streamSubscription.cancel();
    super.onClose();
  }
}
