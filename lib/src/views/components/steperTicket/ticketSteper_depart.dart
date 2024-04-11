import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:onax_app/src/controllers/ticketSteperController.dart';
import 'package:onax_app/src/utils/sharePrefs/accountPrefs.dart';
import 'package:onax_app/src/utils/styles/themWhite.dart';
import 'package:onax_app/src/views/components/button_widget.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

class TicketSteperDepart extends StatelessWidget {
  final TicketSteperController controller;
  TicketSteperDepart({Key? key, required this.controller}) : super(key: key);
  late double h, w;

  @override
  Widget build(BuildContext context) {
    w = MediaQuery.of(context).size.width;
    h = MediaQuery.of(context).size.height;
    return controller.departTimestamp == ''
        ? Container(
            width: w,
            child: Column(
                children: [
                  RoundedLoadingButton(
                    color: Colors.black,
                    controller: controller.btnDepart,
                    onPressed: () async {
                      AccountPrefs.statusConnection == true
                          ? await controller.updateDepartTime()
                          : await controller.updateDepartTimeNotWifi();
                    },
                    borderRadius: 15,
                    child: Text(
                      'ticket_steps_depart'.tr,
                      style: ThemeWhite().labelBtnActions(Colors.white),
                    ),
                  )
                ],
              )
          )
        : Center(
            child:
                Text('utils_completed_at'.tr + ' ${controller.departTimestamp}'),
          );
  }
}
