import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:location/location.dart';
import 'package:onax_app/src/utils/sharePrefs/accountPrefs.dart';
import 'package:onax_app/src/utils/urlApi/globalApi.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

class DestinationsController extends GetxController {
  final GlobalApi api = GlobalApi();
  late TextEditingController nameText, cordsText;
  late RoundedLoadingButtonController saveDestinationBtn;
  late int counterFails;
  final Location locations = Location();

  @override
  void onInit() {
    nameText = TextEditingController();
    cordsText = TextEditingController();
    saveDestinationBtn = RoundedLoadingButtonController();
    counterFails = 0;
    // TODO: implement onInit
    super.onInit();
  }

  @override
  void onReady() async {
    LocationData coordenates = await locations.getLocation();
    late String sendCoords =
        '${coordenates.latitude}, ${coordenates.longitude}';
    cordsText.text = sendCoords;
    update();
    // TODO: implement onReady
    super.onReady();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
  }

  saveDestination() async {
    try {
      final String urlApi = '${api.api}/${api.addDestination}';
      //print(urlApi);
      final header = {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${AccountPrefs.token}',
      };
      final body = {
        'name': nameText.text.trim(),
        'coords': cordsText.text.trim(),
      };
      if (nameText.text.isEmpty) {
        saveDestinationBtn.reset();
        Get.snackbar('Warning', 'The name of destination can not be empty.',
            colorText: Colors.black,
            backgroundColor: Colors.yellow,
            snackPosition: SnackPosition.BOTTOM);
        return false;
      }
      print(body);
      final response = await http.post(Uri.parse(urlApi),
          headers: header, body: json.encode(body));

      Map<String, dynamic> decodeResp = json.decode(response.body);
      //print('DepartTime = $decodeResp');
      if (response.statusCode == 200 && decodeResp['success'] == true) {
        Get.snackbar('Success', 'The Destination was created successfuly.',
            colorText: Colors.white,
            backgroundColor: Colors.green,
            snackPosition: SnackPosition.BOTTOM);
        counterFails = 0;
        nameText.text = '';
        cordsText.text = '';
        update();
      } else {
        saveDestinationBtn.reset();
        Get.snackbar(
            'Warning', 'Please try it later, Can not save the new destination.',
            colorText: Colors.black,
            backgroundColor: Colors.yellow,
            snackPosition: SnackPosition.BOTTOM);
      }
    } catch (e) {
      counterFails++;
      if (counterFails < 3) {
        await saveDestination();
      } else {
        // await updateDepartTimeNotWifi();
        counterFails = 0;
        update();
        saveDestinationBtn.reset();
      }
    }
  }
}
