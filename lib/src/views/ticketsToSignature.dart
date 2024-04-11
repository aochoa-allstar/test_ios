import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:onax_app/src/controllers/ticketsSignatureController.dart';
import 'package:onax_app/src/repositories/models/ticketModel.dart';
import 'package:onax_app/src/views/components/ticketSingature/pfd_ticketSignature.dart';

import 'components/ticketSingature/ticketSignature.dart';

class TicketsToSignature extends StatelessWidget {
  TicketsToSignature({super.key});
  late double w, h;
  @override
  Widget build(BuildContext context) {
    w = MediaQuery.of(context).size.width;
    h = MediaQuery.of(context).size.height;
    final TicketSignatureController ticketSignatureController =
        TicketSignatureController();
    return Scaffold(
      appBar: AppBar(
          leading: IconButton(
        icon: Icon(Icons.arrow_back_ios),
        onPressed: () {
          Get.offNamed('/pages');
        },
      )),
      body: GetBuilder<TicketSignatureController>(
        init: ticketSignatureController,
        builder: (controller) => SafeArea(
            child: SizedBox(
          width: w,
          height: h,
          child: Column(
            children: [
              SizedBox(
                height: h * 0.01,
              ),
              Align(
                alignment: Alignment.center,
                child: SizedBox(
                  width: w * 0.95,
                  height: h * 0.05,
                  child: Text(
                    'menu_tickets_screen'.tr,
                    style: TextStyle(fontSize: 20),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              SizedBox(
                height: h * 0.02,
              ),
              //list of tickets
              _listOfTickets(controller),
            ],
          ),
        )),
      ),
    );
  }

  //listOfTickets
  _listOfTickets(TicketSignatureController controller) {
    late Widget? widget;
    if (controller.loadOldTickets == false) {
      widget = Container(
        width: w * 0.90,
        height: h * 0.75,
        //color: Colors.red,
        child: controller.listPrevTickets.length > 0
            ? _cardsTickets(controller)
            : Center(
                child: Text('menu_tickets_screen_noprevious'.tr),
              ),
      );
    } else {
      widget = Center(
        child: CircularProgressIndicator(),
      );
    }

    return widget;
  }

  _cardsTickets(TicketSignatureController controller) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: controller.listPrevTickets.length,
      scrollDirection: Axis.vertical,
      itemBuilder: (context, index) {
        return _cardTikcet(controller.listPrevTickets[index], controller);
      },
    );
  }

  _cardTikcet(TicketModel ticket, TicketSignatureController controller) {
    return GestureDetector(
      onTap: () {
        //code Action
        Get.to(() => PDFWorkOrderSignature(
              workerOrderID: ticket.id,
              prefix: ticket.prefix,
              parentController: controller,
            ));
      },
      child: Container(
        width: w,
        height: h * 0.05,
        margin: EdgeInsets.only(bottom: h * 0.01),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Colors.blue,
        ),
        child: Row(
          //mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Spacer(),
            SizedBox(
              // width: w * 0.2,
              child: Text(
                'Ticket #${ticket.prefix}',
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
}
