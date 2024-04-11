// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:onax_app/src/controllers/ticketSteperController.dart';
import 'package:onax_app/src/utils/sharePrefs/accountPrefs.dart';
import 'package:onax_app/src/utils/styles/themWhite.dart';

class HeaderTicketSteper extends StatelessWidget {
  final TicketSteperController controller;
  HeaderTicketSteper({Key? key, required this.controller}) : super(key: key);
  late double h, w;
  @override
  Widget build(BuildContext context) {
    w = MediaQuery.of(context).size.width;
    h = MediaQuery.of(context).size.height;

    return Container(
      width: w,
      height: h,
      //color: Colors.pink,
      child: Row(
        children: [
          _dateTicketCreateion(),
          _numberTicket(),
        ],
      ),
    );
  }

  _dateTicketCreateion() {
    return Container(
        decoration: const BoxDecoration(
            //color: Colors.pink,
            ),
        width: w * 0.5,
        height: h,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: h * 0.02),
            Text(
              'ticket_date'.tr,
              style: ThemeWhite().labelBtnActions(Colors.grey),
            ),
            Text(
              controller.dateTicket,
              style: ThemeWhite().dateTicket(Colors.black),
            ),
            SizedBox(height: h * 0.01),
            //CIRCULARs
            Column(
              children: [
                const SizedBox(
                  width: 12,
                  height: 12,
                  child: CircleAvatar(
                    backgroundColor: Colors.amberAccent,
                  ),
                ),
                const Padding(padding: EdgeInsets.only(top: 4, bottom: 4)),
                SizedBox(
                  width: 2,
                  height: 36,
                  child: Container(
                    color: Colors
                        .grey, //_currentLoad!.status == LoadStatus.finished
                    //? Theme.of(context).highlightColor
                    // : Theme.of(context).disabledColor,
                  ),
                ),
                const Padding(padding: EdgeInsets.only(top: 4, bottom: 4)),
                const SizedBox(
                  width: 12,
                  height: 12,
                  child: CircleAvatar(
                    backgroundColor: Colors.grey,
                    // backgroundColor: _currentLoad!.status == LoadStatus.finished
                    //     ? Theme.of(context).highlightColor
                    //     : Theme.of(context).disabledColor,
                  ),
                ),
              ],
            )
          ],
        ));
  }

  _numberTicket() {
    return SizedBox(
      width: w * 0.4,
      height: h,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          SizedBox(height: h * 0.02),
          //NUMER OF TICKET
          Container(
            decoration: const BoxDecoration(
                color: Color.fromRGBO(138, 138, 138, 0.25),
                borderRadius: BorderRadius.all(Radius.circular(8))),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              child: Text(
                // '#${AccountPrefs.hasOpenTicke}',
                '#${AccountPrefs.hasOpenTicketPrefix}',
              ),
            ),
          ),
          SizedBox(height: h * 0.01),
          //CURRENT TICKET LABEL
          Container(
            decoration: const BoxDecoration(
                color: Color.fromRGBO(17, 82, 253, 0.5),
                borderRadius: BorderRadius.all(Radius.circular(8))),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              child: Text(
                'ticket_current_ticket'.tr,
                style: TextStyle(color: Colors.white),
              ),
            ),
          )
        ],
      ),
    );
  }
}
