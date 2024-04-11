import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:onax_app/src/controllers/listJsasController.dart';

import 'package:onax_app/src/repositories/models/jsasModel.dart';
import 'package:onax_app/src/utils/sharePrefs/accountPrefs.dart';

import 'package:onax_app/src/utils/styles/themWhite.dart';
import 'package:onax_app/src/views/JsasFormScreen.dart';
import 'package:onax_app/src/views/components/jsasSignature/pfd_JsaSignature.dart';

class JsasToSignature extends StatelessWidget {
  JsasToSignature({super.key});
  late double w, h;
  @override
  Widget build(BuildContext context) {
    w = MediaQuery.of(context).size.width;
    h = MediaQuery.of(context).size.height;
    final ListJSasController jsasSignatureController = ListJSasController();
    return Scaffold(
      // appBar: AppBar(
      //     leading: IconButton(
      //   icon: Icon(Icons.arrow_back_ios),
      //   onPressed: () {
      //     Get.offNamed('/pages');
      //   },
      // )),
      body: GetBuilder<ListJSasController>(
        init: jsasSignatureController,
        builder: (controller) => SafeArea(
            child: SizedBox(
          width: w,
          height: h * 1.1,
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              children: [
                SizedBox(
                  height: h * 0.01,
                ),
                //BTN TO CREATE NEW
                _btnCreateJSA(),
                SizedBox(
                  height: h * 0.02,
                ),
                Align(
                  alignment: Alignment.center,
                  child: SizedBox(
                    width: w * 0.95,
                    height: h * 0.05,
                    //CHANGE
                    child: Text(
                      "JSA's",
                      style: TextStyle(fontSize: 20),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                SizedBox(
                  height: h * 0.02,
                ),
                //list of tickets
                AccountPrefs.statusConnection == true
                    ? _listOfTickets(controller)
                    : Center(
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Text("list_pdf_jsas_prev".tr),
                        ),
                      ),
              ],
            ),
          ),
        )),
      ),
    );
  }

  //listOfTickets
  _listOfTickets(ListJSasController controller) {
    late Widget? widget;
    if (controller.loadOldJSAS == false) {
      widget = Container(
        width: w * 0.90,
        height: h * 0.75,
        //color: Colors.red,
        child: controller.listJsas.value.length > 0
            ? _cardsTickets(controller)
            : AccountPrefs.statusConnection == true
                ? Center(
                    child: Text('menu_tickets_screen_noprevious'.tr),
                  )
                : Center(
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Text("list_pdf_jsas_prev".tr),
                    ),
                  ),
      );
    } else {
      widget = Center(
        child: CircularProgressIndicator(),
      );
    }

    return widget;
  }

  _cardsTickets(ListJSasController controller) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: controller.listJsas.value.length,
      scrollDirection: Axis.vertical,
      itemBuilder: (context, index) {
        return _cardTikcet(controller.listJsas.value[index], controller);
      },
    );
  }

  _cardTikcet(JsasModel jsas, ListJSasController controller) {
    return GestureDetector(
      onTap: () {
        //code Action
        Get.to(() => PDFJsaSignature(
              workerOrderID: jsas.id,
              parentController: controller,
            ));
      },
      child: Container(
        width: w,
        height: h * 0.05,
        margin: EdgeInsets.only(bottom: h * 0.01),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Color.fromARGB(255, 135, 192, 238),
        ),
        child: Row(
          //mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Spacer(),
            SizedBox(
              // width: w * 0.2,
              child: Text(
                '${jsas.date.substring(0, 10)} -> ${jsas.projectName}',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            Spacer(),
            Icon(
              Icons.arrow_forward_ios,
              color: Colors.white,
            ),
          ],
        ),
      ),
    );
  }

  _btnCreateJSA() {
    return PhysicalModel(
      color: Colors.blue,
      elevation: 5,
      borderRadius: BorderRadius.circular(15),
      child: Container(
        height: h * 0.07,
        width: w * 0.7,
        decoration: BoxDecoration(
          color: Colors.blue,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Platform.isAndroid
            ? TextButton(
                onPressed: () {
                  // TODO: implement
                  // controller.moveToScreenCreateTicket();
                  Get.offAll(
                    () => JsasFormScreen(
                        //controller: Get.find<HomeController>(),
                        ),
                    transition: Transition.rightToLeft,
                    duration: const Duration(milliseconds: 250),
                  );
                },
                child: Text(
                  'New JSA',
                  style: ThemeWhite().labelBtnActions(Colors.white),
                ),
              )
            : CupertinoButton(
                child: Text(
                  'home_new_ticket_btn'.tr,
                  style: ThemeWhite().labelBtnActions(Colors.white),
                ),
                onPressed: () {
                  //controller.moveToScreenCreateTicket();
                  Get.offAll(
                    () => JsasFormScreen(
                        //controller: Get.find<HomeController>(),
                        ),
                    transition: Transition.rightToLeft,
                    duration: const Duration(milliseconds: 250),
                  );
                },
              ),
      ),
    );
  }

  //END CLASS
}
