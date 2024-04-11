import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:onax_app/src/controllers/connectionManagerController.dart';
import 'package:onax_app/src/repositories/services/manageSetService.dart';
import 'package:onax_app/src/services/sqlite/sqlite_shift.dart';
import 'package:onax_app/src/views/manage_options_screen.dart';

import '../utils/sharePrefs/accountPrefs.dart';
import '../utils/urlApi/globalApi.dart';
import 'package:http/http.dart' as http;

class ManageSettingsController extends GetxController {
  final GlobalApi api = GlobalApi();
  late TextEditingController _password;
  late TextEditingController _confirmPassword;

  TextEditingController get password => _password;
  TextEditingController get confirmPassword => _confirmPassword;
  late ConnectionManagerController connectionManagerController;
  late int counterFails;
  
  @override
  void onInit() {
    counterFails = 0;
    _password = TextEditingController();
    _confirmPassword = TextEditingController();
    connectionManagerController = Get.put(ConnectionManagerController());
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

  logout() async {
    try {
      final String urlApi = '${api.api}/${api.logout}';
      final header = {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${AccountPrefs.token}',
      };
      final response =
          await ManageSetService(url: urlApi, headers: header).post();

      Map<String, dynamic> decodeResp = json.decode(response.body);
      print(decodeResp);
      print(AccountPrefs.token);
      //close loading dialog.
      if (response.statusCode == 200 && decodeResp['success'] == true) {
        AccountPrefs.token = '';
        AccountPrefs.idUser = 0;
        AccountPrefs.currentShift = 0;
        AccountPrefs.hasOpenTicke = 0;
        AccountPrefs.email = '';
        //AccountPrefs.inactive = worker.inactive == null ? 0 : 1;
        AccountPrefs.status = '';
        AccountPrefs.token = '';
        AccountPrefs.type = '';
        update();
        Get.offNamed('/login');
      } else if (response.statusCode == 401 && decodeResp['message'] == 'Unauthenticated.') {
        AccountPrefs.token = '';
        AccountPrefs.idUser = 0;
        AccountPrefs.currentShift = 0;
        AccountPrefs.hasOpenTicke = 0;
        AccountPrefs.email = '';
        //AccountPrefs.inactive = worker.inactive == null ? 0 : 1;
        AccountPrefs.status = '';
        AccountPrefs.token = '';
        AccountPrefs.type = '';
        update();
        Get.offNamed('/login');
      } else {
        //show dialog error
        Get.back();
      }
    } catch (e) {
      print(e.toString());
      
    }
  }

  changePassword() async {
    try {
      final String urlApi = '${api.api}/${api.changePassword}';
      final header = {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${AccountPrefs.token}',
      };
      final body = {
        "newPassword": _confirmPassword.text.trim(),
        "email": AccountPrefs.email,
      };
      final response = await ManageSetService(
              url: urlApi, headers: header, body: json.encode(body))
          .post();
      Map<String, dynamic> decodeResp = json.decode(response.body);

      print(decodeResp);
      if (decodeResp['success'] == true && response.statusCode == 200) {
        //
        _confirmPassword.text = '';
        _password.text = '';

        Get.snackbar('Succes', 'Your password has been changed successfully.',
            colorText: Colors.white,
            backgroundColor: Colors.green[300],
            snackPosition: SnackPosition.BOTTOM);
      }
      if (response.statusCode == 200 && decodeResp['success'] == false) {
        Get.snackbar('Warning',
            'Your password has not been changed successfully, something was wrong.',
            colorText: Colors.white,
            backgroundColor: Colors.green[300],
            snackPosition: SnackPosition.BOTTOM);
      }
      update();
    } catch (e) {
      print(e.toString());
      Get.snackbar('Error', 'There was a problem connecting to the server}',
          colorText: Colors.white,
          backgroundColor: Colors.redAccent,
          snackPosition: SnackPosition.BOTTOM);
    }
  }

  endShift() async {
    /*Get.to(
      () => PagesScreen(),
      transition: Transition.rightToLeft,
      duration: const Duration(milliseconds: 250),
    );*/
    //update();
    try {
      final String urlApi =
          '${api.api}/${api.endShift}${AccountPrefs.currentShift}';
      //print(urlApi);
      final header = {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${AccountPrefs.token}',
      };
      final body = {
        'flag': true, //with conetion
        'active': 0,
      };
      //print(body);
      final response = await http.put(Uri.parse(urlApi),
          headers: header, body: json.encode(body));

      Map<String, dynamic> decodeResp = json.decode(response.body);
      print('FinishedTime = $decodeResp');
      if (response.statusCode == 200 && decodeResp['success'] == true) {
        AccountPrefs.currentShift = 0;
        AccountPrefs.hasOpenTicke = 0;
        update();
        Get.offNamed('/pages');
      } else if (response.statusCode == 401 && decodeResp['message'] == 'Unauthenticated.') {
        AccountPrefs.currentShift = 0;
        AccountPrefs.hasOpenTicke = 0;
        update();
        Get.offNamed('/pages');
      } else {
        Get.snackbar('Warning',
            'Please try it later, Can not update the information of the ticket finished time',
            colorText: Colors.black,
            backgroundColor: Colors.yellow,
            snackPosition: SnackPosition.BOTTOM);
      }
    } catch (e) {
      counterFails++;
      if (counterFails < 3) {
        await endShift();
      } else {
        await endShiftNOtWifi();
        counterFails = 0;
        update();
      }
      // print(e.toString());
      // Get.snackbar('Error',
      //     'There was a problem connecting to the server.To save finished Time',
      //     colorText: Colors.white,
      //     backgroundColor: Colors.redAccent,
      //     snackPosition: SnackPosition.BOTTOM);
      // _btnEndShift.reset();
    }
  }
  //

  endShiftNOtWifi() async {
    try {
      final response =
          await ShiftSQL().finishShiftSQL(AccountPrefs.currentShift);

      // Map<String, dynamic> decodeResp = json.decode(response.body);
      // print('FinishedTime = $decodeResp');
      if (response['statusCode'] == 200 && response['success'] == true) {
        AccountPrefs.currentShift = 0;
        AccountPrefs.hasOpenTicke = 0;
        update();
        Get.offNamed('/pages');
      } else {
        Get.snackbar('Warning',
            'Please try it later, Can not update the information of the ticket finished time',
            colorText: Colors.black,
            backgroundColor: Colors.yellow,
            snackPosition: SnackPosition.BOTTOM);
      }
    } catch (e) {
      print(e.toString());
      Get.snackbar('Error',
          'There was a problem connecting to the server.To save finished Time',
          colorText: Colors.white,
          backgroundColor: Colors.redAccent,
          snackPosition: SnackPosition.BOTTOM);
    }
  }
}
