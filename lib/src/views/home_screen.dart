import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:onax_app/src/controllers/connectionManagerController.dart';
import 'package:onax_app/src/controllers/homeController.dart';
import 'package:onax_app/src/views/components/home/cardInfoShift.dart';

import '../utils/sharePrefs/accountPrefs.dart';
import '../utils/styles/themWhite.dart';
import 'components/home/newTicketBtn.dart';
import 'components/home/oldTicketsList.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);
  late double h, w;
  @override
  Widget build(BuildContext context) {
    w = MediaQuery.of(context).size.width;
    h = MediaQuery.of(context).size.height;
    final HomeController _homeController = HomeController();
    return Scaffold(
      backgroundColor: Colors.white, //Colors.grey[200],
      body: GetBuilder<HomeController>(
        init: _homeController,
        builder: (_) => Container(
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: _content(_),
          ),
        ),
      ),
    );
  }

  _content(HomeController _) {
    return _.dataLoad == false
        ? SizedBox(
            width: w,
            height: h * 1.2,
            //margin: EdgeInsets.symmetric(horizontal: w * 0.02),
            child: Column(
              children: [
                ///card infor Worker & logo
                Container(
                    color: Colors.white,
                    width: w,
                    height: h * 0.23,
                    child: Column(
                      children: [
                        const Spacer(),

                        ///card logo
                        /* const Padding(
                    padding: EdgeInsets.only(left: 20),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Icon(
                        Icons.build,
                        size: 20,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: h * 0.02,
                  ),*/

                        ///card infor Worker
                        CardInfoShift(controller: _),
                        const Spacer(),
                      ],
                    ) //CardInfoShift(controller: _),
                    ),
                //label to load preview tickets
                Container(
                  width: w,
                  //height: h * 0.02,
                  //color: Colors.red,
                  margin: EdgeInsets.symmetric(horizontal: w * 0.075),
                  child: Text(
                    'home_old_tickets'.tr,
                    style: ThemeWhite().labelHomeTitles(Colors.black),
                  ),
                ),
                //Horizontal List view for all preview Tickets
                OldTicketList(
                  controller: _,
                ),
                SizedBox(
                  height: h * 0.02,
                ),
                //label add ticket
                Container(
                  width: w,
                  //height: h * 0.02,
                  //color: Colors.red,
                  margin: EdgeInsets.symmetric(horizontal: w * 0.075),
                  child: Text(
                    'home_new_ticket'.tr,
                    style: ThemeWhite().labelHomeTitles(Colors.black),
                  ),
                ),
                SizedBox(
                  height: h * 0.02,
                ),
                //buttom add create new ticket if not show Finish your current ticket to create a new.
                AccountPrefs.currentShift > 0 && AccountPrefs.hasOpenTicke == 0
                    ? NewTicketBtn(
                        controller: _,
                      )
                    : Container(),
              ],
            ),
          )
        : const Center(
            child: CircularProgressIndicator(),
          );
  }
}
