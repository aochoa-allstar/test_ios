import 'dart:convert';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:onax_app/app/data/enums/database_tables_enum.dart';
import 'package:onax_app/app/data/models/session_model.dart';
import 'package:onax_app/app/data/repositories/auth_repository.dart';
import 'package:onax_app/app/routes/app_pages.dart';
import 'package:onax_app/core/services/network_service.dart';
import 'package:onax_app/core/services/preferences_service.dart';
import 'package:onax_app/core/services/sqlite_service.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';

class AccountController extends GetxController {
  // TabsController tabsController = Get.find();

  final AuthRepository authRepository = Get.find();
  final PreferencesService preferences = Get.find();
  final NetworkService networkService = Get.find();
  final SQLiteService dataBaseSQLite = Get.find();

  final logOutButton = RoundedLoadingButtonController();
  final session = Rx<Session?>(null);
  final syncTable = Rx<List<Map<String, dynamic>>>([]);
  final loadingOfflineData = Rx<bool>(true);

  @override
  void onInit() {
    session.value = preferences.getSession();
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void getSyncTable() async {
    loadingOfflineData.value = true;

    Map<String, dynamic> rawData =
        await dataBaseSQLite.getTable(DatabaseTables.sync);

    final data = rawData['data'] as List<Map<String, dynamic>>;
    syncTable.value = data;
    syncTable.refresh();
    loadingOfflineData.value = false;
  }

  void deleteDataBase() {
    if (networkService.connectionType.value == ConnectivityResult.none) {
      Get.snackbar(
          backgroundColor: Colors.redAccent.withAlpha(150),
          'account_no_connection'.tr,
          'account_no_connection_delete_text'.tr);
      return;
    }

    //First we show a alert dialog to confirm the action
    Get.defaultDialog(
      title: 'account_delete'.tr,
      middleText: 'account_delete_confirm'.tr,
      titlePadding: EdgeInsets.symmetric(vertical: 24),
      contentPadding: EdgeInsets.symmetric(horizontal: 32),
      backgroundColor: Colors.white,
      actions: [
        Padding(
          padding: const EdgeInsets.only(bottom: 16.0),
          child: FilledButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colors.black),
            ),
            onPressed: () {
              Get.back();
            },
            child: Text('account_cancel'.tr),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 16.0),
          child: TextButton(
            style: ButtonStyle(
                foregroundColor: MaterialStateProperty.all(Colors.black)),
            onPressed: () {
              Get.back();
              dataBaseSQLite.restartDB();
            },
            child: Text('account_confirm'.tr),
          ),
        ),
      ],
    );
  }

  void syncDataBase() async {
    if (networkService.connectionType.value == ConnectivityResult.none) {
      Get.snackbar(
          backgroundColor: Colors.redAccent.withAlpha(150),
          'account_no_connection'.tr,
          'account_no_connection_sync_text'.tr);
      return;
    }

    await dataBaseSQLite.syncDataBase();
  }

  void shareDatabaseCSVViaEmail() async {
    if (networkService.connectionType.value == ConnectivityResult.none) {
      Get.snackbar(
          backgroundColor: Colors.redAccent.withAlpha(150),
          'account_no_connection'.tr,
          'account_no_connection_share_text'.tr);
      return;
    }

    final dataBaseResponse = await dataBaseSQLite.getTable(DatabaseTables.sync);
    final data = dataBaseResponse['data'] as List<Map<String, dynamic>>;

    //Create a temporary file to store the CSV data
    final file = jsonEncode(data);

    final session = preferences.getSession();

    final email = Email(
        subject:
            '${DateTime.now().toIso8601String()}|${session.userId}|User Data',
        body: '${file}',
        recipients: ['developer@codeshore.net']);

    await FlutterEmailSender.send(email);
  }

  void logOut() async {
    await authRepository.logOut();
    logOutButton.reset();

    Get.offAllNamed(Routes.LOGIN);
  }
}
