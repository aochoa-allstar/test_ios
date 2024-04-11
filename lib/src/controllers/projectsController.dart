import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:location/location.dart';
import 'package:onax_app/src/repositories/models/customerModel.dart';
import 'package:onax_app/src/utils/sharePrefs/accountPrefs.dart';
import 'package:onax_app/src/utils/urlApi/globalApi.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

class ProjectController extends GetxController {
  final GlobalApi api = GlobalApi();
  late TextEditingController nameText, cordsText;
  late RoundedLoadingButtonController saveProject;
  late int idCustomer;
  late int counterFails;
  late List<CustomerModel> customerList;
  final Location locations = Location();

  @override
  void onInit() {
    customerList = [];
    saveProject = RoundedLoadingButtonController();
    idCustomer = 0;
    nameText = TextEditingController();
    cordsText = TextEditingController();
    counterFails = 0;
    // TODO: implement onInit
    super.onInit();
  }

  @override
  void onReady() async {
    await getCustomers();
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

  saveProjects() async {
    try {
      final String urlApi = '${api.api}/${api.addProject}';
      //print(urlApi);
      final header = {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${AccountPrefs.token}',
      };
      final body = {
        'name': nameText.text.trim(),
        'coords': cordsText.text.trim(),
        'customer_id': idCustomer,
      };
      print(body);
      final response = await http.post(Uri.parse(urlApi),
          headers: header, body: json.encode(body));

      Map<String, dynamic> decodeResp = json.decode(response.body);
      //print('DepartTime = $decodeResp');
      if (response.statusCode == 200 && decodeResp['success'] == true) {
        Get.snackbar('Success', 'The project was created successfuly.',
            colorText: Colors.white,
            backgroundColor: Colors.green,
            snackPosition: SnackPosition.BOTTOM);
        counterFails = 0;
        nameText.text = '';
        cordsText.text = '';
        idCustomer = 0;
        update();
        Get.toNamed('/pages');
      } else {
        saveProject.reset();
        Get.snackbar(
            'Warning', 'Please try it later, Can not save the new project.',
            colorText: Colors.black,
            backgroundColor: Colors.yellow,
            snackPosition: SnackPosition.BOTTOM);
      }
    } catch (e) {
      counterFails++;
      if (counterFails < 3) {
        await saveProjects();
      } else {
        // await updateDepartTimeNotWifi();
        counterFails = 0;
        update();
        saveProject.reset();
      }
    }
  }

  getCustomers() async {
    try {
      //loading dialog

      final String urlApi = '${api.api}/${api.getCustomers}'; //url/api/login

      final header = {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${AccountPrefs.token}',
      };

      final response = await http.get(Uri.parse(urlApi), headers: header);

      Map<String, dynamic> decodeResp = json.decode(response.body);
      print(decodeResp);
      if (decodeResp['message'] == 'Unauthenticated') {
        return false;
      }
      if (response.statusCode == 200 && decodeResp['success'] == true) {
        if (decodeResp.containsKey('data') && decodeResp['data'] != '[]') {
          customerList = (decodeResp['data'] as List)
              .map((e) => CustomerModel.fromJson(e))
              .toList();
        } else {
          customerList = [];
        }
      }
      if (response.statusCode == 200 && decodeResp['success'] == false) {
        Get.snackbar('Warning', 'Please try it later, we dont found data.',
            colorText: Colors.black,
            backgroundColor: Colors.redAccent,
            snackPosition: SnackPosition.BOTTOM);
        customerList = [];
      }
      update();
      return customerList;
    } catch (e) {
      Get.snackbar('Error', 'There was a problem connecting to the server.',
          colorText: Colors.white,
          backgroundColor: Colors.redAccent,
          snackPosition: SnackPosition.BOTTOM);
      return customerList = [];
    }
  }

  selectCustomer(value) async {
    idCustomer = int.parse(value[0].toString());
    //_customerSelected = value[1];
    // AccountPrefs.statusConnection == true
    //     ? await getProjects()
    //     : await getProjectsByIDNOTWifi();
    update();
  }

  //END CLASS
}
