import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:hand_signature/signature.dart';
import 'package:onax_app/app/data/models/ticket_model.dart';
import 'package:onax_app/app/data/repositories/jsas_repository.dart';
import 'package:onax_app/app/routes/app_pages.dart';
import 'package:onax_app/core/services/preferences_service.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:webview_flutter/webview_flutter.dart';

class JSADetailsController extends GetxController {
  final JSAsRepository jsasRepository = Get.find();
  final PreferencesService preferencesService = Get.find();

  final webViewController = Rxn<WebViewController>();
  final jsaId = Rxn<int>();
  final ticketHtmlData = Rxn<String>();
  final ticketLoaded = false.obs;
  final ticketFailed = false.obs;
  final base64Singnature = Rxn<String>();
  final ticket = Rxn<Ticket>();
  final name = Rxn<String>();

  final saveSignatureButtonController = RoundedLoadingButtonController();
  final signaturePadController = new HandSignatureControl(
    threshold: 3.0,
    smoothRatio: 0.3,
    velocityRange: 2.0,
  ).obs;

  @override
  void onInit() {
    jsaId.value = Get.arguments;

    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
    getTicket();
  }

  @override
  void onClose() {
    super.onClose();
  }

  //TODO: Clean this implementation
  Future<void> getTicket() async {
    ticketLoaded.value = false;
    final htmlContent = await jsasRepository.getJSADetailsHtml(jsaId.value!);
    if (htmlContent != null) {
      ticketHtmlData.value = htmlContent;
      webViewController.value = WebViewController()
        ..loadHtmlString(ticketHtmlData.value!)
        ..enableZoom(true)
        ..setJavaScriptMode(JavaScriptMode.unrestricted)
        ..setBackgroundColor(Color.fromARGB(255, 255, 255, 255));
      ticketLoaded.value = true;
    } else {
      ticketFailed.value = true;
    }
  }

  void handleOnPointerUp(Rx<HandSignatureControl> step) async {
    var image = await step.value.toImage(
      background: Colors.white,
      color: Colors.black,
      fit: true,
    );
    Uint8List? imageBytes = image!.buffer.asUint8List();
    final String base64Singnature1 = base64Encode(imageBytes);
    base64Singnature.value = base64Singnature1;
  }

  void handleSignJSA() async {
    print(name.value);
    print(base64Singnature.value);
    if (base64Singnature.value != null && name.value != null) {
      final response = await jsasRepository.signJSA(
        jsaId.value!,
        name.value!,
        base64Singnature.value!,
      );
      if (response.success == true) {
        saveSignatureButtonController.success();
        saveSignatureButtonController.reset();
        Get.offAllNamed(Routes.TABS);
      } else {
        saveSignatureButtonController.error();
        saveSignatureButtonController.reset();
      }
    } else {
      saveSignatureButtonController.error();
      saveSignatureButtonController.reset();
    }
  }
}
