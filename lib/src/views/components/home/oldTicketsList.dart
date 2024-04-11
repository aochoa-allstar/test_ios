import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:onax_app/src/controllers/homeController.dart';
import 'package:onax_app/src/views/components/home/pdfHomePrev.dart';

import '../../../repositories/models/ticketModel.dart';

class OldTicketList extends StatelessWidget {
  final HomeController controller;
  OldTicketList({Key? key, required this.controller}) : super(key: key);
  late double h, w;
  @override
  Widget build(BuildContext context) {
    h = MediaQuery.of(context).size.height;
    w = MediaQuery.of(context).size.width;

    return Container(
      width: w,
      height: h * 0.225,

      //color: Colors.black,
      //margin: EdgeInsets.symmetric(vertical: w * 0.01),
      child: controller.loadOldTickets == true
          ? // change to false,
          _listTicket(context)
          : const CircularProgressIndicator(),
    );
  }

  _listTicket(BuildContext context) {
    Widget widget;
    return controller.listPrevTickets.length > 0
        ? ListView.builder(
            //reverse: true,
            //controller: controller.scrollController,
            shrinkWrap: true,
            itemCount: controller.listPrevTickets.length,
            physics: const PageScrollPhysics(),
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return _cardTicket(controller.listPrevTickets[index], context);
            })
        : Container(
            margin: EdgeInsets.symmetric(horizontal: w * 0.07),
            child: Text('home_prevtickets_notickets'.tr));
  }

  //remeber to pass the object ticket.
  _cardTicket(TicketModel ticket, BuildContext context) {
    return GestureDetector(
        onTap: () {
          Get.off(PDFTicketPrevHome(
            workerOrderID: ticket.id,
          ));
        },
        child: Container(
          width: w,
          height: h * 0.2,
          margin: EdgeInsets.symmetric(vertical: h * 0.01),
          padding: EdgeInsets.symmetric(horizontal: 30),
          decoration: BoxDecoration(
            /*border: Border.all(
          color: Colors.grey,
          style: BorderStyle.solid,
          width: 1,
        ),*/
            borderRadius: BorderRadius.circular(15),
          ),
          child: PhysicalModel(
            elevation: 5,
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.fromLTRB(16, 18, 16, 5),
                  child: Flex(
                    direction: Axis.horizontal,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flex(
                        direction: Axis.vertical,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'home_prevtickets_date'.tr,
                            style: TextStyle(
                                fontSize: 13, fontWeight: FontWeight.w500),
                          ),
                          SizedBox(height: 8),
                          Text(ticket.date.substring(0, 10),
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold)),
                        ],
                      ),
                      Flex(
                        direction: Axis.vertical,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Container(
                              decoration: BoxDecoration(
                                  color: Color.fromRGBO(138, 138, 138, 0.25),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(8))),
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 4),
                                child: Text(
                                  '#${ticket.prefix != null ? ticket.prefix : "undefined"}',
                                ),
                              )),
                          SizedBox(height: 8),
                          Container(
                              decoration: BoxDecoration(
                                  color: Color.fromRGBO(17, 82, 253, 0.5),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(8))),
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 4),
                                child: Text(
                                  ticket.customer + ' hrs: ${ticket.work_hours}'
                                  // == null
                                  //     ? 'util_unknow_mileage'.tr
                                  //     : 'util_mileage'.tr +
                                  //         ' ${load.mileage!.toString()}'
                                  ,
                                  style: TextStyle(color: Colors.white),
                                ),
                              ))
                        ],
                      )
                    ],
                  ),
                ),
                Container(
                  height: h * 0.10,

                  // width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.fromLTRB(20, 10, 0, 0),
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 50, 50, 50),
                    // color: Theme.of(context).cardColor,
                    borderRadius: BorderRadius.vertical(
                      bottom: (Radius.circular(16)),
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    // direction: Axis.horizontal,
                    children: [
                      Flex(
                        direction: Axis.vertical,
                        children: [
                          SizedBox(
                            width: 8,
                            height: 8,
                            child: CircleAvatar(
                              backgroundColor: Colors.white,
                            ),
                          ),
                          SizedBox(
                            width: 2,
                            height: 32,
                            child: Container(
                              color: Colors.grey,
                            ),
                          ),
                          SizedBox(
                            width: 8,
                            height: 8,
                            child: CircleAvatar(
                              backgroundColor: Colors.amber,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        width: 16,
                      ),
                      Flex(
                        mainAxisSize: MainAxisSize.max,
                        direction: Axis.vertical,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width,
                            child: Text(
                              ticket.arrivedTimesTimep.substring(0, 10),
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                          Divider(
                              // thickness: 1,
                              // color: Theme.of(context).disabledColor,
                              ),
                          Container(
                            width: MediaQuery.of(context).size.width,
                            child: Text(
                              ticket.finishedTimesTimep.substring(0, 10),
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          //   PhysicalModel(
          //     color: Colors.white,
          //     elevation: 5,
          //     borderRadius: BorderRadius.circular(15),
          //     child: Text('#${ticket.id != 0 ? ticket.id : ticket.idKey}'),
          //   ),
          // ),
        ));
  }
}
