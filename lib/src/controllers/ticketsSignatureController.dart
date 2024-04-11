import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:hand_signature/signature.dart';
import 'package:onax_app/src/repositories/models/ticketModel.dart';
import 'package:onax_app/src/utils/sharePrefs/accountPrefs.dart';
import 'package:onax_app/src/utils/urlApi/globalApi.dart';
import 'package:http/http.dart' as http;
import 'package:rounded_loading_button/rounded_loading_button.dart';

class TicketSignatureController extends GetxController {
  final GlobalApi api = GlobalApi();
  late bool loadOldTickets;
  late dynamic scrollController;
  late List<TicketModel> listPrevTickets;
  late RoundedLoadingButtonController btnSignature;
  late HandSignatureControl singnature1Control;
  late dynamic singnature1Pic;
  late int counterFails;
  @override
  void onInit() {
    counterFails = 0;
    loadOldTickets = true;
    scrollController = ScrollController();
    listPrevTickets = [];
    singnature1Pic = null;
    btnSignature = RoundedLoadingButtonController();
    singnature1Control = HandSignatureControl(
      threshold: 3.0,
      smoothRatio: 0.3,
      velocityRange: 2.0,
    );
    // TODO: implement onInit
    super.onInit();
  }

  @override
  void onReady() async {
    // TODO: implement onReady
    await getPreviewTickts();
    super.onReady();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
  }

  getPreviewTickts() async {
    try {
      // print(AccountPrefs.type);
      //loading dialog
      // if (AccountPrefs.type == 'driver' ||
      //     AccountPrefs.type == 'operator' ||
      //     AccountPrefs.type == 'pusher') {
      final String urlApi =
          '${api.api}/${api.getPreviewTicketsSign}${AccountPrefs.idUser}'; //url/api/login

      final header = {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${AccountPrefs.token}',
      };

      final response = await http.get(Uri.parse(urlApi), headers: header);

      Map<String, dynamic> decodeResp = json.decode(response.body);

      if (response.statusCode == 200 && decodeResp['success'] == true) {
        if (decodeResp.containsKey('data') && decodeResp['data'] != '[]') {
          listPrevTickets = (decodeResp['data'] as List)
              .map((e) => TicketModel.fromJson(e))
              .toList();
        } else {
          listPrevTickets = [];
        }
      }
      if (response.statusCode == 200 && decodeResp['success'] == false) {
        Get.snackbar(
            'Warning', 'Please try it later, we can not connect with the app.',
            colorText: Colors.white,
            backgroundColor: Colors.redAccent,
            snackPosition: SnackPosition.BOTTOM);
        listPrevTickets = [];
      }
      loadOldTickets = false;
      update();
      // }
      return listPrevTickets;
    } catch (e) {
      Get.snackbar('Error', 'There was a problem connecting to the server.',
          colorText: Colors.white,
          backgroundColor: Colors.redAccent,
          snackPosition: SnackPosition.BOTTOM);
      listPrevTickets = [];
      return listPrevTickets;
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

  //updateDepartTime
  saveSignature(int idTicket) async {
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
      final String urlApi = '${api.api}/${api.saveSignatureTicket}';
      //print(urlApi);
      final header = {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${AccountPrefs.token}',
      };
      final body = {
        'id': idTicket,
        'signature': singnature1Pic,
      };
      print(body);
      final response = await http.post(Uri.parse(urlApi),
          headers: header, body: json.encode(body));

      Map<String, dynamic> decodeResp = json.decode(response.body);
      //print('DepartTime = $decodeResp');
      if (response.statusCode == 200 && decodeResp['success'] == true) {
        counterFails = 0;

        await getPreviewTickts();
        Get.back();
        Get.snackbar('Success', 'The Ticket #$idTicket was signatured',
            colorText: Colors.black,
            backgroundColor: Colors.green,
            snackPosition: SnackPosition.BOTTOM);
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
        await saveSignature(idTicket);
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
      // _btnDepart.reset();
      // print(e.toString());
      // Get.snackbar('Error',
      //     'There was a problem connecting to the server.To save Derpar Time',
      //     colorText: Colors.white,
      //     backgroundColor: Colors.redAccent,
      //     snackPosition: SnackPosition.BOTTOM);
      //_btnDepart.reset();
    }
  }

  //clear
  clearPad() {
    singnature1Control.clear();
    update();
  }

  //END CLASS
}
