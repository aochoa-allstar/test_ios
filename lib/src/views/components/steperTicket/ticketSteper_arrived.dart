import 'dart:io';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:onax_app/src/controllers/listJsasController.dart';

import 'package:onax_app/src/controllers/ticketSteperController.dart';
import 'package:onax_app/src/utils/sharePrefs/accountPrefs.dart';
import 'package:onax_app/src/utils/styles/themWhite.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

class TicketSteperArrived extends StatelessWidget {
  final TicketSteperController controller;

  TicketSteperArrived({Key? key, required this.controller}) : super(key: key);
  late double h, w;

  @override
  Widget build(BuildContext context) {
    w = MediaQuery.of(context).size.width;
    h = MediaQuery.of(context).size.height;

    return controller.arrivedTimestamp == ''
        ? GetX<TicketSteperController>(builder: (controller) {
            return Container(
              width: w,
              child: Column(
                children: [
                  SizedBox(height: h * 0.02),
                  (controller.imgArrive == null
                      ? SizedBox(height: 0)
                      : Flex(
                          direction: Axis.vertical,
                          children: [
                            Image.file(
                              File(controller.imgArrive!.path),
                              height: h * 0.2,
                            ),
                            SizedBox(height: h * 0.02),
                          ],
                        )),

                  //BTN UPLOAD PHOTO
                  Container(
                      child: PhysicalModel(
                    color: Colors.blue,
                    elevation: 5,
                    borderRadius: BorderRadius.circular(7),
                    child: TextButton(
                        onPressed: () async {
                          //metodo para acutalizar el departTimes y actualizar el steper a 1 s
                          //si todo sale bien.
                          await _showDialog(1);
                        },
                        child: Text(
                          'utils_upload_photo'.tr,
                          style: TextStyle(color: Colors.white),
                        )),
                  )),
                  Flex(
                    direction: Axis.horizontal,
                    children: [
                      Checkbox(
                        value: controller.didCompleteJSA.value,
                        onChanged: ((value) {
                          // controller.updateJSAStatus(value!);
                        }),
                      ),
                      Text(
                        'ticket_steps_jsa_status'.tr,
                      ),
                    ],
                  ),
                  if (controller.didCompleteJSA.isFalse)
                    Flex(
                      direction: Axis.vertical,
                      children: [
                        RoundedLoadingButton(
                          animateOnTap: false,
                          color: Colors.black,
                          controller: controller.btnFillJSA.value,
                          onPressed: (() => controller.redirectToJSAForm()),
                          borderRadius: 15,
                          child: Text(
                            'ticket_steps_complete_jsa'.tr,
                            style: ThemeWhite().labelBtnActions(Colors.white),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                  //ARRIVE BTN
                  RoundedLoadingButton(
                    color: controller.didCompleteJSA.isTrue
                        ? Colors.black
                        : Colors.grey,
                    controller: controller.btnArrrived,
                    onPressed: () async {
                      if (controller.didCompleteJSA.isTrue) {
                        AccountPrefs.statusConnection == true
                            ? await controller.updateArrivedInfoTicket()
                            : await controller.updateArrivedInfoTicketNotWifi();
                      }
                    },
                    borderRadius: 15,
                    child: Text(
                      'ticket_steps_arrive'.tr,
                      style: ThemeWhite().labelBtnActions(Colors.white),
                    ),
                  ),
                ],
              ),
            );
          })
        : Center(
            child: Text(
                'utils_completed_at'.tr + '${controller.arrivedTimestamp}'),
          );
  }

  _showDialog(int type) {
    Get.defaultDialog(
      title: 'utils_photo_from'.tr,
      barrierDismissible: false,
      content: Container(
        height: h * 0.3,
        width: w * 0.3,
        child: Column(
          children: [
            Text(
              'utils_take_photo'.tr,
              style: ThemeWhite().labelBtnActions(Colors.grey),
            ),
            Container(
              width: w * 0.2,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(7),
                color: Colors.blue,
              ),
              child: PhysicalModel(
                color: Colors.blue,
                elevation: 5,
                borderRadius: BorderRadius.circular(7),
                child: TextButton(
                    onPressed: () async {
                      await controller.takePic(type);
                    },
                    child: Icon(
                      Icons.camera,
                      color: Colors.white,
                    )),
              ),
            ),
            SizedBox(height: h * 0.01),
            Text(
              'utils_gallery'.tr,
              style: ThemeWhite().labelBtnActions(Colors.grey),
            ),
            Container(
              width: w * 0.2,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(7),
                color: Colors.blue,
              ),
              child: PhysicalModel(
                color: Colors.blue,
                elevation: 5,
                borderRadius: BorderRadius.circular(7),
                child: TextButton(
                    onPressed: () async {
                      await controller.fromGallery(type);
                    },
                    child: Icon(
                      Icons.photo,
                      color: Colors.white,
                    )),
              ),
            ),
            SizedBox(height: h * 0.01),
            Text(
              'utils_cancel'.tr,
              style: ThemeWhite().labelBtnActions(Colors.grey),
            ),
            Container(
              width: w * 0.2,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(7),
                color: Colors.red,
              ),
              child: PhysicalModel(
                color: Colors.red,
                elevation: 5,
                borderRadius: BorderRadius.circular(7),
                child: TextButton(
                    onPressed: () async {
                      Get.back();
                    },
                    child: Icon(
                      Icons.cancel,
                      color: Colors.white,
                    )),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
