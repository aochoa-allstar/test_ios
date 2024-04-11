import 'dart:io';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:onax_app/src/controllers/ticketSteperController.dart';
import 'package:onax_app/src/utils/sharePrefs/accountPrefs.dart';

import 'package:onax_app/src/utils/styles/themWhite.dart';
import 'package:onax_app/src/views/components/home/creatTicket/dropDownAdditionalEquipment.dart';
import 'package:onax_app/src/views/components/home/creatTicket/dropDownSupervisor.dart';
import 'package:onax_app/src/views/components/textFields/inputDesing.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

class TicketSteperFinished extends StatelessWidget {
  final TicketSteperController controller;
  TicketSteperFinished({Key? key, required this.controller}) : super(key: key);
  late double h, w;

  @override
  Widget build(BuildContext context) {
    w = MediaQuery.of(context).size.width;
    h = MediaQuery.of(context).size.height;
    return controller.finishedTimestamp == ''
        ? SizedBox(
            width: w,
            //color: Colors.red,
            child: Column(
              children: [
                SizedBox(height: h * 0.02),
                Container(
                  height: h * 0.07,
                  width: w * 0.6,
                  child: DropDownSupervisor(
                    controller: controller,
                    hint: 'ticket_finish_supervisor_hint'.tr,
                    validator: 'ticket_finish_supervisor_validator'.tr,
                  ),
                ),
                SizedBox(height: h * 0.02),
                // Supervisor work hours
                Container(
                  height: h * 0.07,
                  width: w * 0.6,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: PhysicalModel(
                    color: Colors.white,
                    elevation: 5,
                    borderRadius: BorderRadius.circular(15),
                    child: TextField(
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: 'ticket_finish_supervisor_workhours'.tr,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                      onChanged: (value) {
                        controller.setSupervisorWorkHours(value);
                      },
                    ),
                  ),
                ),
                SizedBox(height: h * 0.02),
                (controller.imgFinish == null
                    ? SizedBox(height: 0)
                    : Flex(
                        direction: Axis.vertical,
                        children: [
                          Image.file(
                            File(controller.imgFinish!.path),
                            height: h * 0.2,
                          ),
                          SizedBox(height: h * 0.02),
                        ],
                      )),
                SizedBox(
                    width: w * 0.6,
                    child: PhysicalModel(
                      color: Colors.blue,
                      elevation: 5,
                      borderRadius: BorderRadius.circular(7),
                      child: TextButton(
                          onPressed: () async {
                            //metodo para acutalizar el departTimes y actualizar el steper a 1 s
                            //si todo sale bien.
                            await _showDialog(2);
                          },
                          child: Text(
                            'utils_upload_photo'.tr,
                            style: TextStyle(color: Colors.white),
                          )),
                    )),
                SizedBox(height: h * 0.02),
                //DESCRIPTIONS
                Container(
                  height: h * 0.07,
                  width: w * 0.6,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: PhysicalModel(
                    color: Colors.white,
                    elevation: 5,
                    borderRadius: BorderRadius.circular(15),
                    child: DropdownButtonFormField2(
                      dropdownMaxHeight: h * 0.2,
                      decoration: InputDecoration(
                        //Add isDense true and zero Padding.
                        //Add Horizontal padding using buttonPadding and Vertical padding by increasing buttonHeight instead of add Padding here so that The whole TextField Button become clickable, and also the dropdown menu open under The whole TextField Button.
                        isDense: true,
                        contentPadding: EdgeInsets.zero,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        //Add more decoration as you want here
                        //Add label If you want but add hint outside the decoration to be aligned in the button perfectly.
                      ),
                      isExpanded: true,
                      hint: Center(
                        child: Text(
                          'ticket_finish_description_hint'.tr,
                          style: TextStyle(fontSize: 14),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      icon: const Icon(
                        Icons.arrow_drop_down,
                        color: Colors.black45,
                      ),
                      iconSize: 30,
                      buttonHeight: 60,
                      buttonPadding: const EdgeInsets.only(left: 20, right: 10),
                      dropdownDecoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      items: controller.listDescriptions //cambiarlo
                          .map((item) => DropdownMenuItem<String>(
                                value: '${item.id}-${item.descrition}',
                                child: Center(
                                  child: Text(
                                    item.name, //ver para ponerlo en spanish
                                    style: const TextStyle(
                                      fontSize: 14,
                                      fontFamily: 'Poppins',
                                    ),
                                  ),
                                ),
                              ))
                          .toList(),
                      validator: (value) {
                        if (value == '') {
                          return 'ticket_finish_description_validator'.tr;
                        }
                        return null;
                      },
                      onChanged: (value) {
                        //Do something when changing the item if you want.
                        //controller.selectDestination(value);
                        late List<String> info = value.toString().split('-');
                        controller.selectDescription(info);
                      },
                      onSaved: (value) {
                        // controller.selectDestination(value);
                        late List<String> info = value.toString().split('-');
                        controller.selectDescription(info);
                      },
                    ),
                  ),
                ),

                SizedBox(height: h * 0.02),

                //DESCRIPTION INPUT
                // PhysicalModel(
                //   color: Colors.white,
                //   elevation: 5,
                //   borderRadius: BorderRadius.circular(15),
                //   child: Container(
                //     width: w * 0.6,
                //     height: h * 0.15,
                //     padding: EdgeInsets.symmetric(
                //         horizontal: w * 0.02, vertical: h * 0.01),
                //     decoration: BoxDecoration(
                //       borderRadius: BorderRadius.circular(15),
                //     ),
                //     child: Text(controller.descriptionText != ''
                //         ? controller.descriptionText
                //         : 'Description'),
                //   ),
                // ),
                _descriptionText(),
                SizedBox(height: h * 0.02),
                // Work hours
                Container(
                  height: h * 0.07,
                  width: w * 0.6,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: PhysicalModel(
                    color: Colors.white,
                    elevation: 5,
                    borderRadius: BorderRadius.circular(15),
                    child: TextField(
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: 'ticket_finish_workhours'.tr,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                      onChanged: (value) {
                        controller.setWorkHours(value);
                      },
                    ),
                  ),
                ),
                SizedBox(height: h * 0.02),
                Container(
                  height: h * 0.07,
                  width: w * 0.6,
                  child: DropDownAdditionalEquipment(
                    controller: controller,
                    hint: 'ticket_finish_additionalequip'.tr,
                    validator: 'ticket_finish_additionalequip'.tr,
                  ),
                ),
                SizedBox(height: h * 0.02),
                //ARRIVE BTN
                RoundedLoadingButton(
                  width: w * 0.3,
                  color: Colors.black,
                  controller: controller.btnfinished,
                  onPressed: () async {
                    AccountPrefs.statusConnection == true
                        ? await controller.updateFinishedTimeTicket()
                        : await controller.updateFinishedTimeTicketNotWifi();
                  },
                  borderRadius: 15,
                  child: Text(
                    'ticket_steps_finished'.tr,
                    style: ThemeWhite().labelBtnActions(Colors.white),
                  ),
                ),
              ],
            ),
          )
        : SizedBox(
            width: w,
            child: Column(
              children: [
                Center(
                  child: Text('utils_completed_at'.tr +
                      '${controller.finishedTimestamp}'),
                ),
                // controller.ticketID == AccountPrefs.hasOpenTicke
                controller.finishedTimestamp != ''
                    ? SizedBox(
                        width: w,
                        child: Column(
                          children: [
                            Text(
                              'ticket_finish_finished'.tr,
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(height: h * 0.01),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  width: w * 0.3,
                                  child: PhysicalModel(
                                    color: Colors.black,
                                    elevation: 5,
                                    borderRadius: BorderRadius.circular(7),
                                    child: TextButton(
                                        onPressed: () {
                                          //metodo para acutalizar el departTimes y actualizar el steper a 1 s
                                          //si todo sale bien.
                                          controller.endTicket();
                                        },
                                        child: Text(
                                          'home_new_ticket'.tr,
                                          style: TextStyle(color: Colors.white),
                                        )),
                                  ),
                                ),
                                RoundedLoadingButton(
                                  width: w * 0.3,
                                  color: Colors.black,
                                  controller: controller.btnEndShift,
                                  onPressed: () async {
                                    AccountPrefs.statusConnection == true
                                        ? await controller.endShift()
                                        : await controller.endShiftNOtWifi();
                                  },
                                  borderRadius: 7,
                                  child: Text(
                                    'ticket_finish_endshift'.tr,
                                    style: ThemeWhite()
                                        .labelBtnActions(Colors.white),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      )
                    : const SizedBox(),
              ],
            ));
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
                    child: const Icon(
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

  _descriptionText() {
    return PhysicalModel(
      color: Colors.white,
      elevation: 5,
      borderRadius: BorderRadius.circular(15),
      child: Container(
        width: w * 0.6,
        height: h * 0.15,
        padding: EdgeInsets.symmetric(horizontal: w * 0.02, vertical: h * 0.01),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
        ),
        child: TextFormField(
          maxLines: 4,
          cursorColor: Colors.white,
          controller: controller.descriptionControlText,
          textAlign: TextAlign.left,
          autofocus: false,
          style: const TextStyle(fontSize: 14.0, color: Colors.black),
          decoration: InputDesingOwn().textArea('ticket_finish_description'.tr),
        ),
        // Text(controller.descriptionText != ''
        //     ? controller.descriptionText
        //     : 'Description'),
      ),
    );
  }
}
