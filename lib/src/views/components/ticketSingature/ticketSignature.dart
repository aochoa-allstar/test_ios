import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hand_signature/signature.dart';
import 'package:onax_app/src/controllers/ticketsSignatureController.dart';
import 'package:onax_app/src/repositories/models/ticketModel.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

class TicketSignature extends StatelessWidget {
  final TicketModel ticketModel;
  final TicketSignatureController parentController;
  TicketSignature({
    super.key,
    required this.ticketModel,
    required this.parentController,
  });
  late double w, h;
  @override
  Widget build(BuildContext context) {
    w = MediaQuery.of(context).size.width;
    h = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text('Ticket #${ticketModel.id}'),
        centerTitle: true,
        leading: IconButton(
            onPressed: () {
              //
              Get.back();
            },
            icon: Icon(Icons.arrow_back_ios)),
      ),
      body: GetBuilder<TicketSignatureController>(
        init: parentController,
        builder: (controller) => SafeArea(
          child: Align(
            alignment: Alignment.center,
            child: Container(
              // color: Colors.red,
              width: w * 0.8,
              child: Column(
                children: [
                  SizedBox(
                    height: h * 0.02,
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Container(
                      width: w * 0.4,
                      child: Text(
                        'Depart Time: ' + ticketModel.deparmentTimesTimep,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: h * 0.02,
                  ),
                  Align(
                    child: Container(
                      width: w * 0.4,
                      child: Text(
                        'Arrived Time: ' + ticketModel.arrivedTimesTimep,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: h * 0.02,
                  ),
                  Align(
                    child: Container(
                      width: w * 0.4,
                      child: Text(
                        'Finished Time: ' + ticketModel.finishedTimesTimep,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: h * 0.02,
                  ),
                  Align(
                    child: Container(
                      width: w * 0.4,
                      child: Text(
                        'Signature:',
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  _signature(),
                  SizedBox(
                    height: h * 0.02,
                  ),
                  _btnSave(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  _signature() {
    return Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
      height: h * 0.15,
      width: w * 0.8,
      child: PhysicalModel(
        color: Colors.white,
        elevation: 2,
        borderRadius: BorderRadius.circular(10),
        child: HandSignature(
          control: parentController.singnature1Control,
          color: Colors.blueGrey,
          width: 1.0,
          maxWidth: 2.5,
          type: SignatureDrawType.shape,
        ),
      ),
    );
  }

  _btnSave() {
    return RoundedLoadingButton(
      width: w * 0.3,
      color: Colors.blue,
      controller: parentController.btnSignature,
      onPressed: () async {
        await parentController.saveSignature(ticketModel.id);
        parentController.btnSignature.reset();
        // await controller.updateFinishedTimeTicket();
      },
      borderRadius: 15,
      child: Text(
        'Save',
        style: TextStyle(color: Colors.white),
      ),
    );
  }

  //END CLASS
}
