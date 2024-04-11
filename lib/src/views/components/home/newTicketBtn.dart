import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:onax_app/src/controllers/homeController.dart';
import 'package:onax_app/src/utils/styles/themWhite.dart';
import 'dart:io' show Platform;

import 'shift/create_new_shift.dart';

class NewTicketBtn extends StatelessWidget {
  final HomeController controller;
  NewTicketBtn({Key? key, required this.controller}) : super(key: key);
  late double h, w;
  @override
  Widget build(BuildContext context) {
    w = MediaQuery.of(context).size.width;
    h = MediaQuery.of(context).size.height;
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
                  controller.moveToScreenCreateTicket();
                },
                child: Text(
                  'home_new_ticket_btn'.tr,
                  style: ThemeWhite().labelBtnActions(Colors.white),
                ),
              )
            : CupertinoButton(
                child: Text(
                  'home_new_ticket_btn'.tr,
                  style: ThemeWhite().labelBtnActions(Colors.white),
                ),
                onPressed: () {
                  controller.moveToScreenCreateTicket();
                },
              ),
      ),
    );
  }
}
