import 'dart:convert';
// import 'dart:html';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:onax_app/app/data/enums/preferences_enum.dart';
import 'package:onax_app/app/routes/app_pages.dart';
import 'package:onax_app/core/services/preferences_service.dart';
import 'package:onax_app/src/repositories/models/workersModel.dart';
// import 'package:onax_app/src/repositories/services/loginService.dart';
import 'package:onax_app/src/utils/sharePrefs/accountPrefs.dart';
import 'package:onax_app/src/utils/urlApi/globalApi.dart';
import 'package:http/http.dart' as http;

class LoginController extends GetxController {
  AccountPrefs preferences = Get.find();

  final GlobalApi api = GlobalApi();
  // final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  //variables for the login_screen
  late TextEditingController _email;
  late TextEditingController _password;
  late TextEditingController _recoveryEmial;
  late bool _isCheckSelected;
  late String _deviceToken = '';

  //GETERS to interact with te view
  TextEditingController get email => _email;
  TextEditingController get password => _password;
  TextEditingController get recoveryEmail => _recoveryEmial;
  bool get isCheckSelected => _isCheckSelected;

  @override
  void onInit() async {
    _email = TextEditingController();
    _password = TextEditingController();
    _recoveryEmial = TextEditingController();
    _isCheckSelected =
        false; //AccountPrefs.saveData != 0 ? AccountPrefs.saveData : 0;

    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    Get.delete<LoginController>();
    super.onClose();
  }

  login() async {
    try {
      //logical
      //loading dialog
      final String urlApi = '${api.api}/${api.login}'; //url/api/login

      final header = {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      };

      //validete if email is not null and the email has format
      //validate if password is not null,
      final body = {
        'email': _email.text.trim(),
        'password': _password.text.trim(),
        'deviceToken': 'test534242',
        /* await _firebaseMessaging.getToken().then((token) {
          return token.toString();
        })*/
      };

      final response = await http.post(Uri.parse(urlApi),
          headers: header, body: json.encode(body));
      print(response.body);
      Map<String, dynamic> decoResponse = json.decode(response.body);
      //print(decoResponse['data']['user']);
      if (decoResponse.containsKey('data') && decoResponse['success'] == true) {
        print('tengo data');
        final userMap = decoResponse['data']['user'];
        print(userMap);
        final worker = WorkerModel.fromJson(userMap);
        print(worker);
        if (worker.type != 'helper') {
          // preferences.setPreference(AccountPrefs.userId, worker.id);
          // preferences.setPreference(AccountPrefs.name, worker.name);
          // preferences.setPreference(AccountPrefs.email, worker.email);
          // preferences.setPreference(AccountPrefs.inactive, worker.inactive == null ? 0 : 1);
          // preferences.setPreference(AccountPrefs.status, worker.status);
          // preferences.setPreference(AccountPrefs.sessionToken, decoResponse['data']['token']);
          // preferences.setPreference(AccountPrefs.type, worker.type);
          // preferences.setPreference(AccountPrefs.language, worker.language);
          // preferences.setPreference(AccountPrefs.workerTypeId, userMap['worker_type_id']);
          update();
          Get.offNamed('/pages');
        } else {
          Get.snackbar('Warning', 'You cannot login beacuse, you are a helper.',
              colorText: Colors.white,
              backgroundColor: Colors.yellow,
              snackPosition: SnackPosition.BOTTOM,
              duration: const Duration(seconds: 4));
        }
      } else {
        Get.snackbar('Warning', 'Wrong credentials.',
            colorText: Colors.white,
            backgroundColor: Colors.redAccent,
            snackPosition: SnackPosition.BOTTOM);
        //show dialog show error

      }
      // print(AccountPrefs.token);
      update();
    } catch (e) {
      print(e);
      Get.snackbar('Error',
          'There was a problem connecting to the server/n ${e.toString()}',
          snackPosition: SnackPosition.BOTTOM);
      //dialog to show error
    }
  }

  uploadCheckTerm(value) {
    if (value == true) {}
    _isCheckSelected = value;
    update();
  }

  recoveryPass() async {
    try {
      //logical
      //loading dialog
      final String urlApi =
          '${api.api}/${api.resetPassword}'; //url/api/recoveryPass

      final header = {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      };

      //validete if email is not null and the email has format
      //validate if password is not null,
      final body = {
        'email': _email.text.trim(),

        //'deviceToken': 'test534242',
        /* await _firebaseMessaging.getToken().then((token) {
          return token.toString();
        })*/
      };

      final response = await http.post(Uri.parse(urlApi),
          headers: header, body: json.encode(body));

      Map<String, dynamic> decoResponse = json.decode(response.body);
      print(decoResponse);
      if (response.statusCode == 200 && decoResponse['success'] == true) {
        //
        Get.snackbar('Succes',
            'Please verify your email, now did you receive an email with the link of change password.',
            colorText: Colors.white,
            backgroundColor: Colors.green[300],
            snackPosition: SnackPosition.BOTTOM);

        //Get.back();
      } else {
        //
        Get.snackbar(
            'Warning', 'We can process the requirement for the moment.',
            colorText: Colors.white,
            backgroundColor: Colors.redAccent,
            snackPosition: SnackPosition.BOTTOM);
      }
    } catch (e) {
      print(e.toString());
      Get.snackbar('Error',
          'There was a problem connecting to the server.', //${e.toString()}
          backgroundColor: Colors.redAccent,
          snackPosition: SnackPosition.BOTTOM);
      //dialog to show error
    }
    //
  }
}
