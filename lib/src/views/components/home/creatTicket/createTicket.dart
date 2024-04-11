// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:onax_app/src/controllers/addNewTicketController.dart';

import 'package:onax_app/src/utils/styles/themWhite.dart';
import 'package:onax_app/src/views/components/home/creatTicket/dropDownCompanyMan.dart';
import 'package:onax_app/src/views/components/home/creatTicket/dropDownOrigin.dart';
import 'package:onax_app/src/views/components/home/creatTicket/dropDownProject.dart';
import 'package:onax_app/src/views/components/home/creatTicket/dropDownTruck.dart';
import 'package:onax_app/src/views/pages_screen.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'dart:io' show Platform;
import 'dropDownCustomer.dart';
import 'dropDownDesitny.dart';

class CreateTicketForm extends StatelessWidget {
  CreateTicketForm({Key? key}) : super(key: key);
  late double h, w;
  @override
  Widget build(BuildContext context) {
    w = MediaQuery.of(context).size.width;
    h = MediaQuery.of(context).size.height;
    final AddNewTicketController _addNewTicket = AddNewTicketController();
    return WillPopScope(
      onWillPop: () async {
        Get.offNamed('/pages');
        // Get.off(
        //   () => PagesScreen(),
        //   arguments: {'page': 0},
        //   transition: Transition.rightToLeft,
        //   duration: const Duration(milliseconds: 250),
        // );
        return true;
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                Get.offNamed('/pages');
              },
              icon: Icon(Icons.arrow_back_ios)),
          centerTitle: true,
          title: Text(
            'home_new_ticket_btn'.tr,
            style: ThemeWhite().titleBar(Colors.white),
          ),
        ),
        body: GetBuilder<AddNewTicketController>(
          init: _addNewTicket,
          builder: (_) => Container(
            width: w,
            height: h,
            child: _.dataLoad == false
                ? SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: _form(_),
                  )
                : const Center(
                    child: CircularProgressIndicator(),
                  ),
          ),
        ),
      ),
    );
  }

  _form(AddNewTicketController _) {
    return Container(
      width: w,
      height: h * 1.1,
      //color: Colors.yellow,
      margin: EdgeInsets.symmetric(horizontal: w * 0.1),
      child: Column(
        children: [
          SizedBox(
            height: h * 0.1,
          ),
          DropDownTruck(
              controller: _,
              hint: 'new_ticket_trucks_hint'.tr,
              validator: 'new_ticket_trucks_validator'.tr),
          SizedBox(
            height: h * 0.04,
          ),
          DropDownCustomer(
              controller: _,
              hint: 'new_ticket_customer_hint'.tr,
              validator: 'new_ticket_customer_validator'.tr),
          SizedBox(
            height: h * 0.04,
          ),
          _.customerID > 0
              ? DropDownProject(
                  controller: _,
                  hint: 'new_ticket_project_hint'.tr,
                  validator: 'new_ticket_project_validator'.tr)
              : Container(),
          SizedBox(
            height: h * 0.04,
          ),
          _.projectID > 0
              ? Column(
                  children: [
                    DropDownCompanyMan(
                      controller: _,
                      hint: 'new_ticket_companyman_hint'.tr,
                      validator: 'new_ticket_companyman_validator'.tr,
                    ),
                    SizedBox(
                      height: h * 0.04,
                    ),
                  ],
                )
              : Container(),
          DropDownOrigin(
              controller: _,
              hint: 'new_ticket_origin_hint'.tr,
              validator: 'new_ticket_origin_validator'.tr),
          SizedBox(
            height: h * 0.04,
          ),
          // select no longer in use
          // DropDownDestiny(
          //   controller: _,
          //   hint: 'new_ticket_destiny_hint'.tr,
          //   validator: 'new_ticket_destiny_validator'.tr,
          // ),
          // SizedBox(
          //   height: h * 0.04,
          // ),
          _creatTicketBtn(_),
          SizedBox(
            height: h * 0.1,
          ),
        ],
      ),
    );
  }

  _creatTicketBtn(AddNewTicketController _) {
    return RoundedLoadingButton(
      height: h * 0.07,
      width: w * 0.7,
      color: Colors.blue,
      controller: _.btnController1,
      onPressed: () async {
        await _.createNewTicket();
      },
      borderRadius: 15,
      child: Text(
        'new_ticket_start_ticket'.tr,
        style: ThemeWhite().labelBtnActions(Colors.white),
      ),
    );
  }
}
