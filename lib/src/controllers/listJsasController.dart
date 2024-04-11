import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hand_signature/signature.dart';
import 'package:onax_app/src/repositories/models/jsasModel.dart';
import 'package:onax_app/src/utils/dialogs/dialog_actions.dart';
import 'package:onax_app/src/utils/sharePrefs/accountPrefs.dart';
import 'package:onax_app/src/utils/urlApi/globalApi.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:http/http.dart' as http;

import 'connectionManagerController.dart';

fetchJsas(api) async {
  final String urlApi =
      '${api.api}/${api.getJsas}${AccountPrefs.idUser}'; //url/api/login

  final header = {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
    'Authorization': 'Bearer ${AccountPrefs.token}',
  };

  final response = await http.get(Uri.parse(urlApi), headers: header);

  // Map<String, dynamic> decodeResp = json.decode(response.body);
  return response;
}

class ListJSasController extends GetxController {
  final GlobalApi api = GlobalApi();
  late bool loadOldJSAS;
  late dynamic scrollController;
  final listJsas = Rx<List<JsasModel>>([]);
  // final fetchJsas = Rx<Function>(_getPrevJsas());
  late RoundedLoadingButtonController btnSignature;
  late HandSignatureControl singnature1Control;
  late dynamic singnature1Pic;
  late int counterFails;
  late TextEditingController nameTxt;
  late ConnectionManagerController connectionManagerController;
  @override
  void onInit() {
    connectionManagerController = Get.put(ConnectionManagerController());
    print('Connection Type => ${connectionManagerController.connectionType}');
    // TODO: implement onInit
    counterFails = 0;
    loadOldJSAS = true;
    scrollController = ScrollController();
    // listJsas = [];
    singnature1Pic = null;
    // fetchJsas = _getPrevJsas();
    btnSignature = RoundedLoadingButtonController();
    singnature1Control = HandSignatureControl(
      threshold: 3.0,
      smoothRatio: 0.3,
      velocityRange: 2.0,
    );
    nameTxt = TextEditingController();
    super.onInit();
  }

  @override
  void onReady() {
    if (AccountPrefs.statusConnection == true) {
      _getPrevJsas();
    }

    // TODO: implement onReady
    super.onReady();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
  }

  _getPrevJsas() async {
    try {
      final response = await fetchJsas(api);
      Map<String, dynamic> decodeResp = json.decode(response.body);

      if (response.statusCode == 200 && decodeResp['success'] == true) {
        if (decodeResp.containsKey('data') && decodeResp['data'] != '[]') {
          listJsas.value = (decodeResp['data'] as List)
              .map((e) => JsasModel.fromJson(e))
              .toList();
        } else {
          listJsas.value = [];
        }
      }
      if (response.statusCode == 200 && decodeResp['success'] == false) {
        Get.snackbar(
            'Warning', 'Please try it later, we can not connect with the app.',
            colorText: Colors.white,
            backgroundColor: Colors.redAccent,
            snackPosition: SnackPosition.BOTTOM);
        listJsas.value = [];
      }
      loadOldJSAS = false;
      update();

      return listJsas;
    } catch (e) {
      Get.snackbar('Error', 'There was a problem connecting to the server.',
          colorText: Colors.white,
          backgroundColor: Colors.redAccent,
          snackPosition: SnackPosition.BOTTOM);
      listJsas.value = [];
      loadOldJSAS = false;
      update();
      return listJsas;
    }
  }

  ///convert signatures to image first before.
  convertPadToImg() async {
    if (singnature1Control.isFilled) {
      var singnatureImg = await singnature1Control.toImage(
        background: Colors.white,
        color: Colors.black,
        fit: true,
      );
      Uint8List? imageBytes = singnatureImg!.buffer.asUint8List();
      final String base64Singnature1 = base64Encode(imageBytes);
      // print(base64);
      singnature1Pic = base64Singnature1;
    } else {
      singnature1Pic = '';
    }
    update();
  }

  //clear
  clearPad() {
    singnature1Control.clear();
    update();
  }

  clearTextName() {
    nameTxt.text = '';
    update();
  }

  saveSignature(int idJsas) async {
    try {
      await convertPadToImg();
      if (singnature1Pic == null || singnature1Pic == '') {
        btnSignature.reset();
        Get.snackbar('Warning', 'The signature is required.',
            colorText: Colors.black,
            backgroundColor: Colors.yellow,
            snackPosition: SnackPosition.BOTTOM);
        return false;
      }
      final String urlApi = '${api.api}/${api.storeSignaturesJsas}';
      //print(urlApi);
      final header = {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${AccountPrefs.token}',
      };
      final body = {
        'jsas_id': idJsas,
        'signature': singnature1Pic,
        'name': nameTxt.text.trim(),
      };
      print(body);
      final response = await http.post(Uri.parse(urlApi),
          headers: header, body: json.encode(body));

      Map<String, dynamic> decodeResp = json.decode(response.body);
      //print('DepartTime = $decodeResp');
      if (response.statusCode == 200 && decodeResp['success'] == true) {
        counterFails = 0;

        Get.snackbar('Success', 'The Jsas #$idJsas was signatured',
            colorText: Colors.black,
            backgroundColor: Colors.green,
            snackPosition: SnackPosition.BOTTOM);
        //ShowDialog if yes clear pad and text
        //not return to listJsas close this window.
        await _getPrevJsas();
        Get.dialog(
          DialogAction(
            msg: 'Would you like to continue a new signature?',
            exitFunc: () {
              clearTextName();

              clearPad();
              Get.back();
            },
            continueFunc: () {
              Get.back();

              clearTextName();
              clearPad();
            },
          ),
          barrierDismissible: false,
        );
        //
        // Get.back();
      } else {
        btnSignature.reset();
        Get.snackbar(
            'Warning', 'Please try it later, Can not update the ticket',
            colorText: Colors.black,
            backgroundColor: Colors.yellow,
            snackPosition: SnackPosition.BOTTOM);
        //btnSignature.reset();
      }
      singnature1Pic = '';
      singnature1Control.clear();
      update();
    } catch (e) {
      counterFails++;
      if (counterFails < 3) {
        await saveSignature(idJsas);
      } else {
        // await updateDepartTimeNotWifi();
        // counterFails = 0;
        // update();
        Get.snackbar('Error',
            'There was a problem connecting to the server.To save the signature',
            colorText: Colors.white,
            backgroundColor: Colors.redAccent,
            snackPosition: SnackPosition.BOTTOM);
        btnSignature.reset();
      }
    }
  }

  //END CLASSS
}
