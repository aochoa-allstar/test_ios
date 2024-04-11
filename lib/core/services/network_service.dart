// ignore_for_file: sdk_version_since

import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:onax_app/core/services/sqlite_service.dart';
import 'package:speed_test_dart/classes/server.dart';
import 'package:speed_test_dart/classes/upload_download.dart';
import 'package:speed_test_dart/enums/file_size.dart';
import 'package:speed_test_dart/speed_test_dart.dart';

class NetworkService extends GetxController implements GetxService {
  Future<NetworkService> init() async => this;
  SQLiteService dataBaseSQLite = Get.find();

  final connectionType = Rx<ConnectivityResult?>(ConnectivityResult.wifi);

  final Connectivity connectivity = Connectivity();
  late StreamSubscription streamSubscription;

  final SpeedTestDart speedTest = SpeedTestDart();
  final server = Rx<Server?>(null);
  final downloadSpeed = Rx<double>(0);
  final uploadSpeed = Rx<double>(0);

  @override
  void onInit() async {
    await getConnectivityType();
    streamSubscription =
        connectivity.onConnectivityChanged.listen(_updateState);
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    streamSubscription.cancel();

    super.onClose();
  }

  Future<void> getConnectivityType() async {
    late ConnectivityResult connectivityResult;
    try {
      connectivityResult = await (connectivity.checkConnectivity());
    } on PlatformException catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
    return await _updateState(connectivityResult);
  }

  _updateState(ConnectivityResult connectivityResult) async {
    switch (connectivityResult) {
      case ConnectivityResult.wifi:
      case ConnectivityResult.mobile:
        // connectionType.value = ConnectivityResult.wifi;
        await getNetworkSpeed(connectivityResult);
        break;

      case ConnectivityResult.none:
        downloadSpeed.value = 0;
        connectionType.value = ConnectivityResult.none;
        break;
      default:
        break;
    }
  }

  Future<void> _setBestServers() async {
    final settings = await speedTest.getSettings();
    settings.download = Download(1, '250K', '250K', 1);
    final servers = settings.servers;

    final _serverList = await speedTest.getBestServers(
      servers: servers,
    );

    server.value = _serverList.firstOrNull;
  }

  Future<void> getNetworkSpeed(ConnectivityResult newConnection) async {
    bool error = false;

    try {
      await _setBestServers().then((value) async {
        if (connectionType != newConnection) {
          // Check if connection types are different to only test network speed on network change
          connectionType.value = newConnection;
          // Updates to prevent duplicated events

          if (error == false) {
            await speedTest.testDownloadSpeed(
              servers: [server.value!],
              downloadSizes: [FileSize.SIZE_350],
            ).then((value) {
              if (value >= 0.5 && !error) {
                downloadSpeed.value = value;
                switchToOnlineMode();
              } else {
                switchToOfflineMode();
              }
              // }).timeout(Duration(seconds: 20));
            });
          }
        }
      }).timeout(Duration(seconds: 20));
    } on TimeoutException {
      error = true;
      switchToOfflineMode();
    }
  }

  void switchToOfflineMode() {
    downloadSpeed.value = 0;
    connectionType.value = ConnectivityResult.none;

    Get.snackbar(
      'snackbar_network_title'.tr,
      'snackbar_network_slow_connection'.tr,
      colorText: Colors.white,
      backgroundColor: Colors.red.withAlpha(150),
      isDismissible: true,
      margin: EdgeInsets.all(16),
    );
  }

  void switchToOnlineMode() async {
    Get.snackbar(
      'snackbar_network_title'.tr,
      'snackbar_network_back_online'.tr,
      colorText: Colors.white,
      backgroundColor: Colors.green.withAlpha(150),
      isDismissible: true,
      margin: EdgeInsets.all(16),
    );
    await dataBaseSQLite.syncDataBase();
  }
}
